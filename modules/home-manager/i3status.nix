{
  pkgs,
  config,
  lib,
  ...
}:

{
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      colors = true;
      color_good = "#${config.colorScheme.palette.base0B}";
      color_degraded = "#${config.colorScheme.palette.base0A}";
      color_bad = "#${config.colorScheme.palette.base08}";
      interval = 5;
    };

    modules = lib.mkDefault {
      "cpu_temperature 0" = {
        position = 1;
        settings = {
          format = "TEMP: %degrees°C";
        };
      };

      "cpu_usage" = {
        position = 2;
        settings = {
          format = "CPU: %usage";
        };
      };

      "disk /" = {
        position = 3;
        settings = {
          format = "FREE: %free";
        };
      };

      "tztime date" = {
        position = 4;
        settings = {
          format = "DATE: %Y-%m-%d";
        };
      };

      "tztime local2" = {
        position = 5;
        settings = {
          format = "TIME: %H:%M:%S";
        };
      };

      "volume master" = {
        position = 6;
        settings = {
          format = "VOL: %volume";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "battery 0" = {
        position = 7;
        settings = {
          format = "BAT: %percentage";
          last_full_capacity = true;
          integer_battery_capacity = true;
          low_threshold = 20;
          threshold_type = "percentage";
          hide_seconds = true;
        };
      };

      "wireless wlp2s0" = {
        position = 8;
        settings = {
          format_up = "WLS: %quality at %essid, %ip";
          format_down = "";
        };
      };

      "ethernet enp1s0f0" = {
        position = 9;
        settings = {
          format_up = "ETH: %quality at %essid, %ip";
          format_down = "";
        };
      };
    };
  };
}
