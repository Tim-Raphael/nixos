{ pkgs, ... }:

{
  # Console keymap
  console = {
    enable = true;
    keyMap = "us";
    earlySetup = true;
  };

  # Graphical keymap: US intl with direct German umlauts on Alt
  services.xserver.xkb = {
    layout = "us-umlaut-alt";
    variant = "basic";

    extraLayouts.us-umlaut-alt = {
      description = "English (US, international with German umlaut)";
      languages = [
        "eng"
        "deu"
      ];
      symbolsFile = pkgs.writeText "xkb-us-umlaut-alt" ''
        default partial alphanumeric_keys
        xkb_symbols "basic" {
          include "us(altgr-intl)"
          include "level3(ralt_switch)"
          name[Group1] = "English (US, international with German umlaut)";
          key <AD03> { [ e, E, EuroSign, cent ] };
          key <AD07> { [ u, U, udiaeresis, Udiaeresis ] };
          key <AD09> { [ o, O, odiaeresis, Odiaeresis ] };
          key <AC01> { [ a, A, adiaeresis, Adiaeresis ] };
          key <AC02> { [ s, S, ssharp ] };
        };
      '';
    };
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"

          "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-if01"
          "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-kbd"

          "/dev/input/by-id/usb-Cherry_USB_keyboard-event-if01"
          "/dev/input/by-id/usb-Cherry_USB_keyboard-event-kbd"

          "/dev/input/by-id/usb-Cherry_GmbH_CHERRY_Corded_Device-event-if01"
          "/dev/input/by-id/usb-Cherry_GmbH_CHERRY_Corded_Device-event-kbd"

          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80_42003E000E5359583534332000000000-if02-event-kbd"
        ];

        extraDefCfg = "process-unmapped-keys yes";

        config = ''
          (defsrc
            caps
          )

          (defalias
            capsesc (tap-hold 200 200 esc caps)
          )

          (deflayer nrml
            @capsesc
          )
        '';
      };
    };
  };

  systemd.services.kanata-internalKeyboard.serviceConfig = {
    NoNewPrivileges = true;
    PrivateTmp = true;
    ProtectHome = true;
    ProtectSystem = "strict";
    Restart = "on-failure";
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
    DeviceAllow = [
      "/dev/input/* rw"
      "/dev/uinput rw"
    ];
  };
}
