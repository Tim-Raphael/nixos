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
    ../../modules/home/browser.nix
    ../../modules/home/communication.nix
    ../../modules/home/crypt.nix
    ../../modules/home/development.nix
    ../../modules/home/editor
    ../../modules/home/gaming.nix
    ../../modules/home/kanshi.nix
    ../../modules/home/multimedia.nix
    ../../modules/home/password.nix
    ../../modules/home/desktop
    ../../modules/home/terminal.nix
    ../../modules/home/theme.nix
    ../../modules/home/utils.nix
  ];

  programs.home-manager.enable = true;
}
