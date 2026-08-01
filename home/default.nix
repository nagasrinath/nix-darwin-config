{username, ...}: {
  imports = [
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
    ./aerospace.nix
    ./kitty.nix
    ./alacritty.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
