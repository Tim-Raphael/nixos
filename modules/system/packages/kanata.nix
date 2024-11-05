{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ kanata ];

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps a s d f j k l ;
          )
          (defvar
           tap-time 300 
           hold-time 250
          )
          (defalias
           caps (tap-hold $tap-time $hold-time esc esc)
           a (tap-hold $tap-time $hold-time a lmet)
           s (tap-hold $tap-time $hold-time s ralt)
           d (tap-hold $tap-time $hold-time d lsft)
           f (tap-hold $tap-time $hold-time f lctl)
           j (tap-hold $tap-time $hold-time j rctl)
           k (tap-hold $tap-time $hold-time k rsft)
           l (tap-hold $tap-time $hold-time l lalt)
           ; (tap-hold $tap-time $hold-time ; rmet)
          )

          (deflayer base
           @caps @a  @s  @d  @f  @j  @k  @l  @;
          )
        '';
      };
    };
  };
}
