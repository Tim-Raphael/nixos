{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    darktable
    inkscape
    scribus
    shotcut
    imagemagick
    ffmpeg_7
    pandoc
    obsidian
    texliveSmall
    vlc
  ];
}

