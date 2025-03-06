{ inputs, ... }:

{
  imports = [
    ./system-packages.nix
    ./fonts.nix
    ./homebrew.nix
    ./nix-settings.nix
    ./programs.nix
    ./security.nix
    ./system-defaults.nix
  ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
