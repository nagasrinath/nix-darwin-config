{pkgs, ...}: let
  ioskeley-mono-nerd-font = pkgs.stdenvNoCC.mkDerivation {
    name = "ioskeley-mono-nerd-font";
    src = pkgs.fetchzip {
      url = "https://github.com/ahatem/IoskeleyMono/releases/download/v2.0.0/IoskeleyMono-NerdFont.zip";
      hash = "sha256-Nt8EaVhKvlb9BMKQe4l5iNGcPLzKba6KScIWZbcL8gA=";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      find $src -name "*.ttf" -o -name "*.otf" | xargs -I{} cp {} $out/share/fonts/truetype/
    '';
  };

  ioskeley-mono-term-nerd-font = pkgs.stdenvNoCC.mkDerivation {
    name = "ioskeley-mono-term-nerd-font";
    src = pkgs.fetchzip {
      url = "https://github.com/ahatem/IoskeleyMono/releases/download/v2.0.0/IoskeleyMono-Term-NerdFont.zip";
      hash = "sha256-GiMI2YTl20K+zUObcFNzgP1ivm7pH2zHWFG15gFgasg=";
      stripRoot = false;
    };
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      find $src -name "*.ttf" -o -name "*.otf" | xargs -I{} cp {} $out/share/fonts/truetype/
    '';
  };
in {
  fonts.packages = [
    ioskeley-mono-nerd-font
    ioskeley-mono-term-nerd-font
  ];
}
