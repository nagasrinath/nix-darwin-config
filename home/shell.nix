{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "
      set fish_greeting
      export MANPAGER='nvim +Man!'";
    shellAliases = {
      "..." = "cd ../..";
      "ff" = "fastfetch";
    };
  };
}
