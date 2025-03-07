{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = import ./configuration.nix { inherit inputs; };
  in
  {
    darwinConfigurations."n45devs-pc" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
