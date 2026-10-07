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
    ./appearance.nix
  ];

  config = {
    stylix = {
      fonts = {
        monospace = {
          name = "BerkeleyMono Nerd Font";
          package = pkgs.berkeley-mono-nerd;
        };
        serif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;

        sizes = {
          applications = 16;
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

      targets = {
        gnome.enable = false;
        gtk.enable = true;
      };
    };
  };
}
