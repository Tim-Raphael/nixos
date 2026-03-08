{ config, pkgs, ... }:

{
  # Enable OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "raphael" ];
    };
  };
  programs.ssh.startAgent = true;
  users.users.raphael.openssh.authorizedKeys.keys = [
    # Work
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAxTlPKWtC6DN8Ii81peVUT4SyKvWGO7smSgK/UCjUO raphael"
  ];
}
