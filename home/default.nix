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
      ./wm-mode.nix
      ./rift.nix
      ./fetch.nix
    ]
    ++ lib.optionals (wmMode == "tiling") [
      ./aerospace.nix
    ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # silence macOS "Last login" banner in new terminal windows
    file.".hushlogin".text = "";

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
