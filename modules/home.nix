{ config, pkgs, ... }:

{
    home.username = "raphael";
    home.homeDirectory = "/home/raphael";

    home.stateVersion = "24.05"; # Please read the comment before changing.


    home.packages = [

    ];

    home.file = {
        "~/.config" = {
            source = ../config;
            recursive = true;
        }; 
    };

    home.sessionVariables = {

    };

    programs.home-manager.enable = true;
}
