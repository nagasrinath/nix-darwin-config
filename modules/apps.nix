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
      "WireGuard" = 1451685025;
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
      "container"
    ];

    casks = [
      # Browsers
      "brave-browser"
      "firefox"
      "google-chrome"
      "helium-browser"
      "tor-browser"

      # Development
      "cursor"
      "jetbrains-toolbox"

      "orbstack"
      "postman"
      "sequel-ace"
      "supacode"
      "visual-studio-code"
      "zed"
      "claude-code"
      "obsidian"
      "claude"

      # Communication
      "discord"
      "linear"
      "telegram"
      "signal"

      # Productivity & Utilities
      "1password"
      "1password-cli"
      "blip"
      "chatgpt"
      "free-download-manager"

      "raycast"
      "tailscale-app"
      "todoist-app"
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
