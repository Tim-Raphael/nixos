{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unzip
    chromium
    firefox
    alacritty
    ripgrep
    ranger
    neofetch
    pulseaudioFull
    blueman
    wineWowPackages.full
    ollama
    sshfs
  ];
}
