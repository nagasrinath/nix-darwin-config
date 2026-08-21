{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  home.activation.installNvChad = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d "$HOME/.config/nvim/.git" ]; then
          ${pkgs.git}/bin/git clone https://github.com/NvChad/starter "$HOME/.config/nvim" --depth 1
        fi
        chadrc="$HOME/.config/nvim/lua/chadrc.lua"
        newChadrc="$(cat <<'EOF'
    ---@type ChadrcConfig
    local M = {}
    -- base46's gruvbox_light isn't byte-exact to canonical Gruvbox Light
    -- Medium; override the backgrounds specifically so they match Ghostty's
    -- GruvboxLight theme
    M.base46 = {
      theme = "gruvbox_light",
      changed_themes = {
        gruvbox_light = {
          base_30 = {
            black = "#fbf1c7", -- canonical light0 (medium) bg
            darker_black = "#ebdbb2", -- canonical light1 (panel bg)
          },
          -- integrations/defaults.lua's Normal group reads base_16.base00
          -- directly rather than base_30.black, so it needs its own override
          base_16 = {
            base00 = "#fbf1c7",
          },
        },
      },
    }
    M.ui = { statusline = { theme = "vscode_colored" } }
    return M
    EOF
    )"
        # nvchad/base46 only recompiles its color cache on plugin
        # install/update (lazy.nvim's `build` hook) - never when chadrc.lua's
        # theme setting changes. Force a recompile whenever it does.
        if [ ! -f "$chadrc" ] || [ "$(cat "$chadrc")" != "$newChadrc" ]; then
          echo "$newChadrc" >"$chadrc"
          ${pkgs.neovim}/bin/nvim --headless "+lua require('base46').compile()" "+quitall" 2>/dev/null || true
        fi
  '';
}
