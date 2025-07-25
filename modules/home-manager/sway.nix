{
  pkgs,
  config,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wlr-randr # screenmanager util
    grim
    slurp
    mako # notification system developed by swaywm maintainer
    shotman # screenshot util
    gtk4 # toolkit for creating graphical interfaces
    i3status
    waybar
    blueman
    dmenu-wayland
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
          defaultWorkspace = "workspace number 1";

          startup = [
            {
              command = "alacritty --command ssh-add";
              always = true;
            }
            {
              command = "blueman-applet";
              always = true;
            }
          ];

          keybindings = lib.mkOptionDefault {
            "${modifier}+Escape" = "exec swaylock";
            "${modifier}+Shift+s" = "exec grim -g $(slurp)";
            "${modifier}+d" =
              "exec dmenu-wl_run -b -fn '${config.fonts.systemFont.main.name}' -nb '#${config.colorScheme.palette.base00}' -nf '#${config.colorScheme.palette.base07}' -sb '#${config.colorScheme.palette.base0B}' -sf '#${config.colorScheme.palette.base00}'";
          };

          fonts = {
            names = [ "${config.fonts.systemFont.main.name}" ];
            style = "Regular";
            size = config.fonts.systemFont.main.size-small * 1.0; # little hack to convert into float
          };

          input = {
            "*" = {
              pointer_accel = "1";
              accel_profile = "flat";
            };
          };

          output = {
            "*" = {
              bg = "#${config.colorScheme.palette.base00} solid_color";
            };
          };

          gaps = {
            smartBorders = "on";
            smartGaps = true;
            inner = 16;
          };

          colors = {
            background = "#${config.colorScheme.palette.base00}";

            focused = {
              background = "#${config.colorScheme.palette.base07}";
              border = "#${config.colorScheme.palette.base07}";
              childBorder = "#${config.colorScheme.palette.base0B}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base00}";
            };

            focusedInactive = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base03}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };

            placeholder = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base03}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };

            unfocused = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base03}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };

            urgent = {
              background = "#${config.colorScheme.palette.base08}";
              border = "#${config.colorScheme.palette.base08}";
              childBorder = "#${config.colorScheme.palette.base08}";
              indicator = "#${config.colorScheme.palette.base0A}";
              text = "#${config.colorScheme.palette.base07}";
            };
          };

          bars = [
            {
              statusCommand = "${pkgs.i3status}/bin/i3status";

              # Disabled for now, because some programs always spams my tray
              # with sad smileys (heulis).
              trayOutput = "none";

              fonts = {
                names = [ "${config.fonts.systemFont.main.name}" ];
                style = "Regular";
                size = config.fonts.systemFont.main.size-small * 1.0; # little hack to convert into float
              };

              colors = {
                background = "#${config.colorScheme.palette.base00}";
                focusedBackground = "#${config.colorScheme.palette.base00}";

                focusedStatusline = "#${config.colorScheme.palette.base07}";
                statusline = "#${config.colorScheme.palette.base07}";

                focusedSeparator = "#${config.colorScheme.palette.base07}";
                separator = "#${config.colorScheme.palette.base07}";

                urgentWorkspace = {
                  background = "#${config.colorScheme.palette.base08}";
                  border = "#${config.colorScheme.palette.base08}";
                  text = "#${config.colorScheme.palette.base00}";
                };

                focusedWorkspace = {
                  background = "#${config.colorScheme.palette.base0B}";
                  border = "#${config.colorScheme.palette.base0B}";
                  text = "#${config.colorScheme.palette.base00}";
                };

                activeWorkspace = {
                  background = "#${config.colorScheme.palette.base00}";
                  border = "#${config.colorScheme.palette.base00}";
                  text = "#${config.colorScheme.palette.base07}";
                };

                inactiveWorkspace = {
                  background = "#${config.colorScheme.palette.base00}";
                  border = "#${config.colorScheme.palette.base00}";
                  text = "#${config.colorScheme.palette.base07}";
                };

                bindingMode = {
                  background = "#${config.colorScheme.palette.base00}";
                  border = "#${config.colorScheme.palette.base00}";
                  text = "#${config.colorScheme.palette.base07}";
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

      font = "#${config.fonts.systemFont.main.name}";
      border-color = "#${config.colorScheme.palette.base07}";
      background-color = "#${config.colorScheme.palette.base00}";

      padding = "10";
      size = config.fonts.systemFont.main.size-small;
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      font = "${config.fonts.systemFont.main.name}";
      size = config.fonts.systemFont.main.size-small;

      color = "${config.colorScheme.palette.base00}";

      inside-color = "${config.colorScheme.palette.base00}";
      inside-clear-color = "${config.colorScheme.palette.base07}";
      inside-ver-color = "${config.colorScheme.palette.base0D}";
      inside-wrong-color = "${config.colorScheme.palette.base08}";

      separator-color = "${config.colorScheme.palette.base07}";

      ring-color = "${config.colorScheme.palette.base07}";

      text-color = "${config.colorScheme.palette.base07}";

      key-hl-color = "${config.colorScheme.palette.base0B}";
      bs-hl-color = "${config.colorScheme.palette.base08}";

      line-uses-inside = true;
    };
  };
}
