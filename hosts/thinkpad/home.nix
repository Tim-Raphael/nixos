{
  user,
  userDir,
  ...
}:

{

  home = {
    stateVersion = "24.05";
    username = user;
    homeDirectory = userDir;
  };

  imports = [
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/editor
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/desktop/i3status.nix
    ../../modules/home-manager/desktop/kanshi.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/desktop
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/desktop/theme.nix
    ../../modules/home-manager/utils.nix
  ];

  programs.home-manager.enable = true;
}
