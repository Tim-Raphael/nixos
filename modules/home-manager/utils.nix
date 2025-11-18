{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openfortivpn
    jmtpfs
    nautilus
    unzip
    zip
    wineWowPackages.full
  ];
}
