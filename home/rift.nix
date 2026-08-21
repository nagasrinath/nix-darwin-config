{
  lib,
  wmEngine,
  ...
}: let
  isRift = wmEngine == "rift";
in {
  # Rift WM trial config (see home/rift/config.toml); only deployed when
  # selected as the engine so aerospace/rift configs don't fight over
  # keybindings if both happen to be installed.
  config = lib.mkIf isRift {
    home.file.".config/rift/config.toml".source = ./rift/config.toml;
  };
}
