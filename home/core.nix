{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    mosh
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
    nodejs_24
    nodePackages.typescript-language-server
    jdt-language-server
    leetcode-cli
    croc
  ];

  home.activation.installPi = lib.hm.dag.entryAfter ["writeBoundary"] ''
    export PATH="/opt/homebrew/bin:$PATH"
    if ! npm list -g @earendil-works/pi-coding-agent >/dev/null 2>&1; then
      npm install -g --ignore-scripts @earendil-works/pi-coding-agent
    fi
  '';

  # used by system.activationScripts.displayScale to pin the built-in
  # display to "More Space" (top HiDPI mode)
  home.activation.installDisplayplacer = lib.hm.dag.entryAfter ["writeBoundary"] ''
    export PATH="/opt/homebrew/bin:$PATH"
    brew list displayplacer >/dev/null 2>&1 || brew install displayplacer
  '';

  services = {
    ollama = {
      #enable = true;
    };
  };

  programs = {
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

    atuin = {
      enable = true;
      enableFishIntegration = true;
      # canonical Gruvbox Light Medium palette (faded accent variants)
      themes.gruvbox-light = {
        theme.name = "gruvbox-light";
        colors = {
          AlertInfo = "#79740e";
          AlertWarn = "#b57614";
          AlertError = "#9d0006";
          Annotation = "#8f3f71";
          Base = "#3c3836";
          Guidance = "#7c6f64";
          Important = "#9d0006";
          Title = "#076678";
        };
      };
      settings = {
        theme.name = "gruvbox-light";
        show_help = false;
      };
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        mgr = {
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
      # bat ships gruvbox-light natively - no fetch needed
      config.theme = "gruvbox-light";
    };
  };
}
