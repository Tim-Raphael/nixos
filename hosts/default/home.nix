{
  pkgs,
  inputs,
  ...
}:

{
  home = {
    stateVersion = "25.05";
    username = "raphael";
    homeDirectory = "/home/raphael";
  };

  imports = [
    inputs.stylix.homeModules.stylix

    ../../modules/home-manager/editor
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/i3status.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/browser
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
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
