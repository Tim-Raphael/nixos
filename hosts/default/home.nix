{ config, pkgs, ... }: {
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [ ];

  home.sessionVariables = { };

  home.file = { };

  imports =
    [ ../../modules/home-manager/nvim.nix ../../modules/home-manager/i3.nix ];

  programs.home-manager.enable = true;
}
