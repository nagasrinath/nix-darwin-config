{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      "..." = "cd ../..";
      "vim" = "nvim";
      "ff" = "fastfetch";
    };
  };
}
