{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  networking.firewall = {
    enable = true;
    # allowedUDPPorts = [ 8080 3000 ];
    # allowedTCPPorts = [ 8080 3000 ];
  };

  # Optional proxy configuration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
