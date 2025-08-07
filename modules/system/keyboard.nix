{ pkgs, ... }:

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

          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80_42003E000E5359583534332000000000-event-kbd"
          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80_42003E000E5359583534332000000000-event-if02"
          "/dev/input/by-id/usb-NuPhy_NuPhy_Gem80_42003E000E5359583534332000000000-if02-event-kbd"

          "/dev/input/by-id/usb-Nordic_Semiconductor_NuPhy_Gem80_Dongle-event-kbd"
          "/dev/input/by-id/usb-Nordic_Semiconductor_NuPhy_Gem80_Dongle-if01-event-kbd"
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

          (deflayer nrml 
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             @caps _    _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _
             _     _    _              _         _    _    @stb
          )

          (deflayer base 
             nop0  nop0 nop0 nop0 nop0 nop0 nop0 nop0 nop0 nop0 nop0 nop0 nop0    _
             _     _    _    _    _    _    _    _    _    _    _    nop0 nop0    nop0 
             @caps @a   @s   @d   @f   _    _    @j   @k   @l   @;   _    _
             nop0  _    _    @c   @v   _    @n   @m   _    _    _    nop0 
             nop0  nop0 nop0           _         nop0 nop0 @stn
          )

          (deflayer umlauts 
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
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

          (deflayer smbls1 
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             _     @exc @at  @hsh @dlr @prc @crt @and @str -    @pls \    _    _
             _     @lab @rab @lbr @rbr @ppe @lds @lcb @rcb @lb  @rb  =    _
             _     `    @tld _    _    _    _    _    _    _    _    _
             _     _    _              _         _    _    _
          )

          (deflayer smbls2
             _     _    _    _    _    _    _    _    _    _    _    _    _    _
             _     1    2    3    4    5    6    7    8    9    0    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _    _
             _     _    _    _    _    _    _    _    _    _    _    _
             _     _    _              _         _    _    _
          )

          (defvar
            tap-time 200 
            hold-time 250
          )

          (defalias
             ;; KEYS
             ss (unicode ß)
             oe (unicode ö)
             ue (unicode ü)
             ae (unicode ä)
             Oe (unicode Ö)
             Ue (unicode Ü)
             Ae (unicode Ä)

             lbr [
             rbr ]

             lcb S-[ ;; { 
             rcb S-] ;; } 

             lab S-, ;; < 
             rab S-. ;; > 

             exc S-1 ;; ! 
             at S-2 ;; @ 
             hsh S-3 ;; # 
             dlr S-4 ;; $
             prc S-5 ;; %
             crt S-6 ;; ^ 
             and S-7 ;; &
             str S-8 ;; * 
             lb S-9 ;; ( 
             rb S-0 ;; ) 

             lds S-- ;; _ 
             pls S-= ;; + 

             ppe S-\ ;; | 
             tld S-` ;; ~ 

             ;; MODIFIER
             a (tap-hold $tap-time $hold-time a lmet)
             ; (tap-hold $tap-time $hold-time ; rmet)

             s (tap-hold $tap-time $hold-time s lalt)
             l (tap-hold $tap-time $hold-time l ralt)

             d (tap-hold $tap-time $hold-time d lctl)
             k (tap-hold $tap-time $hold-time k rctl)

             f (tap-hold $tap-time $hold-time f lsft)
             j (tap-hold $tap-time $hold-time j rsft)

             ;; LAYER
             swtlyrumlauts (layer-while-held umlauts)
             swtlyrumlautscap (layer-while-held umlautscap)

             caps (tap-hold $tap-time $hold-time esc @swtlyrumlauts)
             lsft (tap-hold $tap-time $hold-time - @swtlyrumlautscap)

             swtlyrsmbls1 (layer-while-held smbls1)
             swtlyrsmbls2 (layer-while-held smbls2)

             v (tap-hold $tap-time $hold-time v @swtlyrsmbls1)
             n (tap-hold $tap-time $hold-time n @swtlyrsmbls1)

             c (tap-hold $tap-time $hold-time c @swtlyrsmbls2)
             m (tap-hold $tap-time $hold-time m @swtlyrsmbls2)

             stb (layer-switch base)
             stn (layer-switch nrml)
          )
        '';
      };
    };
  };
}
