{...}: {
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      theme = "GruvboxDarkHard"

      shell-integration = detect

      font-family = "ComicShannsMono Nerd Font"
      # font-size = 15

      cursor-style = underline

      window-padding-x = 4
      window-padding-y = 4
      window-padding-balance = true

      macos-titlebar-style = transparent
      macos-option-as-alt = true

      term = "xterm-256color"
    '';
  };
}
