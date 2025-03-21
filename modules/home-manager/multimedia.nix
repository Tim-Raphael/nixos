{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pdfarranger
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
    libreoffice-qt
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    obs-studio
    pdfarranger
  ];
}
