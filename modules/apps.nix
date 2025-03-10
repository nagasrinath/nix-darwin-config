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
      "Simplenote" = 692867256;
      "Photomator" = 1444636541;
      "Wireguard" = 1451685025;
      "Davinci Resolve" = 571213070;
      "Amphetamine" = 937984704;
      "Whatsapp" = 310633997;
    };

    taps = [
      "homebrew/services"
      "nikitabobko/tap"
    ];

    brews = [
      "mas"
    ];

    casks = [
      "ghostty"
      "librewolf"
      "ollamac"
      "jan"
      "vivaldi"
      "raycast"
      "intellij-idea"
      "pycharm"
      "clion"
      "vmware-fusion"
      "proton-pass"
      "proton-mail-bridge"
      "proton-drive"
      "protonvpn"
      "proton-mail"
      "telegram"
      "arc"
      "brave-browser"
      "tor-browser"
      "iina"
      "discord"
      "signal"
      "element"
      "dbeaver-community"
      "inkscape"
      "zed"
      "utm"
      "gimp"
      "spotify"
      "zen-browser"
      "audacity"
      "transmission"
      "wireshark"
      "tailscale"
      "android-studio"
      "obs"
      "eloston-chromium"
      "postman"
      "vlc"
      "cyberduck"
      "openvpn-connect"
      "jordanbaird-ice"
      "steam"
      "motrix"
    ];
  };
}
