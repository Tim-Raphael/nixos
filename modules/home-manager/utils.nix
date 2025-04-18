{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jmtpfs
    nautilus
    unzip
    wineWowPackages.full
  ];
}
