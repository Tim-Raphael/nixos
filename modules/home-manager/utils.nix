{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openfortivpn
    jmtpfs
    nautilus
    unzip
    wineWowPackages.full
  ];
}
