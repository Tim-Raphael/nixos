{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.i3status;
in
{
  options.i3status = {
    enable = mkEnableOption "i3status bar";

    system = {
      cpu = {
        temperature.enable = mkEnableOption "CPU temperature display";
        usage.enable = mkEnableOption "CPU usage display";
      };

      disk = {
        root.enable = mkEnableOption "root filesystem usage display";
      };
    };

    time = {
      date.enable = mkEnableOption "date display";
      clock.enable = mkEnableOption "time display";
    };

    audio = {
      volume.enable = mkEnableOption "volume display";
    };

    power = {
      battery = {
        enable = mkEnableOption "battery status display";
        path = mkOption {
          type = types.str;
          default = "/sys/class/power_supply/BAT0/uevent";
          description = "Path to battery information";
        };
        lowThreshold = mkOption {
          type = types.int;
          default = 20;
          description = "Low battery threshold percentage";
        };
      };
    };

    network = {
      wireless = {
        enable = mkEnableOption "wireless network display";
        interface = mkOption {
          type = types.str;
          default = "wlp2s0";
          description = "Wireless interface name";
        };
      };

      ethernet = {
        enable = mkEnableOption "ethernet network display";
        interface = mkOption {
          type = types.str;
          default = "enp1s0f0";
          description = "Ethernet interface name";
        };
      };
    };

    colors = {
      good = mkOption {
        type = types.str;
        default = config.colorScheme.palette.base0B or "00ff00";
        description = "Color for good status";
      };

      degraded = mkOption {
        type = types.str;
        default = config.colorScheme.palette.base0A or "ffff00";
        description = "Color for degraded status";
      };

      bad = mkOption {
        type = types.str;
        default = config.colorScheme.palette.base08 or "ff0000";
        description = "Color for bad status";
      };
    };

    interval = mkOption {
      type = types.int;
      default = 5;
      description = "Update interval in seconds";
    };
  };

  config = mkIf cfg.enable {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        color_good = "#${cfg.colors.good}";
        color_degraded = "#${cfg.colors.degraded}";
        color_bad = "#${cfg.colors.bad}";
        interval = cfg.interval;
      };

      modules = mkMerge [
        (mkIf cfg.system.cpu.temperature.enable {
          "cpu_temperature 0" = {
            position = 1;
            settings.format = "TEMP: %degrees°C";
          };
        })

        (mkIf cfg.system.cpu.usage.enable {
          "cpu_usage" = {
            position = 2;
            settings.format = "CPU: %usage";
          };
        })

        (mkIf cfg.system.disk.root.enable {
          "disk /" = {
            position = 3;
            settings.format = "FREE: %free";
          };
        })

        (mkIf cfg.time.date.enable {
          "tztime date" = {
            position = 4;
            settings.format = "DATE: %Y-%m-%d";
          };
        })

        (mkIf cfg.time.clock.enable {
          "tztime local2" = {
            position = 5;
            settings.format = "TIME: %H:%M:%S";
          };
        })

        (mkIf cfg.audio.volume.enable {
          "volume master" = {
            position = 6;
            settings = {
              format = "VOL: %volume";
              device = "default";
              mixer = "Master";
              mixer_idx = 0;
            };
          };
        })

        (mkIf cfg.power.battery.enable {
          "battery 0" = {
            position = 7;
            settings = {
              format = "BAT: %percentage %remaining";
              format_down = "";
              last_full_capacity = true;
              integer_battery_capacity = true;
              low_threshold = cfg.power.battery.lowThreshold;
              threshold_type = "percentage";
              hide_seconds = true;
              path = cfg.power.battery.path;
            };
          };
        })

        (mkIf cfg.network.wireless.enable {
          "wireless ${cfg.network.wireless.interface}" = {
            position = 8;
            settings = {
              format_up = "WLS:%quality at %essid, %ip";
              format_down = "";
            };
          };
        })

        (mkIf cfg.network.ethernet.enable {
          "ethernet ${cfg.network.ethernet.interface}" = {
            position = 9;
            settings = {
              format_up = "ETH: %ip";
              format_down = "";
            };
          };
        })
      ];
    };
  };
}
