{
  config,
  lib,
  pkgs,
  ...
}:

let
  color = config.lib.stylix.colors;
  font = config.stylix.fonts;
  status = config.i3status;
  rgb = base: "${color.${"${base}-rgb-r"}}, ${color.${"${base}-rgb-g"}}, ${color.${"${base}-rgb-b"}}";
in
{
  imports = [ ./i3status.nix ];

  config = lib.mkIf config.niri.enable {
    stylix.targets.waybar = {
      enable = true;
      font = "sansSerif";
      addCss = false;
    };
    programs.wlogout = {
      enable = true;
      style = ''
        * {
          font-family: "${font.sansSerif.name}", "Symbols Nerd Font Mono", sans-serif;
          font-size: ${toString font.sizes.desktop}pt;
        }
        window {
          background-color: rgba(${rgb "base00"}, 0.3);
        }
        button {
          color: #${color.base05};
          background-color: rgba(${rgb "base00"}, 0.72);
          border: 1px solid rgba(255, 255, 255, 0.75);
          border-radius: 24px;
          margin: 12px;
          background-image: none;
          box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }
        button:hover, button:focus {
          color: #${color.base07};
          background-color: rgba(${rgb "base00"}, 0.93);
        }
      '';
      layout = [
        {
          label = "lock";
          text = "Lock [L]";
          action = "${pkgs.swaylock}/bin/swaylock -f";
          keybind = "l";
        }
        {
          label = "logout";
          text = "Log out [E]";
          action = "${pkgs.niri}/bin/niri msg action quit";
          keybind = "e";
        }
        {
          label = "suspend";
          text = "Suspend [U]";
          action = "${pkgs.systemd}/bin/systemctl suspend";
          keybind = "u";
        }
        {
          label = "reboot";
          text = "Reboot [R]";
          action = "${pkgs.systemd}/bin/systemctl reboot";
          keybind = "r";
        }
        {
          label = "shutdown";
          text = "Shut down [S]";
          action = "${pkgs.systemd}/bin/systemctl poweroff";
          keybind = "s";
        }
      ];
    };

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        targets = [ "graphical-session.target" ];
      };

      settings.mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 2;
        modules-left = [
          "custom/lambda"
          "niri/window"
          "custom/files"
          "custom/overview"
        ];
        modules-center = [ ];
        modules-right = [
          "group/system"
          "niri/workspaces"
          "bluetooth"
          "pulseaudio"
          "battery"
        ]
        ++ lib.optional (status.network.wireless.enable || status.network.ethernet.enable) "network"
        ++ [
          "custom/launcher"
          "group/settings"
        ]
        ++ lib.optional (!status.enable || status.time.date.enable) "clock#date"
        ++ lib.optional (!status.enable || status.time.clock.enable) "clock#time";

        "custom/lambda" = {
          format = "λ";
          tooltip-format = "Session menu";
          on-click = "${pkgs.wlogout}/bin/wlogout --buttons-per-row 5";
        };
        "niri/window" = {
          format = "{app_id}";
          max-length = 24;
          rewrite = {
            "Alacritty" = "Terminal";
            "(zen|zen-beta|firefox)" = "Browser";
            "(dev.zed.Zed|code|Code)" = "Editor";
            "org.gnome.Nautilus" = "Files";
            "org.gnome.(.*)" = "$1";
          };
        };
        "custom/files" = {
          format = "Files";
          tooltip-format = "Open file manager";
          on-click = "${pkgs.nautilus}/bin/nautilus";
        };
        "custom/overview" = {
          format = "Windows";
          tooltip-format = "Toggle workspace overview";
          on-click = "${pkgs.niri}/bin/niri msg action toggle-overview";
        };
        "custom/launcher" = {
          format = "";
          tooltip-format = "Launch application · Super + D";
          on-click = "${pkgs.fuzzel}/bin/fuzzel";
        };
        "group/system" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 200;
            transition-left-to-right = false;
            children-class = "telemetry";
          };
          modules = [
            "custom/system"
          ]
          ++ lib.optional status.system.cpu.temperature.enable "temperature"
          ++ lib.optional (!status.enable || status.system.cpu.usage.enable) "cpu"
          ++ lib.optional (!status.enable || status.system.disk.root.enable) "disk"
          ++ lib.optional status.system.memory.enable "memory";
        };
        "custom/system" = {
          format = "";
          tooltip-format = "Hover for system telemetry";
        };

        "group/settings" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 150;
            transition-left-to-right = false;
            children-class = "desktop-controls";
          };
          modules = [
            "custom/settings"
          ]
          ++ lib.optional (!status.network.wireless.enable && !status.network.ethernet.enable) "network"
          ++ [
            "custom/displays"
            "idle_inhibitor"
            "custom/power"
          ];
        };
        "custom/settings" = {
          format = "";
          tooltip-format = "Hover for network, Bluetooth, displays, idle, and power controls";
          on-click = "${pkgs.wdisplays}/bin/wdisplays";
          on-click-right = "${pkgs.wlogout}/bin/wlogout --buttons-per-row 5";
        };

        "niri/workspaces" = {
          format = "•";
          all-outputs = true;
          disable-markup = true;
        };

        temperature = {
          interval = status.interval;
          format = "TEMP {temperatureC}°";
          critical-threshold = 90;
        }
        // lib.optionalAttrs (status.system.cpu.temperature.path != null) {
          hwmon-path = status.system.cpu.temperature.path;
        };
        cpu = {
          interval = status.interval;
          format = "CPU {usage}%";
        };
        disk = {
          interval = 30;
          path = "/";
          format = "SSD {free}";
        };
        memory = {
          interval = status.interval;
          format = "MEM {used:0.1f}G";
          states = {
            warning = 90;
            critical = 95;
          };
        };
        "clock#date" = {
          format = "{:%a %d %b}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
        "clock#time" = {
          interval = 60;
          format = "{:%H:%M}";
          tooltip = false;
        };
        pulseaudio = {
          format = "{icon}";
          format-muted = "󰖁";
          format-icons = [
            ""
            ""
            ""
          ];
          scroll-step = 5;
          max-volume = 100;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-middle = "${pkgs.pwvucontrol}/bin/pwvucontrol";
          tooltip-format = "{desc} · {volume}%";
        };
        battery = {
          interval = 30;
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-full = "{capacity}% ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip-format = "{timeTo}";
          format-time = "{H}h{M}m";
          states = {
            warning = status.power.battery.lowThreshold;
            critical = 10;
          };
        }
        // lib.optionalAttrs status.power.battery.enable {
          bat = builtins.baseNameOf (builtins.dirOf status.power.battery.path);
        };
        network = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid}\n{ifname}\n{ipaddr}/{cidr}\n{bandwidthDownBytes} down / {bandwidthUpBytes} up";
          tooltip-format = "{ifname}\n{ipaddr}/{cidr}\n{bandwidthDownBytes} down / {bandwidthUpBytes} up";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        bluetooth = {
          format = "";
          format-connected = "󰂱";
          format-disabled = "󰂲";
          tooltip-format = "Bluetooth {status}";
          on-click = "${pkgs.blueman}/bin/blueman-manager";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
        };
        "custom/displays" = {
          format = "";
          on-click = "${pkgs.wdisplays}/bin/wdisplays";
          tooltip-format = "Display settings";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "󰒲";
          };
          tooltip-format-activated = "Automatic locking paused";
          tooltip-format-deactivated = "Automatic locking enabled";
        };
        "custom/power" = {
          format = "";
          on-click = "${pkgs.wlogout}/bin/wlogout --buttons-per-row 5";
          on-click-right = "${pkgs.swaylock}/bin/swaylock -f";
          tooltip-format = "Session menu · Right-click to lock";
        };
      };

      style = ''
        * {
          font-weight: normal;
          min-height: 0;
          border: none;
          border-radius: 0;
          box-shadow: none;
          text-shadow: none;
        }
        window#waybar {
          background: transparent;
          color: #f5f5f5;
        }
        window#waybar label {
          text-shadow: 0 1px 2px rgba(0, 0, 0, 0.6);
        }
        .modules-left, .modules-center, .modules-right {
          background: transparent;
          padding: 0 10px;
        }
        #workspaces button {
          padding: 0 4px;
          margin: 4px 0;
          color: inherit;
          background: transparent;
          border-radius: 6px;
          transition: color 160ms ease;
        }
        #workspaces button.empty:not(.active):not(.urgent) {
          font-size: 0;
          min-width: 0;
          padding: 0;
          margin: 0;
          border-width: 0;
        }
        #workspaces button.empty:not(.active):not(.urgent) label {
          font-size: 0;
        }
        #workspaces button.active {
          background: alpha(currentColor, 0.12);
        }
        #workspaces button:hover {
          background: alpha(currentColor, 0.18);
        }
        #workspaces button.focused {
          background: alpha(currentColor, 0.15);
        }
        #workspaces button.urgent {
          color: #${color.base08};
          background: rgba(${rgb "base08"}, 0.15);
        }
        #custom-lambda {
          font-size: 15pt;
          padding: 0 10px;
        }
        #window {
          font-weight: bold;
          padding: 0 10px;
        }
        #custom-files, #custom-overview {
          padding: 0 10px;
        }
        #custom-launcher, #custom-settings,
        #custom-system, #temperature, #cpu, #disk, #memory,
        #pulseaudio, #battery, #network, #bluetooth,
        #custom-displays, #idle_inhibitor, #custom-power {
          padding: 0 7px;
        }
        #clock {
          padding: 0 6px;
        }
        #clock.time {
          font-weight: 500;
        }
        #custom-lambda, #custom-files, #custom-overview,
        #custom-launcher, #custom-settings, #custom-system,
        #pulseaudio, #network, #bluetooth, #custom-displays,
        #idle_inhibitor, #custom-power {
          border-radius: 6px;
          margin: 2px 0;
          transition: background-color 160ms ease;
        }
        #custom-lambda:hover, #custom-files:hover, #custom-overview:hover,
        #custom-launcher:hover, #custom-settings:hover, #custom-system:hover,
        #pulseaudio:hover, #network:hover, #bluetooth:hover,
        #custom-displays:hover, #idle_inhibitor:hover, #custom-power:hover {
          background-color: alpha(currentColor, 0.18);
        }
        #battery.warning, #memory.warning, #idle_inhibitor.activated {
          color: #${color.base0A};
        }
        #battery.critical, #memory.critical, #temperature.critical,
        #pulseaudio.muted, #network.disconnected, #bluetooth.disabled {
          color: #${color.base08};
        }
        tooltip {
          background: rgba(${rgb "base00"}, 0.92);
          color: #${color.base05};
          border: 1px solid rgba(255, 255, 255, 0.75);
          border-radius: 12px;
        }
        tooltip label {
          padding: 10px 14px;
        }
      '';
    };

    systemd.user.services.waybar = {
      Unit.ConditionEnvironment = lib.mkForce "XDG_CURRENT_DESKTOP=niri";
      Install.WantedBy = lib.mkForce [ "graphical-session.target" ];
    };
  };
}
