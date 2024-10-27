{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    unzip
    chromium
    firefox
    fish
    alacritty
    xclip
    ripgrep
    ranger
    neofetch
    pulseaudioFull
    blueman
    wineWowPackages.full
    ollama
  ];

  programs.fish.enable = true;
}
