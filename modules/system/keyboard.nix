{ config, pkgs, ... }:

{
  services.xserver.xkb = {
    layout = "us";
  };

  # Console keymap
  console = {
    enable = true;
    keyMap = "us";
    earlySetup = true;
  };

  environment.systemPackages = with pkgs; [
    via
  ];

  # access keyboard configuration
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = with pkgs; [ via ];

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"

          "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-if01"
          "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-kbd"

          "/dev/input/by-id/usb-Keychron_Keychron_V10-event-kbd"
          "/dev/input/by-id/usb-Keychron_Keychron_V10-if02-event-kbd"

          "/dev/input/by-id/usb-Ducky_Ducky_One_3̠_DK-V1.11-220819-event-if04"
          "/dev/input/by-id/usb-Ducky_Ducky_One_3̠_DK-V1.11-220819-if01-event-kbd"
          "/dev/input/by-id/usb-Ducky_Ducky_One_3̠_DK-V1.11-220819-if03-event-kbd"

          "/dev/input/by-id/usb-Cherry_USB_keyboard-event-if01"
          "/dev/input/by-id/usb-Cherry_USB_keyboard-event-kbd"

          "/dev/input/by-id/usb-Cherry_GmbH_CHERRY_Corded_Device-event-if01"
          "/dev/input/by-id/usb-Cherry_GmbH_CHERRY_Corded_Device-event-kbd"

          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80-event-if02"
          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80-event-kbd"
          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80-if02-event-kbd"
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

          (deflayer base
            grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
            @caps a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft  z    x    c    v    b    n    m    ,    .    /    rsft
            lctl  lmet lalt           spc            ralt rmet rctl
          )  

          (deflayer umlaute 
            grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab   q    w    e    r    t    y    @ue  i    @oe  p    [    ]    \
            @caps @ae  @ss  d    f    g    h    j    k    l    ;    '    ret
            lsft  z    x    c    v    b    n    m    ,    .    /    rsft
            lctl  lmet lalt           spc            ralt rmet rctl
          )

          (defvar
            tap-time 200 
            hold-time 250
          )

          (defalias
             ss (unicode ß)
             oe (unicode ö)
             ue (unicode ü)
             ae (unicode ä)
             swtlyr (layer-while-held umlaute)
             caps (tap-hold $tap-time $hold-time esc @swtlyr)
          )
        '';
      };
    };
  };
}
