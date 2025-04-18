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
    mako # notification system developed by swaywm maintainer
    shotman # screenshot util
    gtk4 # toolkit for creating graphical interfaces
    i3status
    waybar
    networkmanagerapplet
    blueman
    dmenu-wayland
    swaylock
  ];

  wayland = {
    windowManager.sway = {
      enable = true;
      checkConfig = true;
      systemd.enable = true;

      wrapperFeatures = {
        gtk = true;
      };

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
              command = "nm-applet";
              always = true;
            }
            {
              command = "blueman-applet";
              always = true;
            }
          ];

          keybindings = lib.mkOptionDefault {
            "${modifier}+Escape" = "exec swaylock";
            "${modifier}+d" =
              "exec dmenu-wl_run -b -fn '${config.fonts.systemFont.main}' -nb '#${config.colorScheme.palette.base00}' -nf '#${config.colorScheme.palette.base07}' -sb '#${config.colorScheme.palette.base0B}' -sf '#${config.colorScheme.palette.base00}'";
          };

          fonts = {
            names = [ "${config.fonts.systemFont.main}" ];
            style = "Regular";
            size = 10.0;
          };

          output = {
            "*" = {
              bg = "#${config.colorScheme.palette.base00} solid_color";
            };
          };

          colors = {
            background = "#${config.colorScheme.palette.base00}";

            focused = {
              background = "#${config.colorScheme.palette.base07}";
              border = "#${config.colorScheme.palette.base07}";
              childBorder = "#${config.colorScheme.palette.base07}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base00}";
            };

            focusedInactive = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base00}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };

            placeholder = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base00}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };

            unfocused = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base00}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };

            urgent = {
              background = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
              childBorder = "#${config.colorScheme.palette.base00}";
              indicator = "#${config.colorScheme.palette.base08}";
              text = "#${config.colorScheme.palette.base07}";
            };
          };

          bars = [
            {
              statusCommand = "${pkgs.i3status}/bin/i3status";

              fonts = {
                names = [ "${config.fonts.systemFont.main}" ];
                style = "Regular";
                size = 10.0;
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
                  background = "#${config.colorScheme.palette.base07}";
                  border = "#${config.colorScheme.palette.base07}";
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

  programs.mako = {
    enable = true;

    defaultTimeout = 5000;

    font = "${config.fonts.systemFont.main}";
    borderColor = "${config.colorScheme.palette.base07}";
    backgroundColor = "${config.colorScheme.palette.base00}";
  };

  programs.swaylock = {
    enable = true;
    settings = {
      font = "${config.fonts.systemFont.main}";

      color = "${config.colorScheme.palette.base00}";
      inside-color = "${config.colorScheme.palette.base00}";
      separator-color = "${config.colorScheme.palette.base07}";
      ring-color = "${config.colorScheme.palette.base07}";
      text-color = "${config.colorScheme.palette.base07}";
      key-hl-color = "${config.colorScheme.palette.base0B}";

      line-uses-inside = true;
    };
  };
}
