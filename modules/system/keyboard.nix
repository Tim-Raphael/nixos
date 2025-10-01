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

          (deflayer base 
            @no   @no  @no  @no  @no  @no  @no  @no  @no  @no  @no  @no  @no  @no 
            @no   _    _    _    _    _    _    _    _    _    _    @no  @no  @no 
            @caps @a   @s   @d   @f   _    _    @j   @k   @l   @;   _    @no 
            @no   _    @x   @c   @v   _    @n   @m   @,   _    _    @no 
            @no   @no  @no            _         @no  @no  @stn
          )

          (deflayer nrml 
            _     _    _    _    _    _    _    _    _    _    _    _    _    _
            _     _    _    _    _    _    _    _    _    _    _    _    _    _
            @caps _    _    _    _    _    _    _    _    _    _    _    _
            _     _    _    _    _    _    _    _    _    _    _    _
            _     _    _              _         _    _    @stb
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

          (deflayer sym 
            _     _    _    _    _    _    _    _    _    _    _    _    _    _
            _     @exc @at  @hsh @dlr @prc @crt @and @str @qts '    _    _    _
            _     @lab @lcb @lb  @lbr @ppe @lds @rbr @rb  @rcb @rab ret  _    
            _     `    @tld \    _    _    -    @pls @str =    _    _
            _     _    _              _         _    _    _
          )
           
          (deflayer nav 
            _     _    _    _    _    _    _    _    _    _    _    _    _    _
            _     f1   f2   f3   f4   _    _    pgdn pgup _    _    _    _    _
            tab   @f5  @f6  @f7  @f8  _    left @dwn @up  @rgt @ret  _    _
            _     f9   f10  f11  f12  _    bspc _    _    del  _    _ 
            _     _    _              _         _    _    _
          )

          (deflayer num 
            _     _    _    _    _    _    _    _    _    _    _    _    _    _
            _     _    _    _    _    _    =    7    8    9    @str _    _    _
            _     _    _    _    _    _    @pls @4   @5   @6   @0   ret  _
            _     _    _    _    _    _    -    1    2    3    /    _ 
            _     _    _              _         _    _    _
          )

           (defvar
             tap-time 180 
             hold-time 200
           )

           (defalias
             ;; KEYS
             no nop0

             ss (unicode ß)
             oe (unicode ö)
             ue (unicode ü)
             ae (unicode ä)
             Oe (unicode Ö)
             Ue (unicode Ü)
             Ae (unicode Ä)

             lb S-9 ;; ( 
             rb S-0 ;; ) 
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

             lds S-- ;; _ 
             pls S-= ;; + 

             qts S-' ;; " 
             ppe S-\ ;; | 
             tld S-` ;; ~ 

             ;; MODIFIER
             a (tap-hold $tap-time $hold-time a lmet)
             f5 (tap-hold $tap-time $hold-time f5 lmet)

             ; (tap-hold $tap-time $hold-time ; rmet)
             0 (tap-hold $tap-time $hold-time 0 rmet)
             ret (tap-hold $tap-time $hold-time ret rmet)

             s (tap-hold $tap-time $hold-time s lalt)
             f6 (tap-hold $tap-time $hold-time f6 lalt)

             l (tap-hold $tap-time $hold-time l ralt)
             6 (tap-hold $tap-time $hold-time 6 ralt)
             rgt (tap-hold $tap-time $hold-time rght ralt)

             d (tap-hold $tap-time $hold-time d lctl)
             f7 (tap-hold $tap-time $hold-time f7 lctl)

             k (tap-hold $tap-time $hold-time k rctl)
             5 (tap-hold $tap-time $hold-time 5 rctl)
             up (tap-hold $tap-time $hold-time up rctl)

             f (tap-hold $tap-time $hold-time f lsft)
             f8 (tap-hold $tap-time $hold-time f8 lsft)

             j (tap-hold $tap-time $hold-time j rsft)
             4 (tap-hold $tap-time $hold-time 4 rsft)
             dwn (tap-hold $tap-time $hold-time down rsft)

             ;; LAYER
             swtlyrumlauts (layer-while-held umlauts)
             swtlyrumlautscap (layer-while-held umlautscap)

             caps (tap-hold $tap-time $hold-time esc @swtlyrumlauts)
             lsft (tap-hold $tap-time $hold-time - @swtlyrumlautscap)

             swtlyrsym (layer-while-held sym)
             swtlyrnav (layer-while-held nav)
             swtlyrnum (layer-while-held num)

             v (tap-hold $tap-time $hold-time v @swtlyrsym)
             n (tap-hold $tap-time $hold-time n @swtlyrsym)

             c (tap-hold $tap-time $hold-time c @swtlyrnum)
             m (tap-hold $tap-time $hold-time m @swtlyrnum)
             
             x (tap-hold $tap-time $hold-time x @swtlyrnav)
             , (tap-hold $tap-time $hold-time , @swtlyrnav)

             stb (layer-switch base)
             stn (layer-switch nrml)
           )
        '';
      };
    };
  };

  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];

    NoNewPrivileges = true;
    PrivateTmp = true;
    ProtectSystem = "strict";
    ProtectHome = true;

    DeviceAllow = [
      "/dev/input/* rw"
      "/dev/uinput rw"
    ];
  };
}
