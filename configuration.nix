{ pkgs, ... }: {
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
    python3 ollama android-tools scrcpy bat onefetch gh lua-language-server htop nixd
  ];
  environment.shells = [pkgs.fish pkgs.zsh];
  environment.shellAliases = { ll = "ls -l"; };

  users.users.me = {
    home = "/Users/me";
  };

  fonts.packages = [
    pkgs.fantasque-sans-mono
    pkgs.maple-mono-NF
    pkgs.nerd-fonts.inconsolata
  ];

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
}
