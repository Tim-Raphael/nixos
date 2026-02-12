{ ... }:

{

  home = {
    stateVersion = "24.05";
    username = "raphael";
    homeDirectory = "/home/raphael";
  };

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/kanshi.nix
    ../../modules/home-manager/nixvim.nix
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/i3status.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development
    ../../modules/home-manager/scripts
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
  ];

  programs.home-manager.enable = true;
}
