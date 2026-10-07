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
  squircle =
    name: fill: stroke:
    pkgs.writeText "${name}-squircle.svg" ''
      <svg xmlns="http://www.w3.org/2000/svg" width="96" height="96" viewBox="0 0 96 96">
        <path d="M 28 1 H 68 C 91 1 95 5 95 28 V 68 C 95 91 91 95 68 95 H 28 C 5 95 1 91 1 68 V 28 C 1 5 5 1 28 1 Z"
          fill="${fill}" stroke="${stroke}" stroke-width="1"/>
      </svg>
    '';
  panel = squircle "panel" "#${color.base00}f2" "#${color.base03}b0";
  surface = squircle "surface" "#${color.base01}" "#${color.base03}";
  hover = squircle "hover" "#${color.base02}" "#${color.base04}";
  active = squircle "active" "#${color.base0B}" "#${color.base0C}";
  urgent = squircle "urgent" "#${color.base08}" "#${color.base08}";
in
{
  imports = [ ./i3status.nix ];

  config = lib.mkIf config.niri.enable {
    stylix.targets.waybar.enable = false;
    programs.wlogout = {
      enable = true;
      style = ''
        * {
          font-family: "${font.monospace.name}";
          font-size: ${toString font.sizes.desktop}pt;
        }
        window {
          background-color: rgba(${rgb "base00"}, 0.88);
        }
        button {
          color: #${color.base05};
          background-color: transparent;
          border: 1px solid transparent;
          border-radius: 0;
          border-image: url("${surface}") 28 fill / 28px;
          margin: 12px;
        background-image: none;
          box-shadow: none;
        }
        button:hover, button:focus {
          color: #${color.base07};
          border-image-source: url("${hover}");
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
        height = 38;
        margin-top = 10;
        margin-left = 16;
        margin-right = 16;
        spacing = 4;
        modules-left = [
          "custom/launcher"
          "niri/workspaces"
        ];
        modules-center =
          lib.optional (!status.enable || status.time.date.enable) "clock#date"
          ++ lib.optional (!status.enable || status.time.clock.enable) "clock#time";
        modules-right = [
          "group/system"
          "pulseaudio"
          "battery"
        ]
        ++ lib.optional (status.network.wireless.enable || status.network.ethernet.enable) "network"
        ++ [ "group/settings" ];

        "custom/launcher" = {
          format = "λ";
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
          format = "SYS";
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
            "bluetooth"
            "custom/displays"
            "idle_inhibitor"
            "custom/power"
          ];
        };
        "custom/settings" = {
          format = "⌘";
          tooltip-format = "Hover for network, Bluetooth, displays, idle, and power controls";
          on-click = "${pkgs.wdisplays}/bin/wdisplays";
          on-click-right = "${pkgs.wlogout}/bin/wlogout --buttons-per-row 5";
        };

        "niri/workspaces" = {
          format = "{value}";
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
          format = "VOL {volume}%";
          format-muted = "VOL off";
          scroll-step = 5;
          max-volume = 100;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-middle = "${pkgs.pwvucontrol}/bin/pwvucontrol";
          tooltip-format = "{desc}";
        };
        battery = {
          interval = 30;
          format = "BAT {capacity}%";
          format-charging = "BAT {capacity}% +";
          format-full = "BAT {capacity}%";
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
          format-wifi = "WIFI {signalStrength}%";
          format-ethernet = "ETH";
          format-disconnected = "NET off";
          tooltip-format-wifi = "{essid}\n{ifname}\n{ipaddr}/{cidr}\n{bandwidthDownBytes} down / {bandwidthUpBytes} up";
          tooltip-format = "{ifname}\n{ipaddr}/{cidr}\n{bandwidthDownBytes} down / {bandwidthUpBytes} up";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        bluetooth = {
          format = "BT {status}";
          format-connected = "BT {num_connections}";
          format-disabled = "BT off";
          on-click = "${pkgs.blueman}/bin/blueman-manager";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
        };
        "custom/displays" = {
          format = "DISPLAY";
          on-click = "${pkgs.wdisplays}/bin/wdisplays";
          tooltip = false;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "AWAKE";
            deactivated = "IDLE";
          };
          tooltip-format-activated = "Automatic locking paused";
          tooltip-format-deactivated = "Automatic locking enabled";
        };
        "custom/power" = {
          format = "POWER";
          on-click = "${pkgs.wlogout}/bin/wlogout --buttons-per-row 5";
          on-click-right = "${pkgs.swaylock}/bin/swaylock -f";
          tooltip = false;
        };
      };

      style = ''
        * {
          font-family: "${font.monospace.name}";
          font-size: ${toString font.sizes.desktop}pt;
          font-weight: normal;
          min-height: 0;
          border: none;
          border-radius: 0;
          box-shadow: none;
          text-shadow: none;
        }
        window#waybar {
          background: transparent;
          color: #${color.base05};
        }
        .modules-left, .modules-center, .modules-right {
          background: transparent;
          border: 1px solid transparent;
          border-image: url("${panel}") 28 fill / 16px;
          padding: 4px 8px;
        }
        #workspaces button {
          padding: 2px 9px;
          margin: 0 2px;
          color: #${color.base04};
          background: transparent;
          border: 1px solid transparent;
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
          color: #${color.base07};
          border-image: url("${surface}") 28 fill / 10px;
        }
        #workspaces button:hover {
          color: #${color.base07};
          border-image: url("${hover}") 28 fill / 10px;
        }
        #workspaces button.focused {
          color: #${color.base00};
          border-image: url("${active}") 28 fill / 10px;
        }
        #workspaces button.urgent {
          color: #${color.base00};
          border-image: url("${urgent}") 28 fill / 10px;
        }
        #custom-launcher, #custom-settings {
          color: #${color.base0B};
          font-size: 16pt;
          padding: 0 10px;
        }
        #custom-system, #temperature, #cpu, #disk, #memory,
        #pulseaudio, #battery, #network, #bluetooth,
        #custom-displays, #idle_inhibitor, #custom-power {
          font-size: ${toString (font.sizes.desktop - 1)}pt;
          padding: 0 8px;
        }
        #custom-system, #temperature, #cpu, #disk, #memory, #clock.date {
          color: #${color.base04};
        }
        #clock {
          padding: 0 6px;
        }
        #clock.time {
          color: #${color.base07};
          font-weight: bold;
        }
        #custom-launcher:hover, #custom-settings:hover, #custom-system:hover,
        #pulseaudio:hover, #network:hover, #bluetooth:hover,
        #custom-displays:hover, #idle_inhibitor:hover, #custom-power:hover {
          border-image: url("${hover}") 28 fill / 10px;
        }
        #pulseaudio, #network, #bluetooth, #battery.charging, #battery.full {
          color: #${color.base0B};
        }
        #battery.warning, #memory.warning, #idle_inhibitor.activated {
          color: #${color.base0A};
        }
        #battery.critical, #memory.critical, #temperature.critical,
        #pulseaudio.muted, #network.disconnected, #bluetooth.disabled {
          color: #${color.base08};
        }
        tooltip {
          background: transparent;
          color: #${color.base07};
          border: 1px solid transparent;
          border-image: url("${panel}") 28 fill / 16px;
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
