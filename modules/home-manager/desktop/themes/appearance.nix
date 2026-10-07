{ lib, pkgs, ... }:

{
  imports = [ ./wallpaper.nix ];

  stylix.fonts = {
    sansSerif = {
      name = "Inter";
      package = pkgs.inter;
    };
    sizes.desktop = 10;
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = lib.mkForce "prefer-light";
}
