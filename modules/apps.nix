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
      cleanup = "none";
    };

    masApps = {
      "Whatsapp" = 310633997;
      "Davinci Resolve" = 571213070;
      "Bear" = 1091189122;
    };

    taps = [
      "nikitabobko/tap"
      "grishka/grishka"
      "mobile-dev-inc/tap"
    ];

    brews = [
      "mas"
      "ruby"
      "scrcpy"
      "node"
      "npm"
      "postgrest"
      "openjdk"
      "copilot"
      "happy-coder"
    ];

    casks = [
      # Browsers
      "brave-browser"
      "firefox"
      "google-chrome"
      "helium-browser"

      # Development
      "jetbrains-toolbox"
      "orbstack"
      "postman"
      "zed"
      "claude-code"
      "obsidian"
      "flutter"
      "claude"

      # Communication
      "discord"
      "telegram"
      "signal"

      # Productivity & Utilities
      "1password"
      "1password-cli"
      "blip"
      "chatgpt"
      "free-download-manager"
      "raycast"
      "windscribe"

      # Media & Design
      "gimp"
      "iina"
      "obs"
      "spotify"

      # System & Others
      "font-fantasque-sans-mono-nerd-font"
      "font-iosevka-nerd-font"
      "ghostty"
      "playcover-community"
      "transmission"
      "utm"
    ];
  };
}
