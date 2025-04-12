{...}: {
  programs.helix = {
    enable = true;
    # languages = {
    #   language-server.gpt = {
    #     command = "helix-gpt";
    #   };

    #   language = [{
    #     name = "python";
    #     language-servers = [
    #       "gpt"
    #     ];
    #   }];
    # };
    settings = {
      theme = "onedark";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        color-modes = true;
        line-number = "relative";
        rulers = [120];
        true-color = true;
        lsp = {
          display-messages = true;
          auto-signature-help = false;
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
  };
}
