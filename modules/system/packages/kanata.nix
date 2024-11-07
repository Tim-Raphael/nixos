{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ kanata ];

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/pci-0000:04:00.3-usb-0:1.1:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:04:00.3-usb-0:1.1:1.2-event-kbd"
          "/dev/input/by-path/pci-0000:04:00.3-usb-0:1.2.1:1.1-event-kbd"
          "/dev/input/by-path/pci-0000:04:00.3-usbv2-0:1.1:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:04:00.3-usbv2-0:1.1:1.2-event-kbd"
          "/dev/input/by-path/pci-0000:04:00.3-usbv2-0:1.2.1:1.1-event-kbd"
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps 
          )
          (defvar
           tap-time 200 
           hold-time 250
          )
          (defalias
           caps (tap-hold $tap-time $hold-time esc ralt)
          )
          (deflayer base
           @caps 
          )
        '';
      };
    };
  };
}
