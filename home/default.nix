{username, ...}: {
  imports = [
    ./shell.nix
    ./core.nix
    ./starship.nix
    ./ghostty.nix
    ./yabai.nix
    ./helix.nix
    ./zed.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
