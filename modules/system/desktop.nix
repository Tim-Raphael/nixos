{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [
    evolution
    evolution-data-server
    geary
    epiphany
    totem
  ];
}
