{ config, pkgs, ... }:

{
    # Hostname
    networking.hostName = "nixos";

    # Enable network manager
    networking.networkmanager.enable = true;

    # Optional proxy configuration
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}

