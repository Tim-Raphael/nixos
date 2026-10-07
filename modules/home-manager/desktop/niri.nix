{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

let
  color = config.lib.stylix.colors;
  font = config.stylix.fonts;
  cursor =
    if config.stylix.cursor != null then
      config.stylix.cursor
    else
      {
        name = "Adwaita";
        size = 24;
      };
  umlautKeymap = import ./umlaut-keymap.nix { inherit pkgs; };
  workspaces = [
    "1:terminal"
    "2:editor"
    "3:agent"
    "4:browser"
    "5:misc"
    "6:misc"
    "7:misc"
    "8:message"
    "9:note"
    "0:todo"
  ];
  workspaceConfig = lib.concatMapStringsSep "\n" (name: ''workspace "${name}"'') workspaces;
  workspaceBinds = lib.concatMapStringsSep "\n" (
    name:
    let
      key = builtins.substring 0 1 name;
    in
    ''
      Mod+${key} { focus-workspace "${name}"; }
      Mod+Shift+${key} { move-window-to-workspace "${name}"; }
      Mod+Ctrl+${key} { move-column-to-workspace "${name}"; }
    ''
  ) workspaces;
in
{
  imports = [
    ./wayland-desktop.nix
    ./waybar.nix
  ];

  options.niri.enable = lib.mkEnableOption "niri desktop" // {
    default = osConfig.niri.enable or false;
  };

  config = lib.mkIf config.niri.enable {
    home.packages = with pkgs; [
      niri
      blueman
      pavucontrol
      pwvucontrol
      networkmanagerapplet
      wdisplays
      nautilus
      playerctl
      nerd-fonts.symbols-only
    ];

    stylix.opacity.terminal = 0.86;

    services.mako.settings = {
      font = lib.mkForce "${font.sansSerif.name} ${toString (font.sizes.desktop + 1)}";
      background-color = lib.mkForce "#${color.base00}d9";
      text-color = "#${color.base05}";
      border-color = lib.mkForce "#ffffffb3";
      border-size = 1;
      border-radius = 18;
      padding = lib.mkForce "16";
    };

    stylix.targets.fuzzel.enable = false;
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "${font.sansSerif.name}:size=${toString (font.sizes.desktop + 3)}";
          terminal = "${pkgs.alacritty}/bin/alacritty -e";
          prompt = "⌕  ";
          placeholder = "Search applications";
          icon-theme = "Adwaita";
          width = 42;
          lines = 7;
          horizontal-pad = 24;
          vertical-pad = 20;
          inner-pad = 12;
        };
        colors = {
          background = "${color.base00}d9";
          text = "${color.base05}ff";
          prompt = "${color.base05}ff";
          placeholder = "${color.base04}ff";
          input = "${color.base07}ff";
          match = "${color.base0C}ff";
          selection = "${color.base02}b3";
          selection-text = "${color.base07}ff";
          selection-match = "${color.base0B}ff";
          border = "ffffffc0";
        };
        border = {
          width = 1;
          radius = 22;
        };
      };
    };

    services.swayidle = {
      enable = true;
      systemdTargets = [ "graphical-session.target" ];
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 610;
          command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
        }
      ];
      events = {
        before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
        after-resume = "${pkgs.niri}/bin/niri msg action power-on-monitors";
        lock = "${pkgs.swaylock}/bin/swaylock -f";
      };
    };

    systemd.user.services = {
      swayidle.Unit.ConditionEnvironment = lib.mkForce "XDG_CURRENT_DESKTOP=niri";

      niri-wallpaper = {
        Unit = {
          Description = "Desktop wallpaper for Niri";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
        };
        Service = {
          ExecStart = "${pkgs.quickshell}/bin/quickshell -p ${./themes/wallpaper}";
          Environment = [ "WALLPAPER_IMAGE=${config.stylix.image}" ];
          Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      niri-polkit = {
        Unit = {
          Description = "Authentication agent for Niri";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
        };
        Service = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      niri-network-agent = {
        Unit = {
          Description = "Network credentials and connections for Niri";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
        };
        Service = {
          ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };

    xdg.configFile."niri/config.kdl".text = ''
      input {
          keyboard {
              xkb { file "${umlautKeymap}"; }
          }
          touchpad {
              tap
              dwt
              natural-scroll
          }
          mouse {
              accel-speed 1.0
              accel-profile "flat"
          }
          trackpoint {
              accel-speed 1.0
              accel-profile "flat"
          }
          focus-follows-mouse max-scroll-amount="0%"
      }

      layout {
          gaps 16
          background-color "transparent"
          center-focused-column "on-overflow"
          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }
          default-column-width { proportion 0.5; }
          focus-ring { off; }
          border {
              width 1
              active-gradient from="#ffffffd9" to="#${color.base0D}80" angle=135
              inactive-color "#ffffff55"
              urgent-color "#${color.base08}"
          }
          shadow {
              on
              softness 32
              spread 2
              offset x=0 y=6
              color "#00000035"
              inactive-color "#00000020"
          }
          tab-indicator {
              active-color "#${color.base0B}"
              inactive-color "#${color.base03}"
              urgent-color "#${color.base08}"
          }
      }

      prefer-no-csd
      cursor {
          xcursor-theme "${cursor.name}"
          xcursor-size ${toString cursor.size}
      }
      overview { backdrop-color "#${color.base00}"; }
      screenshot-path null

      blur {
          passes 3
          offset 3.0
          noise 0.015
          saturation 1.15
      }

      layer-rule {
          match namespace="^spatial-wallpaper$"
          place-within-backdrop true
      }

      layer-rule {
          match namespace="^(launcher|logout_dialog|notifications)$"
          background-effect {
              blur true
              xray true
          }
      }

      layer-rule {
          match namespace="^launcher$"
          geometry-corner-radius 22
          shadow {
              on
              softness 32
              spread 2
              offset x=0 y=8
              color "#00000030"
          }
      }

      layer-rule {
          match namespace="^waybar$"
          popups {
              background-effect { blur true; }
          }
      }

      ${workspaceConfig}

      spawn-sh-at-startup "alacritty --command ssh-add ~/.ssh/github"

      window-rule {
          geometry-corner-radius 18
          clip-to-geometry true
          draw-border-with-background false
      }

      window-rule {
          match app-id="^Alacritty$"
          background-effect {
              blur true
              xray true
          }
      }

      window-rule {
          match is-floating=true
          shadow {
              softness 36
              spread 4
              offset x=0 y=10
              color "#00000070"
          }
      }

      window-rule {
          match app-id=r#"^(org\.pulseaudio\.pavucontrol|com\.saivert\.pwvucontrol|blueman-manager|nm-connection-editor|wdisplays)$"#
          open-floating true
      }

      binds {
          Mod+Return hotkey-overlay-title="Open terminal" { spawn "alacritty"; }
          Mod+D hotkey-overlay-title="Launch application" {
              spawn "${pkgs.fuzzel}/bin/fuzzel";
          }
          Mod+Escape hotkey-overlay-title="Lock screen" { spawn "${pkgs.swaylock}/bin/swaylock" "-f"; }
          Mod+Shift+E { quit; }
          Mod+Shift+Q { close-window; }
          Mod+Shift+Slash { show-hotkey-overlay; }
          Mod+O repeat=false hotkey-overlay-title="Toggle overview" { toggle-overview; }

          Mod+Left { focus-column-left; }
          Mod+Down { focus-window-down; }
          Mod+Up { focus-window-up; }
          Mod+Right { focus-column-right; }
          Mod+H { focus-column-left; }
          Mod+J { focus-window-down; }
          Mod+K { focus-window-up; }
          Mod+L { focus-column-right; }
          Mod+Shift+Left { move-column-left; }
          Mod+Shift+Down { move-window-down; }
          Mod+Shift+Up { move-window-up; }
          Mod+Shift+Right { move-column-right; }
          Mod+Shift+H { move-column-left; }
          Mod+Shift+J { move-window-down; }
          Mod+Shift+K { move-window-up; }
          Mod+Shift+L { move-column-right; }
          Mod+Home { focus-column-first; }
          Mod+End { focus-column-last; }

          Mod+Ctrl+Left { focus-monitor-left; }
          Mod+Ctrl+Down { focus-monitor-down; }
          Mod+Ctrl+Up { focus-monitor-up; }
          Mod+Ctrl+Right { focus-monitor-right; }
          Mod+Ctrl+Shift+Left { move-column-to-monitor-left; }
          Mod+Ctrl+Shift+Down { move-column-to-monitor-down; }
          Mod+Ctrl+Shift+Up { move-column-to-monitor-up; }
          Mod+Ctrl+Shift+Right { move-column-to-monitor-right; }

          Mod+Page_Up { focus-workspace-up; }
          Mod+Page_Down { focus-workspace-down; }
          Mod+Shift+Page_Up { move-window-to-workspace-up; }
          Mod+Shift+Page_Down { move-window-to-workspace-down; }
          Mod+Ctrl+Page_Up { move-workspace-up; }
          Mod+Ctrl+Page_Down { move-workspace-down; }
          Mod+Tab { focus-workspace-previous; }
          Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
          Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollLeft { focus-column-left; }
          Mod+WheelScrollRight { focus-column-right; }
          Mod+Shift+WheelScrollUp { focus-column-left; }
          Mod+Shift+WheelScrollDown { focus-column-right; }

          ${workspaceBinds}

          Mod+BracketLeft { consume-or-expel-window-left; }
          Mod+BracketRight { consume-or-expel-window-right; }
          Mod+W hotkey-overlay-title="Toggle column tabs" { toggle-column-tabbed-display; }
          Mod+R hotkey-overlay-title="Cycle column width" { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }
          Mod+F { fullscreen-window; }
          Mod+Shift+F { maximize-column; }
          Mod+Ctrl+F { expand-column-to-available-width; }
          Mod+C { center-column; }
          Mod+Shift+Space { toggle-window-floating; }
          Mod+Space { switch-focus-between-floating-and-tiling; }

          Mod+Shift+S hotkey-overlay-title="Select screenshot region" { screenshot; }
          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Mod+Ctrl+A hotkey-overlay-title="Audio settings" { spawn "${pkgs.pavucontrol}/bin/pavucontrol"; }
          Mod+Ctrl+B hotkey-overlay-title="Bluetooth settings" { spawn "${pkgs.blueman}/bin/blueman-manager"; }
          Mod+Ctrl+D hotkey-overlay-title="Display settings" { spawn "${pkgs.wdisplays}/bin/wdisplays"; }
          Mod+Ctrl+N hotkey-overlay-title="Network settings" { spawn "${pkgs.networkmanagerapplet}/bin/nm-connection-editor"; }
          Mod+E hotkey-overlay-title="Open file manager" { spawn "${pkgs.nautilus}/bin/nautilus"; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@" "5%+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
          XF86AudioMute allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioMicMute allow-when-locked=true { spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
          XF86AudioPlay allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "play-pause"; }
          XF86AudioPause allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "pause"; }
          XF86AudioStop allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "stop"; }
          XF86AudioNext allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "next"; }
          XF86AudioPrev allow-when-locked=true { spawn "${pkgs.playerctl}/bin/playerctl" "previous"; }
          XF86MonBrightnessUp allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "+5%"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "--min-value=1" "set" "5%-"; }
      }
    '';
  };
}
