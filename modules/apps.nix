{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    just
  ];
  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    masApps = {
      "Whatsapp" = 310633997;
      "Davinci Resolve" = 571213070;
      "Speediness" = 1596706466;
    };

    taps = [
      "nikitabobko/tap"
      "koekeishiya/formulae"
      "grishka/grishka"
      "mobile-dev-inc/tap"
      "thusvill/livewallpaper"
    ];

    brews = [
      "mas"
      "ruby"
      "scrcpy"
      "node"
      "npm"
      "postgrest"
      "openjdk"
    ];

    casks = [
      # Browsers
      "arc"
      "brave-browser"
      "firefox"
      "google-chrome"
      "tor-browser"

      # Development
      "android-studio"
      "cursor"
      "datagrip"
      "goland"
      "intellij-idea"
      "iterm2"
      "jetbrains-toolbox"
      "mongodb-compass"
      "orbstack"
      "postman"
      "pycharm"
      "sequel-ace"
      "visual-studio-code"
      "zed"

      # Communication
      "discord"
      "element"
      "signal"
      "slack"
      "telegram"

      # Productivity & Utilities
      "1password"
      "1password-cli"
      "bitwarden"
      "blip"
      "chatgpt"
      "cloudflare-warp"
      "cyberduck"
      "free-download-manager"
      "keka"
      "notion"
      "raycast"
      "windscribe"

      # Media & Design
      "gimp"
      "iina"
      "inkscape"
      "livewallpaper"
      "obs"
      "spotify"

      # System & Others
      "font-fantasque-sans-mono-nerd-font"
      "ghostty"
      "playcover-community"
      "transmission"
      "utm"
    ];
  };
}
