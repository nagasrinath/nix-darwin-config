{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    just
    git
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
    ];

    brews = [
      "mas"
      "ruby"
      "scrcpy"
      "node"
      "npm"
      "postgrest"
      "openjdk"
      "npm"
    ];

    casks = [
      "chatgpt"
      "playcover-community"
      "rustdesk"
      "bitwarden"
      "zen"
      "windscribe"
      "free-download-manager"
      "1password"
      "1password-cli"
      "spotify"
      "bitwarden"
      "mullvad-browser"
      "ghostty"
      "librewolf"
      "raycast"
      "intellij-idea"
      "telegram"
      "arc"
      "brave-browser"
      "tor-browser"
      "iina"
      "discord"
      "signal"
      "element"
      "inkscape"
      "zed@preview"
      "utm"
      "gimp"
      "firefox"
      "firefox@developer-edition"
      "transmission"
      "android-studio"
      "obs"
      "postman"
      "sequel-ace"
      "datagrip"
      "cloudflare-warp"
      "chatgpt"
      "rapidapi"
      "mongodb-compass"
      "goland"
      "orbstack"
      "keka"
      "localsend"
      "notion"
      "visual-studio-code"
      "google-chrome"
      "hiddenbar"
      "neardrop"
      "plex"
      "libreoffice"
      "pycharm"
      "blip"
      "keepassxc"
      "cyberduck"
      "thunderbird"
      "cursor"
      "windscribe"
      "slack"
      "trae"
      "obscura-vpn"
      "jetbrains-toolbox"
      "yaak"
      "iterm2"
      "font-fantasque-sans-mono-nerd-font"
      "skim"
      "eclipse-ide"
    ];
  };
}
