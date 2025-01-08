{ config, pkgs, ... }:

{
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "24.05";

  home.packages = [ ];

  home.sessionVariables = { };

  home.file = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/i3.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/pass.nix
  ];

  programs.home-manager.enable = true;
}
