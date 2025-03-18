{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.groups.docker.members = [ "raphael" ];
}
