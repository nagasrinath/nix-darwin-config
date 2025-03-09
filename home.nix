{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.me = {
    home.stateVersion = "23.05";
    home.packages = [ pkgs.neofetch ];
    home.file = { };
    home.sessionVariables = { };
    programs.home-manager.enable = true;
  };
}
