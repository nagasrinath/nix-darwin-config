{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "
      set fish_greeting
      export MANPAGER='nvim +Man!'";
    shellAliases = {
      "..." = "cd ../..";
      "ff" = "fastfetch";

      # Nix aliases
      "nd" = "nix develop";
      "nb" = "nix build";
      "nr" = "nix run";
      "ns" = "nix shell";
      "dr" = "darwin-rebuild switch --flake ~/.config/nix";
    };
  };
}
