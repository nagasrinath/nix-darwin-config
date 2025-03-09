# $HOME/Nix/configuration.nix
{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let username = "me";
    
    darwinConfig = { pkgs, config, ... }: {
      system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.settings.experimental-features = "nix-command flakes";
      nix.enable = false;
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
      nixpkgs.config.allowUnfree = true;
      
      environment.systemPackages = with pkgs; [
        vim starship neovim eza dust fastfetch wget podman podman-compose
        python3 ollama android-tools scrcpy bat onefetch gh lua-language-server htop
      ];
      environment.shells = [pkgs.fish pkgs.zsh];
      environment.shellAliases = { ll = "ls -l"; };
      
      users.users.${username} = {
        name = username;
        home = "/Users/${username}";
      };

      fonts.packages = [
        pkgs.fantasque-sans-mono
        pkgs.maple-mono-NF
        pkgs.nerd-fonts.inconsolata
      ];

      homebrew = {
        enable = true;
        global.brewfile = true;
        onActivation = {
          cleanup = "uninstall";
          autoUpdate = true;
          upgrade = true;
        };
        taps = [ "nikitabobko/tap" ];
        brews = [ "mas" ];
        masApps = {
          Simplenote = 692867256;
          Photomator = 1444636541;
          Wireguard = 1451685025;
          "Davinci Resolve" = 571213070;
          Amphetamine = 937984704;
        };
        casks = [
          "ghostty" "librewolf" "ollamac" "jan" "vivaldi" "raycast"
          "intellij-idea" "pycharm" "clion" "vmware-fusion"
          "proton-pass" "proton-mail-bridge" "proton-drive" "protonvpn"
          "proton-mail" "whatsapp" "telegram" "arc" "brave-browser"
          "iina" "discord" "signal" "element" "dbeaver-community"
          "inkscape" "zed" "zed@preview" "vscodium" "utm" "gimp"
          "spotify" "zen-browser" "audacity" "transmission" "wireshark"
          "tailscale" "android-studio" "obs" "chatgpt" "orion"
          "eloston-chromium" "postman" "vlc" "hiddenbar" "cyberduck"
          "playcover-community" "openvpn-connect" "jordanbaird-ice"
          "fleet" "steam" "motrix" "aerospace"
        ];
      };

      programs.fish.enable = true;
      programs.zsh.enable = true;
      security.pam.services.sudo_local.touchIdAuth = true;

      system.defaults = {
        dock = {
          autohide = true;
          mru-spaces = false;
          orientation = "bottom";
          show-recents = true;
        };
        finder = {
          AppleShowAllExtensions = true;
          FXPreferredViewStyle = "clmv";
        };
        loginwindow.LoginwindowText = "BE HAPPY :-)";
        screencapture.location = "~/Pictures/Screenshots";
        screensaver.askForPasswordDelay = 10;
        NSGlobalDomain.NSWindowShouldDragOnGesture = true;
      };
    };
    
    homeConfig = { pkgs, ... }: {
      home.stateVersion = "23.05";
      home.username = username;
      home.homeDirectory = "/Users/${username}";
      
      home.packages = [ pkgs.neofetch ];
      home.file = { };
      home.sessionVariables = { };
      programs.home-manager.enable = true;
    };
  in
  {
    darwinConfigurations."n45devs-pc" = nix-darwin.lib.darwinSystem {
      modules = [
        darwinConfig
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = homeConfig;
        }
      ];
    };
  };
}
