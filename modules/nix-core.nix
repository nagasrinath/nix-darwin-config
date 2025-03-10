
{ pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nix.enable = false;

  nix.package = pkgs.nix;

  nix.settings = {
    auto-optimise-store = true;
  };
}
