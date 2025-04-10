{ config, pkgs, ... }:

{
  # Enable OpenSSH
  services.openssh.enable = true;
  programs.ssh.startAgent = true;
}
