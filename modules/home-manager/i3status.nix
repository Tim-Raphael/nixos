{
  pkgs,
  config,
  lib,
  extraModuleList ? [ ],
  ...
}:

let
  defaultModulesList = [
    {
      "cpu_temperature 0" = lib.mkDefault {
        position = 1;
        settings.format = "TEMP: %degrees°C";
      };
    }
    {
      "cpu_usage" = lib.mkDefault {
        position = 2;
        settings.format = "CPU: %usage";
      };
    }
    {
      "disk /" = lib.mkDefault {
        position = 3;
        settings.format = "FREE: %free";
      };
    }
    {
      "tztime date" = lib.mkDefault {
        position = 4;
        settings.format = "DATE: %Y-%m-%d";
      };
    }
    {
      "tztime local2" = lib.mkDefault {
        position = 5;
        settings.format = "TIME: %H:%M:%S";
      };
    }
    {
      "volume master" = lib.mkDefault {
        position = 6;
        settings = {
          format = "VOL: %volume";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };
    }
    {
      "battery 0" = lib.mkDefault {
        position = 7;
        settings = {
          format = "BAT: %percentage %remaining";
          format_down = "";
          last_full_capacity = true;
          integer_battery_capacity = true;
          low_threshold = 20;
          threshold_type = "percentage";
          hide_seconds = true;
        };
      };
    }
    {
      "wireless wlp2s0" = lib.mkDefault {
        position = 8;
        settings = {
          format_up = "WLS:%quality at %essid, %ip";
          format_down = "";
        };
      };
    }
    {
      "ethernet enp1s0f0" = lib.mkDefault {
        position = 9;
        settings = {
          format_up = "ETH:%quality at %essid, %ip";
          format_down = "";
        };
      };
    }
  ];

  mergedModules = builtins.foldl' (a: b: a // b) { } (defaultModulesList ++ extraModuleList);
in
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

    modules = mergedModules;
  };
}
