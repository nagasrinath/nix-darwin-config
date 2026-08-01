{...}: {
  home.file.".config/borders/bordersrc" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      options=(
        style=round
        width=4.0
        hidpi=on
        active_color=0xff3c3836
        inactive_color=0x00000000
      )
      borders "''${options[@]}"
    '';
  };
}
