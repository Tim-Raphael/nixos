{ config, pkgs, ... }:

{
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "25.05";

  # home.packages = [ ];

  # home.sessionVariables = { };

  # home.file = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    ../../modules/home-manager/colors.nix
    ../../modules/home-manager/fonts.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/i3status.nix
    ../../modules/home-manager/wayland.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/scripts.nix
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
  ];

  programs.home-manager.enable = true;
}
