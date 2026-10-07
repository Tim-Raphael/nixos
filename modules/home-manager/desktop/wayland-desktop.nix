{
  config,
  lib,
  pkgs,
  ...
}:

let
  color = config.lib.stylix.colors;
  font = config.stylix.fonts;
in
{
  config = lib.mkIf (config.niri.enable || config.sway.enable) {
    services.blueman-applet.enable = true;
    systemd.user.services.blueman-applet.Unit = {
      # Auto-connect must run even when the desktop hides its tray.
      Requires = lib.mkForce [ ];
      After = lib.mkForce [ "graphical-session.target" ];
    };
    dconf.settings."org/blueman/general".plugin-list = [ "AutoConnect" ];

    home.packages = with pkgs; [
      wl-clipboard
      wlr-randr
      brightnessctl
    ];

    services.wlsunset = {
      enable = true;
      sunrise = "07:00";
      sunset = "21:15";
      temperature = {
        day = 6500;
        night = 1500;
      };
    };

    stylix.targets = {
      swaylock.enable = false;
      mako.enable = false;
    };

    services.mako = {
      enable = true;
      settings = {
        default-timeout = 5000;
        font = "${font.monospace.name} ${toString font.sizes.desktop}";
        border-color = "#${color.base07}";
        background-color = "#${color.base00}";
        padding = 10;
      };
    };

    programs.swaylock = {
      enable = true;
      settings = {
        font = "${font.monospace.name}";
        size = font.sizes.desktop;
        color = "${color.base00}";
        inside-color = "${color.base00}";
        inside-clear-color = "${color.base07}";
        inside-ver-color = "${color.base0D}";
        inside-wrong-color = "${color.base08}";
        separator-color = "${color.base07}";
        ring-color = "${color.base07}";
        text-color = "${color.base07}";
        key-hl-color = "${color.base0B}";
        bs-hl-color = "${color.base08}";
        line-uses-inside = true;
      };
    };
  };
}
