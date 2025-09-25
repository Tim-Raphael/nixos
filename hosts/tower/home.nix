{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "25.05";

  home.packages = [ ];

  home.sessionVariables = { };

  home.file = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/scripts.nix
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/kanshi.nix
    ../../modules/home-manager/i3status.nix
  ];
}
