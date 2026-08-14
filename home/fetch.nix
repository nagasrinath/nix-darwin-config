{areofyl-fetch, ...}: {
  imports = [areofyl-fetch.homeManagerModules.default];

  programs.fetch.enable = true;
}
