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
    # TODO
  ];
}
