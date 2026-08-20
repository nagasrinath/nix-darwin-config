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
    -- base46's catppuccin isn't byte-exact to canonical Mocha; override the
    -- backgrounds specifically so they match Ghostty's Catppuccin Mocha theme
    M.base46 = {
      theme = "catppuccin",
      changed_themes = {
        catppuccin = {
          base_30 = {
            black = "#1e1e2e", -- canonical Mocha base
            darker_black = "#181825", -- canonical Mocha mantle
          },
          -- integrations/defaults.lua's Normal group reads base_16.base00
          -- directly rather than base_30.black, so it needs its own override
          base_16 = {
            base00 = "#1e1e2e",
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
