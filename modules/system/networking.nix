{ pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 40000 ];
    allowedUDPPorts = [
      40000
      # mosh port
      60001
    ];
  };

  # Optional proxy configuration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
