{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    shellAliases = {
      "..." = "cd ../..";
      "vim" = "nvim";
      "ff" = "fastfetch";
    };
  };
}
