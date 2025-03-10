{...}: {
  programs.ghostty = {
    # enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "GruvboxDarkHard";
      font-family = "Inconsolata Nerd Font";
      font-size = 15;
      cursor-style = "underline";
      window-padding-x = 4;
      window-padding-y = 4;
      window-padding-balance = true;
      macos-titlebar-proxy-icon = "hidden";
      macos-titlebar-style = "transparent";
      term = "xterm-256color";
    };
  };
}
