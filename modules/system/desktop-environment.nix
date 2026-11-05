{
  lib,
  config,
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
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      gnome.gcr-ssh-agent.enable = false;
    };

    # User services need permission to request negative niceness.
    systemd.services."user@".serviceConfig.LimitNICE = -11;

    systemd.user.services."org.gnome.Shell@" = {
      overrideStrategy = "asDropin";
      serviceConfig.Nice = -11;
    };

    # CPU shares between slices are independent of process niceness.
    systemd.user.slices.session.sliceConfig.CPUWeight = 1000;
  };
}
