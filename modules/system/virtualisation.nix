{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    containers.enable = true;
  };

}
