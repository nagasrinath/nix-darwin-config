{pkgs, ...}: {
  home.packages = with pkgs; [
    tokei
    zip
    xz
    unzip
    p7zip
    ripgrep
    jq
    fzf
    aria2
    nmap
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    caddy
    gnupg
    glow
    wget
    fastfetch
    dust
    ollama
    android-tools
    onefetch
    gh
    lua-language-server
    htop
    nixd
    ffmpeg
    macchina
    spotify-player
    gping
    pipx
    csvkit
    ruff
    python312
    python312Packages.python-lsp-server
    python312Packages.jedi-language-server
    helix-gpt
    go
    gopls
    golangci-lint-langserver
    delve
    rclone
  ];

  services = {
    ollama = {
      #enable = true;
    };
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      # vimAlias = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableFishIntegration = true;
    };

    nushell = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "OneDark";
      };
    };
  };
}
