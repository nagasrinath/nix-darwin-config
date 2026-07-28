{...}: {
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      theme = Catppuccin Mocha

      shell-integration = detect

      font-family = "Monocraft"
      font-size = 13

      cursor-style = underline

      window-padding-x = 10
      window-padding-y = 10
      window-padding-balance = true

      macos-titlebar-style = hidden
      macos-option-as-alt = true

      term = "xterm-256color"
    '';
  };
}
