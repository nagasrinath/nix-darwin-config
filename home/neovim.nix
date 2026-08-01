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
        cat > "$HOME/.config/nvim/lua/chadrc.lua" << 'EOF'
    ---@type ChadrcConfig
    local M = {}
    M.base46 = { theme = "gruvbox" }
    return M
    EOF
  '';
}
