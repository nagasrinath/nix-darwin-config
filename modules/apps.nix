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
      "Bear" = 1091189122;
      "WireGuard" = 1451685025;
      "Windows App" = 1295203466;
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
      "fabric-ai"
      "herdr"
      "trash"
      "mole"
    ];

    casks = [
      # Browsers
      "brave-browser"
      "firefox"
      "firefox@nightly"
      "google-chrome"
      "helium-browser"
      "tor-browser"
      "zen"
      "thebrowsercompany-dia"

      # Development
      "cursor"
      "jetbrains-toolbox"

      "orbstack"
      "postico"
      "postman"
      "sequel-ace"
      "supacode"
      "visual-studio-code"
      "zed"
      "claude-code"
      "obsidian"
      "claude"

      # Communication
      "superhuman"
      "discord"
      "microsoft-teams"
      "telegram"
      "signal"

      # Productivity & Utilities
      "1password"
      "1password-cli"
      "blip"
      "chatgpt"
      "google-gemini"
      "free-download-manager"

      "raycast"
      "tailscale-app"
      "nordvpn"
      "obscura-vpn"

      # Media & Design
      "gimp"
      "iina"
      "obs"
      "spotify"

      # System & Others
      "sf-symbols"
      "font-sf-pro"
      "karabiner-elements"
      "nikitabobko/tap/aerospace"
      "font-fantasque-sans-mono-nerd-font"
      "font-iosevka-nerd-font"
      "font-monocraft-nerd-font"
      "ghostty"
      "kitty"
      "alacritty"
      "transmission"
      "utm"
      "anydesk"
      "steam"
      "xonotic"
    ];
  };
}
