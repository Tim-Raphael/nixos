{
  pkgs,
  lib,
  nix-colors,
  ...
}:

{
  imports = [
    nix-colors.homeManagerModules.default
  ];

  config = {
    colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.str;
    default = "JetBrainsMono Nerd Font Mono";
    description = "The main system font used across the system.";
  };
}
