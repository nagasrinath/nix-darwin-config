{...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        color-modes = true;
        line-number = "relative";
        rulers = [120];
        true-color = true;
        scrolloff = 8;
        soft-wrap.enable = true;
        file-picker.hidden = false;
        lsp = {
          display-messages = true;
          auto-signature-help = false;
          display-inlay-hints = true;
        };
        indent-guides = {
          character = "╎";
          render = true;
        };
        statusline = {
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
          separator = "│";
        };
        cursor-shape = {
          insert = "bar";
          select = "underline";
          normal = "block";
        };
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = ["collapse_selection" "keep_primary_selection"];
        p = "paste_clipboard_before";
        y = "yank_main_selection_to_clipboard";
        space."." = "file_picker_in_current_buffer_directory";
        C-o = ":open ~/.config/helix/config.toml";
        C-r = ":config-reload";
        C-tab = ":buffer-previous";
        C-S-tab = ":buffer-next";
        A-w = ":buffer-close";
      };
    };

    languages = {
      language-server = {
        nixd.command = "nixd";
        gopls.command = "gopls";
        golangci-lint-langserver = {
          command = "golangci-lint-langserver";
          config.command = ["golangci-lint" "run" "--out-format" "json" "--issues-exit-code=1"];
        };
        lua-language-server.command = "lua-language-server";
        ruff = {
          command = "ruff";
          args = ["server"];
        };
        typescript-language-server = {
          command = "typescript-language-server";
          args = ["--stdio"];
        };
        jdtls.command = "jdtls";
      };

      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
        }
        {
          name = "go";
          language-servers = ["gopls" "golangci-lint-langserver"];
        }
        {
          name = "python";
          language-servers = ["ruff"];
        }
        {
          name = "lua";
          language-servers = ["lua-language-server"];
        }
        {
          name = "typescript";
          language-servers = ["typescript-language-server"];
        }
        {
          name = "javascript";
          language-servers = ["typescript-language-server"];
        }
        {
          name = "tsx";
          language-servers = ["typescript-language-server"];
        }
        {
          name = "jsx";
          language-servers = ["typescript-language-server"];
        }
        {
          name = "java";
          language-servers = ["jdtls"];
        }
      ];
    };
  };
}
