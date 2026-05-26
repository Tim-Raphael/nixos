{ pkgs, ... }:

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

        config = ''
          (defsrc
            esc caps lalt ralt lmet rmet
          )

          (deflayer nrml
            caps esc lmet rmet lalt ralt
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
