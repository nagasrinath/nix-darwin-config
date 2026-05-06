{pkgs, ...}: {
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = [ pkgs.comma ];
}
