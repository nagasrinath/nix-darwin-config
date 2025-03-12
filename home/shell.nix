{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    shellAliases = {
      "..." = "cd ../..";
      "vim" = "hx";
      "ff" = "fastfetch";
      "ping" = "gping";
    };
  };
}
