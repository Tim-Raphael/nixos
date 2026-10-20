{
  config,
  inputs,
  pkgs,
  ...
}:

let
  stylix = inputs.stylix;
in
{
  imports = [
    stylix.homeModules.stylix
  ];

  config = {
    stylix = {
      enable = true;
      autoEnable = false;
      polarity = "dark";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      fonts = {
        monospace = {
          name = "BerkeleyMono Nerd Font";
          package = pkgs.berkeley-mono-nerd;
        };
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;

        sizes = {
          applications = 16;
          desktop = 12;
          popups = 16;
          terminal = 16;
        };
      };

      icons = {
        enable = true;
        package = pkgs.adwaita-icon-theme;
        dark = "Adwaita";
        light = "Adwaita";
      };

      cursor = {
        size = 16;
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
    };

    # Apply your color scheme via dconf for consistency
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
