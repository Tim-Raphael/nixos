{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gimp
        darktable
        inkscape
        shotcut
        obsidian
        imagemagick
    ];
}

