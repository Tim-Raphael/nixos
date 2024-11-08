{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    darktable
    inkscape
    shotcut
    obsidian
    imagemagick
    ffmpeg_7
  ];
}

