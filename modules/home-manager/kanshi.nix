{ ... }:

let
  best_mode_path = "kanshi/best_mode.sh";
in
{
  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [ "~/.config/${best_mode_path}" ];
      }

      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "*";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [ "~/.config/${best_mode_path}" ];
      }

      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "*";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [ "~/.config/${best_mode_path}" ];
      }
    ];
  };

  xdg.configFile."${best_mode_path}" = {
    executable = true;
    text = ''
      #!/bin/sh
      # wlr-randr output looks like:
      #   eDP-1 "..." 
      #     ...
      #     Modes:
      #       1920x1200 px, 59.950001 Hz (preferred, current)
      #       1920x1200 px, 47.959999 Hz
      #     ...

      wlr-randr | awk '
        /^[^ \t]/ {
          if (output != "" && best_res != "") {
            print output " " best_res "@" best_hz "Hz"
          }
          output = $1
          best_res = ""; best_pixels = 0; best_hz = 0
        }
        /^[ \t]+[0-9]+x[0-9]+ px,/ {
          split($1, res, "x")
          pixels = res[1] * res[2]
          hz = $3 + 0
          if (pixels > best_pixels || (pixels == best_pixels && hz > best_hz)) {
            best_pixels = pixels
            best_hz = hz
            best_res = $1
          }
        }
        END {
          if (output != "" && best_res != "") {
            print output " " best_res "@" best_hz "Hz"
          }
        }
      ' | while read -r output mode; do
        wlr-randr --output "$output" --mode "$mode"
      done
    '';
  };
}
