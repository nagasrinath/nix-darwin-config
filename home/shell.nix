{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = "
      set fish_greeting
      fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
      export MANPAGER='nvim +Man!'

      set -l cat_symbols 😼 😹 🙀 😿 😽 😾 😺 😻 😸
      set -l cat (random choice \$cat_symbols)
      set -l cfg_file (mktemp -t starship)
      string replace STARSHIP_CAT_PLACEHOLDER \$cat -- (cat \$HOME/.config/starship.toml) > \$cfg_file
      set -gx STARSHIP_CONFIG \$cfg_file";
    shellAliases = {
      "..." = "cd ../..";
      "ff" = "fastfetch";
      "loc" = "tokei";

      # Nix aliases
      "nd" = "nix develop";
      "nb" = "nix build";
      "nr" = "nix run";
      "ns" = "nix shell";
      "dr" = "darwin-rebuild switch --flake ~/.config/nix";
    };
  };
}
