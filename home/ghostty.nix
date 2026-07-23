{...}: {
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      theme = Catppuccin Mocha

      shell-integration = detect

      font-family = "IoskeleyMonoTerm Nerd Font"
      font-size = 13

      cursor-style = underline

      window-padding-x = 10
      window-padding-y = 10
      window-padding-balance = true

      background-blur = true
      background-blur = macos-glass-regular
      background-opacity = 0.85

      macos-titlebar-style = hidden
      macos-option-as-alt = true

      term = "xterm-256color"
    '';
  };
}
