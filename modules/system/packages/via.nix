{ pkgs, ... }:

{
  #VIA is a feature in QMK that lets you change your keymap on your keyboard without needing to reflash firmware. Your keyboard must support VIA in order for it to work.

  environment.systemPackages = with pkgs; [ via ];

  services.udev.packages = with pkgs; [ via ];
}
