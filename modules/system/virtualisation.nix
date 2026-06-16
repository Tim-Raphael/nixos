{ pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    containers.enable = true;
  };
  environment.systemPackages = with pkgs; [
    docker-compose
    podman-compose
    podman-tui
  ];
}
