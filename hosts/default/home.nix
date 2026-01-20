{ ... }:

{
  home = {
    # Pin home state verion here.
    #stateVersion = "xx.xx";
    username = "raphael";
    homeDirectory = "/home/raphael";
  };

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/i3status.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
  ];

  programs.home-manager.enable = true;
}
