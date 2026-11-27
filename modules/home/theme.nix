{
  config,
  inputs,
  lib,
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
      polarity = "light";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord-light.yaml";

      targets.gnome = {
        enable = true;
        polarity.enable = true;
      };

      fonts = {
        monospace = {
          name = "BerkeleyMono Nerd Font";
          package = pkgs.berkeley-mono-nerd;
        };
        emoji = config.stylix.fonts.monospace;

        sizes = {
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

    # Stylix writes "default", which keeps the GNOME Shell dark since GNOME 47
    dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-light";
  };
}
