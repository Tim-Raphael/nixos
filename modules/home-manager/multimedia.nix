{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    darktable
    inkscape
    shotcut
    imagemagick
    ffmpeg_7
    pandoc
    obsidian
    texliveSmall
  ];
}

