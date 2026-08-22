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
      # canonical Solarized Light palette
      themes.solarized-light = {
        theme.name = "solarized-light";
        colors = {
          AlertInfo = "#859900";
          AlertWarn = "#b58900";
          AlertError = "#dc322f";
          Annotation = "#6c71c4";
          Base = "#657b83";
          Guidance = "#93a1a1";
          Important = "#dc322f";
          Title = "#268bd2";
        };
      };
      settings = {
        theme.name = "solarized-light";
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
      # bat ships Solarized Light natively - no fetch needed
      config.theme = "Solarized (light)";
    };
  };
}
