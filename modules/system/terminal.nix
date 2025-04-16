{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gruvbox-gtk-theme
    alacritty
    fish
  ];
}
