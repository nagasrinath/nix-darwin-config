{...}: {
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      #theme = "tokyonight"
      config-file = themes/OneDark

      shell-integration = detect

      font-family = "JetBrainsMono Nerd Font"
      font-size = 15

      cursor-style = underline

      window-padding-x = 10
      window-padding-y = 10
      window-padding-balance = true

      macos-titlebar-style = tabs
      macos-option-as-alt = true

      term = "xterm-256color"
    '';
  };
}
