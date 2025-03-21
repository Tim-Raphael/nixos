{ pkgs, config, ... }:

{
  programs.i3status = {
    enable = true;
    enableDefault = true;

    general = {
      colors = true;
      color_good = "#${config.colorScheme.palette.base02}";
      color_degraded = "#${config.colorScheme.palette.base03}";
      color_bad = "#${config.colorScheme.palette.base01}";
      interval = 1;
    };
  };
}
