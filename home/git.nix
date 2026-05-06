{username, useremail, ...}: {
  programs.git = {
    enable = true;
    userName = username;
    userEmail = useremail;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    aliases = {
      gs = "status";
      ga = "add";
      gc = "commit";
      gp = "push";
      gl = "log --oneline --graph --decorate";
      gd = "diff";
      gco = "checkout";
      gb = "branch";
    };

    ignores = [
      ".DS_Store"
      "*.swp"
    ];
  };
}
