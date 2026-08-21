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
      "WireGuard" = 1451685025;
      "Windows App" = 1295203466;
    };

    taps = [
      "nikitabobko/tap"
      "grishka/grishka"
      "mobile-dev-inc/tap"
      "vincelwt/tap"
      "nrwl/tap"
      "anomalyco/tap"
    ];

    brews = [
      "mas"
      "ruby"
      "scrcpy"
      "node"
      "npm"
      "postgrest"
      "openjdk"
      "openvpn"
      "copilot"
      "container"
      "fabric-ai"
      "herdr"
      "trash"
      "mole"
      "mdv"
      "polygraph"
      "anomalyco/tap/opencode"
    ];

    casks = [
      # Browsers
      "brave-browser"
      "firefox"
      "google-chrome"
      "helium-browser"
      "tor-browser"
      "thebrowsercompany-dia"

      # Development
      "jetbrains-toolbox"

      "orbstack"
      "postman"
      "sequel-ace"
      "tableplus"
      "supacode"
      "visual-studio-code"
      "zed"
      # "claude-code"
      "obsidian"
      # "claude"

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
      "tailscale-app"
      "vincelwt/tap/gloomberb"
      "itsycal"

      # Media & Design
      "gimp"
      "iina"
      "obs"
      "spotify"

      # System & Others
      "font-sf-pro"
      "nikitabobko/tap/aerospace"
      "font-fantasque-sans-mono-nerd-font"
      "font-iosevka-nerd-font"
      "font-monocraft-nerd-font"
      "ghostty"
      "transmission"
      "utm"
      "steam"
      "xonotic"
    ];
  };
}
