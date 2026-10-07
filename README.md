# Config  

A modular configuration for NixOS using flakes.

## Folder Structure 
```
├── flake.lock
├── flake.nix 
├── hosts 
│   └── default 
├── modules
│   ├── home-manager
│   └── system
└── overlays
```

### `hosts`

Per-Host system configuration.

- **default**: The default host configuration used to build the system for the
first time.

### `modules`

Contains reusable modules organnized into `home-manager` and `system`.

- **home-manager**: Configuration for user-specific programs. Gets built together with the system. 
- **system**: Core system modules.

### `overlays`

Contains Nix overlays.

## Desktop configuration

Desktop modules live in `modules/home-manager/desktop/` and
`modules/system/desktop/`. All local profiles import their respective desktop
entry points. Sway is enabled by default and Niri is disabled.

Set these options in a host's `configuration.nix` to use Niri exclusively.

```nix
niri.enable = true;
sway.enable = false;
```

Enable both to make both sessions available. Disable both to omit their sessions
and shared Wayland services. Home Manager inherits these options from NixOS and
also exposes them for standalone use. Niri controls Waybar, Fuzzel, the power menu,
and its session agents. Sway controls its compositor, i3status, and screen-sharing
portal. Shared notifications, locking, and night light run when either is enabled.

Rebuild with
`sudo nixos-rebuild switch --flake .#work`, replacing `work` with your host.
Greetd keeps its existing configuration across rebuilds to preserve the running
desktop session. After changing its configuration, save your work and reboot,
or switch to a TTY and run `sudo systemctl restart greetd`. Restarting greetd
ends the current desktop session. Logging out alone does not load the new
configuration.

Greetd defaults to Sway when enabled, otherwise Niri. Press F3 to choose an enabled
session before logging in. F2 edits the launch command. On the tower, select an
enabled session in GDM. From a TTY, run `niri-session` when Niri is enabled.

Niri combines the existing Gruvbox palette and monospace typography with floating
Waybar panels, a centered clock, thin green-to-aqua window borders, soft shadows,
and a centered Fuzzel application launcher. Waybar and the power menu use SVG
squircle surfaces. The pinned Niri and Fuzzel renderers still use circular window
corners, so those retain native rounding. True squircle window clipping requires
a compositor patch.

Empty inactive workspaces are collapsed to keep the bar compact. Named workspace
shortcuts remain stable as Niri adds dynamic workspaces. Windows use 16-pixel gaps.
Click the lambda to launch an application and hover SYS for system telemetry.

Super is the modifier for these shortcuts.

| Shortcut | Action |
| --- | --- |
| Super + Enter / D | Terminal / application launcher |
| Super + 1 through 0 | Focus the corresponding named workspace |
| Super + Shift + 1 through 0 | Move the window to a named workspace |
| Super + Ctrl + 1 through 0 | Move the entire column to a named workspace |
| Super + arrows or H J K L | Focus columns horizontally and windows vertically |
| Super + Shift + arrows or H J K L | Move columns horizontally and windows vertically |
| Super + Ctrl + arrows | Focus another monitor |
| Super + Ctrl + Shift + arrows | Move the column to another monitor |
| Super + Page Up / Page Down | Scroll through workspaces |
| Super + Shift + Page Up / Page Down | Move the window between workspaces |
| Super + Ctrl + Page Up / Page Down | Reorder workspaces |
| Super + Tab | Return to the previous workspace |
| Super + O | Open the overview |
| Super + R / Shift + R | Cycle column widths / window heights |
| Super + minus / equals | Decrease / increase column width |
| Super + brackets | Group windows into columns or separate them |
| Super + W | Toggle tabbed columns |
| Super + F / Shift + F | Fullscreen window / maximize column |
| Super + C | Center the column |
| Super + Shift + Space | Toggle floating |
| Super + Space | Focus floating or tiled windows |
| Super + Shift + S / Print | Screenshot selection to clipboard |
| Ctrl + Print / Alt + Print | Screenshot screen / window to clipboard |
| Super + Ctrl + A / B / D / N | Audio / Bluetooth / displays / network settings |
| Super + E | File manager |
| Super + Escape | Lock |
| Super + Shift + Q / E | Close window / confirm logout |
| Super + Shift + slash | Show shortcut help |

Three-finger touchpad swipes scroll columns and workspaces. Four-finger swipes
open and close overview. Super plus the mouse wheel moves between workspaces,
and adding Shift moves between columns. Niri's animations remain enabled.

Click VOL for application volumes, microphones, and output selection. Middle-click
VOL for native PipeWire controls and right-click it to mute. Hover ⌘ to
reveal the desktop controls. Click BT for pairing,
NET/WIFI/ETH for connection editing, and DISPLAY for monitor arrangement, resolution,
rotation, and scaling. NetworkManager prompts for network credentials through its
session agent. POWER opens lock, suspend, logout, reboot, and shutdown controls.
The tray stays hidden, matching the existing Sway preference.

Blueman's applet and AutoConnect plugin run in both desktops, including with the
tray hidden. In Blueman, connect a device and enable its service under
Auto-connect in the device menu. Blueman retries selected services at startup,
when the adapter powers on, and every minute. Device selections remain managed
by Blueman and are preserved across rebuilds.

The session locks after ten minutes and powers displays off ten seconds later.
It also locks before suspend. Click IDLE to temporarily inhibit automatic locking.
Manual locking and locking before suspend remain available. Existing notification
styling, night-light schedule, umlaut keymap, SSH key prompt, and Kanshi profiles
are shared with Sway. Wdisplays changes are temporary. Edit
`modules/home-manager/desktop/kanshi.nix` to persist a docking profile, since reconnecting
a display reapplies that profile.

The NixOS Niri module provides the GNOME portal for screen sharing and file
selection. Xwayland Satellite starts on demand for X11 applications. Niri-specific
Waybar, idle, authentication, and network services are restricted to Niri sessions.

Run `nix build .#checks.x86_64-linux.niri-config` to validate an explicitly enabled
Niri profile with the pinned Niri version. Run
`nix build .#checks.x86_64-linux.desktop-profiles` to check Sway-only, Niri-only,
combined, and disabled desktop configurations, including greeter selection.
The bootstrap profile check evaluates the default Sway desktop without private
fonts. After logging in, check Bluetooth pairing,
audio device switching, screen sharing, display hotplug, and suspend/resume on
the actual hardware.
