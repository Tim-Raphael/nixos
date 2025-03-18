{ config, pkgs, ... }:

{
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "25.05";

  # home.packages = [ ];

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
    ../../modules/home-manager/keepass.nix
    ../../modules/home-manager/communication.nix
  ];

  programs.home-manager.enable = true;
}
