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
      # from https://github.com/catppuccin/atuin themes/mocha/catppuccin-mocha-mauve.toml
      themes.catppuccin-mocha-mauve = {
        theme.name = "catppuccin-mocha-mauve";
        colors = {
          AlertInfo = "#a6e3a1";
          AlertWarn = "#fab387";
          AlertError = "#f38ba8";
          Annotation = "#cba6f7";
          Base = "#cdd6f4";
          Guidance = "#9399b2";
          Important = "#f38ba8";
          Title = "#cba6f7";
        };
      };
      settings = {
        theme.name = "catppuccin-mocha-mauve";
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
      config.theme = "Catppuccin Mocha";
      themes."Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
