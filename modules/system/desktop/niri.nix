{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.niri.enable = lib.mkEnableOption "niri desktop";

  config = lib.mkIf config.niri.enable {
    programs.niri.enable = true;
    services.gnome.gcr-ssh-agent.enable = false;

    environment.systemPackages = [ pkgs.xwayland-satellite ];
  };
}
