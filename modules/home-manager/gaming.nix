{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pcsx2
    minecraft
    prismlauncher
  ];
}
