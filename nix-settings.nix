{ ... }:

{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
  nixpkgs.config.allowUnfree = true;
}
