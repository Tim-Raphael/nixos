{ config, pkgs, ... }:

{
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
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             @caps _    _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _
             _     _    _              _         _    _    _
          )

          (deflayer umlauts 
             _     _    _    _    _    _    _    _    _    _    _    @dsh _    _
             _     _    _    _    _    _    _    @ue  _    @oe  _    _    _    _
             @caps @ae  @ss  _    _    _    _    _    _    _    _    _    _
             @lsft _    _    _    _    _    _    _    _    _    _    _
             _     _    _              _              _    _    _
          )

          (deflayer umlautscap 
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    @Ue  _    @Oe  _    _    _    _
             _     @Ae  _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _
             _     _    _              _         _    _    _
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
             Oe (unicode Ö)
             Ue (unicode Ü)
             Ae (unicode Ä)
             dsh (unicode –)

             swtlyrumlauts (layer-while-held umlauts)
             swtlyrumlautscap (layer-while-held umlautscap)

             caps (tap-hold $tap-time $hold-time esc @swtlyrumlauts)
             lsft (tap-hold $tap-time $hold-time - @swtlyrumlautscap)
          )
        '';
      };
    };
  };
}
