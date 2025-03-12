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
      "Wireguard" = 1451685025;
      "Davinci Resolve" = 571213070;
      "Amphetamine" = 937984704;
      "Whatsapp" = 310633997;
    };

    taps = [
      "homebrew/services"
      "nikitabobko/tap"
      "koekeishiya/formulae"
    ];

    brews = [
      "mas"
      "yabai"
      "skhd"
    ];

    casks = [
      "ghostty"
      "librewolf"
      "raycast"
      "intellij-idea"
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
      "openvpn-connect"
      "jordanbaird-ice"
      "motrix"
    ];
  };
}
