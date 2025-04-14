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

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.str;
    default = "JetBrainsMono Nerd Font Mono";
    description = "The main system font used across the system.";
  };

  config = {
    colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
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

    gtk = {
      enable = true;

      cursorTheme = {
        size = 16;
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      iconTheme = {
        name = "oomox-gruvbox_dark";
        package = pkgs.gruvbox-dark-icons-gtk;
      };

      theme = {
        name = "Gruvbox";
        package = pkgs.gruvbox-dark-gtk;
      };
    };
  };
}
