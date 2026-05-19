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
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lmet lalt           spc            ralt rmet rctl
          ) 

          (defalias
            capsesc (tap-hold 200 200 esc caps)
          )

          (deflayer nrml 
            _        _    _    _    _    _    _    _    _    _    _    _    _    _
            _        _    _    _    _    _    _    _    _    _    _    _    _    _
            @capsesc _    _    _    _    _    _    _    _    _    _    _    _
            _        _    _    _    _    _    _    _    _    _    _    _
            _        _    _              _         _    _    - 
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
