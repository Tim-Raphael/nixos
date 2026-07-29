{ ... }:

let
  # systemd sandboxing shared by each kanata instance.
  hardening = {
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
in
{
  # Console keymap
  console = {
    enable = true;
    keyMap = "us";
    earlySetup = true;
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          "/dev/input/by-id/usb-Cherry_GmbH_CHERRY_Corded_Device-event-kbd"
        ];

        extraDefCfg = "process-unmapped-keys yes";

        # Alt <-> Meta swap on the bottom row, shared by every physical keyboard.
        config = ''
          (defsrc
            lalt ralt lmet rmet
          )

          (deflayer nrml
            lmet rmet lalt ralt
          )
        '';
      };

      # NuPhy Air 60 V2 (2.4GHz dongle). Its switches chatter, producing
      # double key presses, so this instance debounces it.
      nuphy = {
        devices = [
          "/dev/input/by-id/usb-Nordic_Semiconductor_NuPhy_Air60_V2_Dongle-event-kbd"
        ];

        extraDefCfg = ''
          process-unmapped-keys yes
          debounce-duration 50 
          debounce-algorithm asym_eager_defer_pk
        '';
        config = ''
          (defsrc)
          (deflayer nrml)
        '';
      };
    };
  };

  systemd.services.kanata-internalKeyboard.serviceConfig = hardening;
  systemd.services.kanata-nuphy.serviceConfig = hardening;
}
