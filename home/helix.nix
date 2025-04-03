{...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        color-modes = true;
        line-number = "relative";
        lsp.display-messages = true;
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
