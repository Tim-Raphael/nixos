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

    modules = {
      "cpu_temperature 0" = {
        position = 3;
        settings = {
          format = "TEMP: %degrees°C";
        };
      };

      "cpu_usage" = {
        position = 4;
        settings = {
          format = "CPU: %usage";
        };
      };

      "disk /" = {
        position = 5;
        settings = {
          format = "FREE: %free";
        };
      };

      "tztime local2" = {
        position = 6;
        settings = {
          format = "TIME: %H:%M:%S";
        };
      };

      "volume master" = {
        position = 7;
        settings = {
          format = "VOL: %volume";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "battery 0" = {
        position = 8;
        settings = {
          format = "BAT: %percentage";
          last_full_capacity = true;
          integer_battery_capacity = true;
          low_threshold = 20;
          threshold_type = "percentage";
          hide_seconds = true;
        };
      };
    };
  };
}
