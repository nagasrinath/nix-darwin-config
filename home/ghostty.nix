{...}: {
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      theme = "GruvboxDarkHard"

      shell-integration = detect
  
      font-family = "Inconsolata Nerd Font"
      font-size = 15
     
      cursor-style = underline
    
      window-padding-x = 4
      window-padding-y = 4
      window-padding-balance = true
      window-height = 50
      window-width = 50
     
      macos-titlebar-style = hidden
      macos-option-as-alt = true
     
      term = "xterm-256color"
    '';
  };
}
