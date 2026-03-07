{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.desktopEnvironments;
in
{
  options.desktopEnvironments.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
  };

  config = mkIf cfg.gnome.enable {
    services = {
      geoclue2.enable = true;
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
      gnome.gcr-ssh-agent.enable = false;
    };

    environment = {
      gnome.excludePackages = with pkgs; [
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
  };
}
