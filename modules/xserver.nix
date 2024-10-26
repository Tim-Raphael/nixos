{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;

    # Manage GNOME desktop manager
    desktopManager = {
      xterm.enable = false;
      gnome.enable = true;
    };

    # GDM display manager
    displayManager = { gdm.enable = true; };
    windowManager.i3 = {
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

    # X11 keyboard layout
    xkb = {
      layout = "de";
      variant = "";
    };
  };
}
