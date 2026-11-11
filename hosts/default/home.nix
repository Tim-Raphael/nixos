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

    ../../modules/home/editor
    ../../modules/home/desktop
    ../../modules/home/terminal.nix
    ../../modules/home/browser.nix
    ../../modules/home/password.nix
    ../../modules/home/crypt.nix
  ];

  # The default host must build without the private hemisphere fonts flake, so
  # it themes with a public nerd font instead of BerkeleyMono.
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    fonts.monospace = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
  };

  programs.home-manager.enable = true;
}
