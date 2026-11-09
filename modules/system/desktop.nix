{ pkgs, ... }:

{
  # Desktop environment
  services = {
    geoclue2.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome.gcr-ssh-agent.enable = false;
    pulseaudio.enable = false;
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    evolution
    evolution-data-server
    geary
    epiphany
    totem
  ];
}
