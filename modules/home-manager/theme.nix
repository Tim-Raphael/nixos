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
      polarity = "dark";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      #base16Scheme = {
      #  scheme = "Gruvbox Dark Midnight";
      #  author = "/";
      #  base00 = "000000"; # ----
      #  base01 = "1e1d1c"; # ---
      #  base02 = "2d2a29"; # --
      #  base03 = "3a3632"; # -
      #  base04 = "bdae93"; # +
      #  base05 = "d5c4a1"; # ++
      #  base06 = "ebdbb2"; # +++
      #  base07 = "fbf1c7"; # ++++
      #  base08 = "fb4934"; # red
      #  base09 = "fe8019"; # orange
      #  base0A = "fabd2f"; # yellow
      #  base0B = "b8bb26"; # green
      #  base0C = "8ec07c"; # aqua/cyan
      #  base0D = "83a598"; # blue
      #  base0E = "d3869b"; # purple
      #  base0F = "d65d0e"; # brown
      #};

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

      targets = {
        gnome.enable = false;
        gtk.enable = true;
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
