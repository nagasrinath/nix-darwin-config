{
  username,
  hostname,
  pkgs,
  ...
}: {
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.knownUsers = [username];

  users.users."${username}" = {
    uid = 501;
    home = "/Users/${username}";
    description = "Naga Srinath";
    shell = pkgs.fish;
  };

  nix.settings.trusted-users = [username];
}
