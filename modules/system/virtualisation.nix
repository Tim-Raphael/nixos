{ pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    containers.enable = true;
  };

  users.users."raphael".extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker-compose
    podman-compose
    podman-tui
  ];
}
