{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    unzip
    wineWowPackages.full
  ];
}
