{
  username,
  wmMode,
  wmEngine,
  lib,
  ...
}: {
  imports =
    [
      ./shell.nix
      ./core.nix
      ./starship.nix
      ./ghostty.nix
      ./helix.nix
      ./git.nix
      ./direnv.nix
      ./nix-index.nix
      ./neovim.nix
      ./borders.nix
      ./kitty.nix
      ./alacritty.nix
      ./wm-mode.nix
    ]
    ++ lib.optionals (wmMode == "tiling") (
      [./sketchybar.nix]
      ++ (
        if wmEngine == "yabai"
        then [./yabai.nix]
        else [./aerospace.nix]
      )
    );

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
