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
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
    zola
    sherlock
    sshs
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
      # canonical Nord palette (Frost + Aurora accents)
      themes.nord = {
        theme.name = "nord";
        colors = {
          AlertInfo = "#a3be8c";
          AlertWarn = "#ebcb8b";
          AlertError = "#bf616a";
          Annotation = "#b48ead";
          Base = "#d8dee9";
          Guidance = "#4c566a";
          Important = "#bf616a";
          Title = "#81a1c1";
        };
      };
      settings = {
        theme.name = "nord";
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

    zellij = {
      enable = true;
      settings = {
        # gruvbox-light is the light-medium variant (bg #fbf1c7)
        theme = "gruvbox-light";
        # minimal UI: no pane frames, stripped hints/progress
        simplified_ui = true;
        pane_frames = false;
        default_layout = "compact";
      };
    };

    bat = {
      enable = true;
      # bat ships Nord natively - no fetch needed
      config.theme = "Nord";
    };
  };
}
