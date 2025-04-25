{
  inputs,
  config,
  pkgs,
  ...
}:

let
  inherit (inputs) nix-colors nixvim;
in
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
    nix-colors.homeManagerModules.default
    nixvim.homeManagerModules.nixvim

    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/nixvim/init.nix
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/i3status.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
  ];

  programs.home-manager.enable = true;
}
