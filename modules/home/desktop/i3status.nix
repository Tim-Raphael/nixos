{
  lib,
  config,
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
      cpu.usage.enable = mkEnableOption "CPU usage display";

      disk = {
        root.enable = mkEnableOption "root filesystem usage display";
      };

      memory.enable = mkEnableOption "memory usage display";
    };

    time = {
      date.enable = mkEnableOption "date display";
      clock.enable = mkEnableOption "time display";
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

    colors = {
      good = mkOption {
        type = types.str;
        default = config.lib.stylix.colors.base0B or "00ff00";
        description = "Color for good status";
      };

      degraded = mkOption {
        type = types.str;
        default = config.lib.stylix.colors.base0A or "ffff00";
        description = "Color for degraded status";
      };

      bad = mkOption {
        type = types.str;
        default = config.lib.stylix.colors.base08 or "ff0000";
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
        output_format = "i3bar";
        colors = true;
        color_good = "#${cfg.colors.good}";
        color_degraded = "#${cfg.colors.degraded}";
        color_bad = "#${cfg.colors.bad}";
        interval = cfg.interval;
      };

      modules = mkMerge [
        (mkIf cfg.system.cpu.usage.enable {
          "cpu_usage" = {
            position = 1;
            settings = {
              format = "";
              format_above_degraded_threshold = "%usage ";
              format_above_threshold = "%usage ";
              degraded_threshold = 90;
              max_threshold = 95;
            };
          };
        })

        (mkIf cfg.system.disk.root.enable {
          "disk /" = {
            position = 2;
            settings = {
              format = "";
              format_below_threshold = "%percentage_avail ";
              low_threshold = 10;
              threshold_type = "percentage_avail";
            };
          };
        })

        (mkIf cfg.system.memory.enable {
          "memory" = {
            position = 3;
            settings = {
              memory_used_method = "memavailable";
              format = "";
              format_degraded = "%percentage_used ";
              threshold_degraded = "10%";
              threshold_critical = "5%";
            };
          };
        })

        (mkIf cfg.power.battery.enable {
          "battery 0" = {
            position = 4;
            settings = {
              format = "%percentage %status";
              status_chr = "";
              status_bat = "";
              status_unk = "";
              status_full = "";
              format_down = "";
              last_full_capacity = true;
              integer_battery_capacity = true;
              low_threshold = cfg.power.battery.lowThreshold;
              threshold_type = "percentage";
              path = cfg.power.battery.path;
            };
          };
        })

        (mkIf (cfg.time.date.enable || cfg.time.clock.enable) {
          "tztime local" = {
            position = 5;
            settings.locale = "C";
            settings.format =
              concatStringsSep " " (
                optional cfg.time.date.enable "%B %d, %Y" ++ optional cfg.time.clock.enable "%I:%M %p"
              )
              + " ";
          };
        })

      ];
    };
  };
}
