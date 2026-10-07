{
  pkgs,
  inputs,
  user,
  userDir,
  ...
}:

{
  home = {
    stateVersion = "25.05";
    username = user;
    homeDirectory = userDir;
  };

  imports = [
    inputs.stylix.homeModules.stylix
    ../../modules/home-manager/desktop/themes/appearance.nix

    ../../modules/home-manager/editor
    ../../modules/home-manager/desktop
    ../../modules/home-manager/desktop/i3status.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
  ];

  # The default host must build without the private hemisphere fonts flake, so
  # it themes with a public nerd font instead of BerkeleyMono.
  stylix = {
    fonts.monospace = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
  };

  programs.home-manager.enable = true;
}
