{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    starship
    neovim
    eza
    dust
    fastfetch
    wget
    podman
    podman-compose
    python3
    ollama
    android-tools
    scrcpy
    bat
  ];
}
