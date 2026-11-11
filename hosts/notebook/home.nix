{ user, userDir, ... }:

{
  home = {
    stateVersion = "25.05";
    username = user;
    homeDirectory = userDir;
  };

  imports = [ ../../modules/home/default.nix ];

  i3status.power.battery.path = "/sys/class/power_supply/BAT1/uevent";
}
