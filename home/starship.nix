{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableInteractive = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[󰁔](bold green)";
        error_symbol = "[󰅖](bold red)";
        vimcmd_symbol = "[󰁍](bold green)";
      };
    };
  };
}
