{pkgs, ...}: {
  home.packages = with pkgs; [
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
    podman
    podman-compose
    ollama
    android-tools
    scrcpy
    onefetch
    gh
    lua-language-server
    htop
    nixd
    ffmpeg
    macchina
    spotify-player
    gping
  ];

  services = {
    ollama = {
      enable = true;
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
