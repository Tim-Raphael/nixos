{
  inputs,
  pkgs,
  lib,
  ...
}:

let
  font = {
    name = "BerkeleyMono Nerd Font";
    size-small = 12;
    size-medium = 18;
    size-large = 22;
    pkg = pkgs.berkeley-mono-nerd;
  };

  # trying out new themes
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-medium;
  #colorScheme = inputs.nix-colors.colorSchemes.gruvbox-light-medium;
  #colorScheme = inputs.nix-colors.colorSchemes.kanagawa;
  #colorScheme = inputs.nix-colors.colorSchemes.everforest;
  #colorScheme = inputs.nix-colors.colorSchemes.nord;

in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.attrs;
    default = font;
    description = "The main system font used across the system.";
  };

  config = {
    colorScheme = colorScheme;

    home.packages = [
      font.pkg
    ];

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      sway.enable = true;
      x11.enable = true;
      size = 16;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
