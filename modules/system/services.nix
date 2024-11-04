{ config, pkgs, ... }:

{
  # Enable printing
  services.printing.enable = true;

  # Enable OpenSSH
  services.openssh.enable = true;
}
