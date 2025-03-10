{ pkgs, ... }: {
  homebrew = {
    enable = true;
    global.brewfile = true;
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
      upgrade = true;
    };
    taps = [ "nikitabobko/tap" ];
    brews = [ "mas" ];
    masApps = {
      "Simplenote" = 692867256;
      "Photomator" = 1444636541;
      "Wireguard" = 1451685025;
      "Davinci Resolve" = 571213070;
      "Amphetamine" = 937984704;
      "Whatsapp" = 310633997;
    };
    casks = [
      "ghostty" "librewolf" "ollamac" "jan" "vivaldi" "raycast"
      "intellij-idea" "pycharm" "clion" "vmware-fusion"
      "proton-pass" "proton-mail-bridge" "proton-drive" "protonvpn"
      "proton-mail" "telegram" "arc" "brave-browser"
      "iina" "discord" "signal" "element" "dbeaver-community"
      "inkscape" "zed" "utm" "gimp" "spotify" "zen-browser"
      "audacity" "transmission" "wireshark" "tailscale"
      "android-studio" "obs" "eloston-chromium" "postman" "vlc"
      "cyberduck" "openvpn-connect" "jordanbaird-ice" "steam" "motrix"
    ];
  };
}
