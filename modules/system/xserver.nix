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

    # Enable i3 window manager
    windowManager.i3.enable = true;

    # X11 keyboard layout
    xkb = {
      layout = "de";
      variant = "";
    };
  };
}
