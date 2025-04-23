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

    home.file = {
      ".icons/oomox-gruvbox-dark" = {
        source = "${pkgs.gruvbox-dark-icons-gtk}/share/icons/oomox-gruvbox-dark";
      };

      ".themes" = {
        source = "${
          (pkgs.gruvbox-gtk-theme.override {
            colorVariants = [ "dark" ];
            sizeVariants = [ "standard" ];
            themeVariants = [ "green" ];
            tweakVariants = [ "outline" ];
            iconVariants = [ "Dark" ];
          })
        }/share/themes";
      };

      ".config/gtk-4.0/" = {
        source = "${
          (pkgs.gruvbox-gtk-theme.override {
            colorVariants = [ "dark" ];
            sizeVariants = [ "standard" ];
            themeVariants = [ "green" ];
            tweakVariants = [ "outline" ];
            iconVariants = [ "Dark" ];
          })
        }/share/themes/Gruvbox-Green-Dark/gtk-4.0";
      };

      ".profile" = {
        text = ''
          export GTK_THEME=Gruvbox-Green-Dark
        '';
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
