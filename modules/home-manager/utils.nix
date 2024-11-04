{ pkgs, ... }:

{
  home.packages = with pkgs; [ unzip wineWowPackages.full blueman ];
}
