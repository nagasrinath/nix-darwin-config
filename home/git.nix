{
  fullname,
  useremail,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = fullname;
      user.email = useremail;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAX5ZBkuzFQFxB5i6pbA929ia8AXITNLIN0nf6KHWkUD";
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign = true;

      alias = {
        gs = "status";
        ga = "add";
        gc = "commit";
        gp = "push";
        gl = "log --oneline --graph --decorate";
        gd = "diff";
        gco = "checkout";
        gb = "branch";
      };
    };

    ignores = [
      ".DS_Store"
      "*.swp"
    ];
  };
}
