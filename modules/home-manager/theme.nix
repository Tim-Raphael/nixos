{
  pkgs,
  lib,
  nix-colors,
  ...
}:

let
  font = {
    name = "JetBrainsMono Nerd Font Mono";
    pkg = pkgs.nerd-fonts.jetbrains-mono;
  };

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;

  theme = {
    name = "Gruvbox-Green-Dark";
    pkg = pkgs.gruvbox-gtk-theme.override {
      colorVariants = [ "dark" ];
      sizeVariants = [ "standard" ];
      themeVariants = [ "green" ];
      tweakVariants = [ "outline" ];
      iconVariants = [ "Dark" ];
    };
  };

  icons = {
    name = "oomox-gruvbox-dark";
    pkg = pkgs.gruvbox-dark-icons-gtk;
  };
in
{
  imports = [
    nix-colors.homeManagerModules.default
  ];

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.str;
    default = font.name;
    description = "The main system font used across the system.";
  };

  config = {
    colorScheme = colorScheme;

    home.packages = [
      font.pkg
    ];

    home.file = {
      ".themes/${theme.name}" = {
        source = "${theme.pkg}/share/themes/${theme.name}";
      };

      ".icons/${icons.name}" = {
        source = "${icons.pkg}/share/icons/${icons.name}";
      };

      ".gtkrc-2.0" = {
        text = ''
          gtk-theme-name="${theme.name}"
          gtk-icon-theme-name="${icons.name}"
          gtk-font-name="${font.name} 10"
        '';
      };

      ".config/gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-theme-name=${theme.name}
          gtk-icon-theme-name=${icons.name}
          gtk-font-name=${font.name} 10
        '';
      };

      ".config/gtk-4.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-theme-name=${theme.name}
          gtk-icon-theme-name=${icons.name}
          gtk-font-name=${font.name} 10
        '';
      };

      ".profile" = {
        text = "export GTK_THEME=${theme.name}";
      };
    };

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
