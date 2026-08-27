{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableInteractive = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = false;

      # the separating space lives in this group, not in directory.format,
      # so it's dropped along with $directory when $directory is empty (home)
      format = "($directory )$character";

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[󰅖](bold red)";
        vimcmd_symbol = "[󰁍](bold green)";
      };

      directory = {
        truncation_length = 1;
        read_only = " 󰌾";
        # drop the module's own built-in trailing space so it's truly
        # empty (not just blank text) when substituted away below
        format = "[$path]($style)[$read_only]($read_only_style)";
        # blank out the home symbol so the prompt is bare "λ" in $HOME
        substitutions."~" = "";
      };
    };
  };
}
