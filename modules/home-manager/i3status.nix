{ pkgs, config, ... }:

{
  programs.i3status = {
    enable = true;
    enableDefault = true;

    general = {
      colors = true;
      color_good = "#${config.colorScheme.palette.base0B}";
      color_degraded = "#${config.colorScheme.palette.base0A}";
      color_bad = "#${config.colorScheme.palette.base08}";
      interval = 1;
    };

    modules = {
      "path_exists VPN" = {
        position = 0;
        settings = {
          path = "/proc/sys/net/ipv4/conf/tun0";
        };
      };

      "ethernet enp58s0u1u1u4c2" = {
        position = 1;
        settings = {
          format_up = "E: %ip";
          format_down = "E: down";
        };
      };

      "wireless wlp0s20f3" = {
        position = 2;
        settings = {
          format_up = "W: %ip";
          format_down = "W: down";
        };
      };

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
        position = 7;
        settings = {
          format = "TIME: %H:%M:%S";
        };
      };

      "volume master" = {
        position = 8;
        settings = {
          format = "VOL: %volume";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "battery 0" = {
        position = 9;
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
