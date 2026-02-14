{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openfortivpn
    nautilus
    unzip
    zip
    wineWowPackages.full
  ];
}
