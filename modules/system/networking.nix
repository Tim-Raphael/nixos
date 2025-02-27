{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  # Enable network manager
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 8080 3000 ];
    allowedTCPPorts = [ 8080 3000 ];
  };

  # Optional proxy configuration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
