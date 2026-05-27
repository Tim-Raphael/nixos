{
  pkgs,
  config,
  lib,
  ...
}:

let
  colors = config.lib.stylix.colors;
  fonts = config.stylix.fonts;

  ws1 = "1:terminal";
  ws2 = "2:editor";
  ws3 = "3:browser";
  ws4 = "4:messages";
  ws5 = "5:misc";
  ws6 = "6:misc";
  ws7 = "7:misc";
  ws8 = "8:misc";
  ws9 = "9:misc";
  ws0 = "0:misc";
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
          defaultWorkspace = "1";

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
              "exec dmenu-wl_run -m $(swaymsg -t get_outputs | jq -r 'map(.focused) | index(true)') -fn '${fonts.monospace.name}' -nb '#${colors.base00}' -nf '#${colors.base07}' -sb '#${colors.base0A}' -sf '#${colors.base00}'";

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
              #bg = "#${colors.base00} solid_color";
            };
          };

          gaps = {
            smartBorders = "on";
            smartGaps = true;
            inner = 16;
          };

          #colors = {
          #  background = "#${colors.base00}";

          #  focused = {
          #    background = "#${colors.base0A}";
          #    border = "#${colors.base0A}";
          #    childBorder = "#${colors.base0A}";
          #    indicator = "#${colors.base08}";
          #    text = "#${colors.base00}";
          #  };

          #  focusedInactive = {
          #    background = "#${colors.base03}";
          #    border = "#${colors.base03}";
          #    childBorder = "#${colors.base03}";
          #    indicator = "#${colors.base08}";
          #    text = "#${colors.base07}";
          #  };

          #  placeholder = {
          #    background = "#${colors.base03}";
          #    border = "#${colors.base03}";
          #    childBorder = "#${colors.base03}";
          #    indicator = "#${colors.base08}";
          #    text = "#${colors.base07}";
          #  };

          #  unfocused = {
          #    background = "#${colors.base03}";
          #    border = "#${colors.base03}";
          #    childBorder = "#${colors.base03}";
          #    indicator = "#${colors.base08}";
          #    text = "#${colors.base07}";
          #  };

          #  urgent = {
          #    background = "#${colors.base08}";
          #    border = "#${colors.base08}";
          #    childBorder = "#${colors.base08}";
          #    indicator = "#${colors.base0A}";
          #    text = "#${colors.base07}";
          #  };
          #};

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
                style = "Regular";
                names = [ "${fonts.monospace.name}" ];
                size = fonts.sizes.desktop * 1.0; # little hack to convert into float
              };

              colors = {
                background = "#${colors.base00}";
                focusedBackground = "#${colors.base00}";

                focusedStatusline = "#${colors.base07}";
                statusline = "#${colors.base07}";

                focusedSeparator = "#${colors.base04}";
                separator = "#${colors.base04}";

                urgentWorkspace = {
                  background = "#${colors.base08}";
                  border = "#${colors.base08}";
                  text = "#${colors.base00}";
                };

                focusedWorkspace = {
                  background = "#${colors.base0A}";
                  border = "#${colors.base0A}";
                  text = "#${colors.base00}";
                };

                activeWorkspace = {
                  background = "#${colors.base00}";
                  border = "#${colors.base00}";
                  text = "#${colors.base07}";
                };

                inactiveWorkspace = {
                  background = "#${colors.base00}";
                  border = "#${colors.base00}";
                  text = "#${colors.base07}";
                };

                bindingMode = {
                  background = "#${colors.base00}";
                  border = "#${colors.base00}";
                  text = "#${colors.base07}";
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
    };
  };

  programs.swaylock = {
    enable = true;
    #settings = {
    #  color = "${colors.base00}";
    #  inside-color = "${colors.base00}";
    #  inside-clear-color = "${colors.base07}";
    #  inside-ver-color = "${colors.base0D}";
    #  inside-wrong-color = "${colors.base08}";
    #  separator-color = "${colors.base07}";
    #  ring-color = "${colors.base07}";
    #  text-color = "${colors.base07}";
    #  key-hl-color = "${colors.base0A}";
    #  bs-hl-color = "${colors.base08}";
    #  line-uses-inside = true;
    #};
  };
}
