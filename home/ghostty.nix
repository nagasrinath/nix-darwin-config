{...}: {
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      theme = Gruvbox Dark Hard

      shell-integration = detect

      font-family = "IoskeleyMonoTerm Nerd Font"
      font-size = 15

      cursor-style = underline

      window-padding-x = 15
      window-padding-y = 15
      window-padding-balance = true

      macos-titlebar-style = hidden
      macos-option-as-alt = true

      term = "xterm-256color"
    '';
  };
}
