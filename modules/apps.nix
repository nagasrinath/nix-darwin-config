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
      # Remove any brew/cask/tap not declared here, including app data/configs
      cleanup = "zap";
    };

    masApps = {
      "Whatsapp" = 310633997;
      "WireGuard" = 1451685025;
      "Windows App" = 1295203466;
    };

    # Homebrew 6 requires explicit trust for non-official taps
    # (HOMEBREW_REQUIRE_TAP_TRUST); trusted = true embeds `trusted: true`
    # into the generated Brewfile tap entries.
    taps = [
      {
        name = "nikitabobko/tap";
        trusted = true;
      }
      {
        name = "grishka/grishka";
        trusted = true;
      }
      {
        name = "mobile-dev-inc/tap";
        trusted = true;
      }
      {
        name = "vincelwt/tap";
        trusted = true;
      }
      {
        name = "nrwl/tap";
        trusted = true;
      }
      {
        name = "anomalyco/tap";
        trusted = true;
      }
      {
        name = "ampcode/tap";
        trusted = true;
      }
      {
        name = "d99kris/nchat";
        trusted = true;
      }
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
      "container"
      "fabric-ai"
      "herdr"
      "trash"
      "mole"
      "mdv"
      "polygraph"
      "anomalyco/tap/opencode"
      "ampcode/tap/ampcode"
      "displayplacer"
      "git-filter-repo"
      "happy-coder"
      "rust"
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
      "cursor"
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
