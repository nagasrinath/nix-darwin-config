{
  description = "Nix for macOS configuration";

  nixConfig = {
  };

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    areofyl-fetch = {
      url = "github:areofyl/fetch";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs-darwin,
    darwin,
    home-manager,
    ...
  }: let
    username = "naga";
    useremail = "nagasrinath@proton.me";
    system = "aarch64-darwin";
    hostname = "mac";

    # Window management mode. Set to either "tiling" or "normal":
    #   tiling -> AeroSpace (home/aerospace.nix) enabled, dock hidden
    #             (long delay), menu bar always hidden.
    #   normal -> stock macOS dock, menu bar hidden only in fullscreen
    wmMode = "tiling";

    # Which tiling WM engine to use when wmMode == "tiling". Set to either
    # "aerospace" or "rift":
    #   aerospace -> AeroSpace (home/aerospace.nix)
    #   rift      -> Rift (home/rift.nix), private-API Rust WM trial
    wmEngine = "rift";

    specialArgs =
      inputs
      // {
        inherit username useremail hostname wmMode wmEngine;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/fonts.nix
        ./modules/host-users.nix
        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.backupFileExtension = "bak";
          home-manager.users.${username} = import ./home;
        }
      ];
    };

    # Add checks for formatting and system configuration
    checks."${system}" = {
      formatting = nixpkgs-darwin.legacyPackages.${system}.runCommand "check-formatting" {} ''
        ${self.formatter.${system}}/bin/alejandra --check ${self}
        touch $out
      '';
    };

    formatter.${system} = nixpkgs-darwin.legacyPackages.${system}.alejandra;
  };
}
