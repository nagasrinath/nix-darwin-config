{ ... }:

{
  homebrew = {
    enable = true;
    global.brewfile = true;
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "mas"
    ];
    masApps = {
      Simplenote = 692867256;
      Photomator = 1444636541;
      Wireguard = 1451685025;
      "Davinci Resolve" = 571213070;
      Amphetamine = 937984704;
    };
    casks = [
      "ghostty"
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
      "whatsapp"
      "telegram"
      "arc"
      "brave-browser"
      "iina"
      "discord"
      "signal"
      "element"
      "dbeaver-community"
      "inkscape"
      "zed"
      "vscodium"
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
      "chatgpt"
      "orion"
      "eloston-chromium"
      "postman"
      "vlc"
      "hiddenbar"
      "cyberduck"
      "playcover-community"
      "openvpn-connect"
      "jordanbaird-ice"
      "fleet"
      "steam"
      "motrix"
      "aerospace"
    ];
  };
}
