{
  pkgs,
  config,
  lib,
  ...
}:

let
  color = config.lib.stylix.colors;
  font = config.stylix.fonts;

  ws1 = "1:terminal";
  ws2 = "2:editor";
  ws3 = "3:agent";
  ws4 = "4:browser";
  ws5 = "5:misc";
  ws6 = "6:misc";
  ws7 = "7:misc";
  ws8 = "8:message";
  ws9 = "9:note";
  ws0 = "0:todo";
in
{
  imports = [ ./i3status.nix ];

  home.packages = with pkgs; [
    swayidle
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wlr-randr # screenmanager util
    grim
    slurp
    mako # notification system developed by swaywm maintainer
    i3status
    waybar
    blueman
    dmenu-wayland
    jq
    swaylock
    brightnessctl
  ];

  stylix.targets = {
    sway.enable = false;
    swaylock.enable = false;
    mako.enable = false;
  };

  wayland = {
    windowManager.sway = {
      enable = true;
      checkConfig = true;
      systemd.enable = true;

      wrapperFeatures = {
        gtk = true;
      };

      extraConfig = ''
        default_border pixel 2 
        default_floating_border pixel 2 
      '';

      config =
        let
          modifier = "Mod4";
        in
        {
          inherit modifier;

          terminal = "alacritty";
          defaultWorkspace = ws1;

          startup = [
            { command = "alacritty --command ssh-add"; }
            {
              command = ''
                swayidle -w \
                  timeout 600 'swaylock -f' \
                  timeout 610 'swaymsg "output * power off"' \
                  resume 'swaymsg "output * power on"' \
                  before-sleep 'swaylock -f'
              '';
            }
          ];

          keybindings = lib.mkOptionDefault {
            "${modifier}+Escape" = "exec swaylock";

            "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";

            "${modifier}+d" =
              "exec dmenu-wl_run -m $(swaymsg -t get_outputs | jq -r 'map(.focused) | index(true)') -fn '${font.monospace.name}' -nb '#${color.base00}' -nf '#${color.base07}' -sb '#${color.base0B}' -sf '#${color.base00}'";

            "${modifier}+1" = "workspace ${ws1}";
            "${modifier}+2" = "workspace ${ws2}";
            "${modifier}+3" = "workspace ${ws3}";
            "${modifier}+4" = "workspace ${ws4}";
            "${modifier}+5" = "workspace ${ws5}";
            "${modifier}+6" = "workspace ${ws6}";
            "${modifier}+7" = "workspace ${ws7}";
            "${modifier}+8" = "workspace ${ws8}";
            "${modifier}+9" = "workspace ${ws9}";
            "${modifier}+0" = "workspace ${ws0}";

            "${modifier}+Shift+1" = "move container to workspace ${ws1}";
            "${modifier}+Shift+2" = "move container to workspace ${ws2}";
            "${modifier}+Shift+3" = "move container to workspace ${ws3}";
            "${modifier}+Shift+4" = "move container to workspace ${ws4}";
            "${modifier}+Shift+5" = "move container to workspace ${ws5}";
            "${modifier}+Shift+6" = "move container to workspace ${ws6}";
            "${modifier}+Shift+7" = "move container to workspace ${ws7}";
            "${modifier}+Shift+8" = "move container to workspace ${ws8}";
            "${modifier}+Shift+9" = "move container to workspace ${ws9}";
            "${modifier}+Shift+0" = "move container to workspace ${ws0}";
          };

          fonts = {
            names = [ "${font.monospace.name}" ];
            style = "Regular";
            size = font.sizes.desktop * 1.0; # little hack to convert into float
          };

          input = {
            "*" = {
              xkb_layout = "us";
              xkb_options = "compose:ralt"; # For writing umlaute like ü (ralt -> " -> u)
              pointer_accel = "1";
              accel_profile = "flat";
            };
          };

          output = {
            "*" = {
              bg = "#${color.base00} solid_color";
            };
          };

          gaps = {
            smartBorders = "on";
            smartGaps = true;
            inner = 16;
          };

          colors = {
            background = "#${color.base00}";

            focused = {
              background = "#${color.base0B}";
              border = "#${color.base0B}";
              childBorder = "#${color.base0B}";
              indicator = "#${color.base08}";
              text = "#${color.base00}";
            };

            focusedInactive = {
              background = "#${color.base03}";
              border = "#${color.base03}";
              childBorder = "#${color.base03}";
              indicator = "#${color.base08}";
              text = "#${color.base07}";
            };

            placeholder = {
              background = "#${color.base03}";
              border = "#${color.base03}";
              childBorder = "#${color.base03}";
              indicator = "#${color.base08}";
              text = "#${color.base07}";
            };

            unfocused = {
              background = "#${color.base03}";
              border = "#${color.base03}";
              childBorder = "#${color.base03}";
              indicator = "#${color.base08}";
              text = "#${color.base07}";
            };

            urgent = {
              background = "#${color.base08}";
              border = "#${color.base08}";
              childBorder = "#${color.base08}";
              indicator = "#${color.base0A}";
              text = "#${color.base07}";
            };
          };

          bars = [
            {
              statusCommand = "${pkgs.i3status}/bin/i3status";
              position = "top";

              # Disabled for now, because some programs always spams my tray
              # with sad smileys (heulis).
              trayOutput = "none";

              extraConfig = ''
                strip_workspace_numbers no
                separator_symbol " :: "
              '';

              fonts = {
                names = [ "${font.monospace.name}" ];
                style = "Regular";
                size = font.sizes.desktop * 1.0; # little hack to convert into float
              };

              colors = {
                background = "#${color.base00}";
                focusedBackground = "#${color.base00}";

                focusedStatusline = "#${color.base07}";
                statusline = "#${color.base07}";

                focusedSeparator = "#${color.base04}";
                separator = "#${color.base04}";

                urgentWorkspace = {
                  background = "#${color.base08}";
                  border = "#${color.base08}";
                  text = "#${color.base00}";
                };

                focusedWorkspace = {
                  background = "#${color.base0B}";
                  border = "#${color.base0B}";
                  text = "#${color.base00}";
                };

                activeWorkspace = {
                  background = "#${color.base00}";
                  border = "#${color.base00}";
                  text = "#${color.base07}";
                };

                inactiveWorkspace = {
                  background = "#${color.base00}";
                  border = "#${color.base00}";
                  text = "#${color.base07}";
                };

                bindingMode = {
                  background = "#${color.base00}";
                  border = "#${color.base00}";
                  text = "#${color.base07}";
                };
              };
            }
          ];
        };
    };
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
}
