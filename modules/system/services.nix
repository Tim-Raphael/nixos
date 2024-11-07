{ config, pkgs, ... }:

{
  # Enable OpenSSH
  services.openssh.enable = true;

  # Enable Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ ];
  };

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
