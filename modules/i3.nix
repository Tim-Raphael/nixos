{ config, pkgs, ... }:

{
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3status
      i3lock
      i3blocks
      networkmanagerapplet
      lxappearance
      dmenu
      dunst
    ];
  };
}

