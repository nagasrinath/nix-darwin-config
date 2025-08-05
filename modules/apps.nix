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
    };

    taps = [
      "homebrew/services"
      "nikitabobko/tap"
      "koekeishiya/formulae"
      "grishka/grishka"
      "mobile-dev-inc/tap"
    ];

    brews = [
      "mas"
      "ruby"
      "maestro"
      "scrcpy"
      "node"
      "npm"
    ];

    casks = [
      "spotify"
      "bitwarden"
      "mullvad-browser"
      "ghostty"
      "librewolf"
      "raycast"
      "intellij-idea"
      "vmware-fusion"
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
      "tailscale"
      "android-studio"
      "obs"
      "eloston-chromium"
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
    ];
  };
}
