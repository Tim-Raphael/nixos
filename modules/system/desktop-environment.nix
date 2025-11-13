{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.desktopEnvironments.gnome;
in
{
  options.desktopEnvironments.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      dconf-editor
    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome-maps
      gnome-weather
      gnome-contacts
      gnome-online-accounts
      gnome-calendar
      evolution
      evolution-data-server
      geary
      epiphany
      totem
    ];
  };

  services.geoclue2.enable = true;
}
