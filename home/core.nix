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
    typescript-language-server
    bun
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
      # canonical Tokyo Night (Night) palette
      themes.tokyonight = {
        theme.name = "tokyonight";
        colors = {
          AlertInfo = "#9ece6a";
          AlertWarn = "#e0af68";
          AlertError = "#f7768e";
          Annotation = "#bb9af7";
          Base = "#c0caf5";
          Guidance = "#414868";
          Important = "#f7768e";
          Title = "#7aa2f7";
        };
      };
      settings = {
        theme.name = "tokyonight";
        show_help = false;
      };
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
      # legacy default (stateVersion < 26.05); pinned to silence HM warning
      shellWrapperName = "yy";
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
        theme = "tokyo-night";
        # minimal UI: no pane frames, stripped hints/progress
        simplified_ui = true;
        pane_frames = false;
        default_layout = "compact";
      };
    };

    bat = {
      enable = true;
      # bat has no bundled Tokyo Night theme; official folke/tokyonight.nvim
      # ships bat-compatible .tmTheme files under extras/sublime/
      config.theme = "tokyonight_night";
      themes."tokyonight_night" = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
          hash = "sha256-a9iRWue7DB7s/wNdxqqB51Jya5P9X6sDftqhdmKggU0=";
        };
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
