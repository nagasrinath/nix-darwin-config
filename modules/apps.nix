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
      "acsandmann/tap"
      "ampcode/tap"
      "1jehuang/jcode"
      "d99kris/nchat"
    ];

    brews = [
      "nchat"
      "mas"
      "ruby"
      "scrcpy"
      "node"
      "npm"
      "postgrest"
      "openjdk"
      "openvpn"
      "rift"
      "container"
      "fabric-ai"
      "herdr"
      "trash"
      "mole"
      "mdv"
      "polygraph"
      "anomalyco/tap/opencode"
      "ampcode/tap/ampcode"
      "jcode"
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
      "yaak"
      "supacode"
      "visual-studio-code"
      "zed"
      "claude-code"
      "obsidian"
      "claude"
      "codex"
      "copilot-cli"

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
      "wispr-flow"
      "vincelwt/tap/gloomberb"
      "itsycal"

      # Media & Design
      "figma"
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
      "font-sf-mono-nerd-font-ligaturized"
      "ghostty"
      "transmission"
      "utm"
      "steam"
      "xonotic"
      "anydesk"
    ];
  };
}
