{ config, pkgs, ... }:

{
  # access keyboard configuration
  hardware.keyboard.qmk.enable = true;

  # Console keymap
  console = {
    enable = true;
    useXkbConfig = true;
    earlySetup = true;
  };

  environment.systemPackages = with pkgs; [ kanata ];

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
