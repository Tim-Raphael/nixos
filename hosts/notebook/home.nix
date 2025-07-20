{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "25.05";

  home.packages = [ ];

  home.sessionVariables = { };

  home.file = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/scripts.nix
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/kanshi.nix

    (import ../../modules/home-manager/i3status.nix {
      inherit pkgs lib config;
      extraModuleList = [
        {
          "battery 0" = {
            position = 7;
            settings = {
              format = "BAT: %percentage %remaining";
              format_down = "";
              last_full_capacity = true;
              integer_battery_capacity = true;
              low_threshold = 20;
              threshold_type = "percentage";
              hide_seconds = true;
              path = "/sys/class/power_supply/BAT1/uevent";
            };
          };
        }
        {
          "wireless wlo1" = {
            position = 8;
            settings = {
              format_up = "WLS:%quality at %essid, %ip";
              format_down = "";
            };
          };
        }
      ];
    })
  ];

  programs.home-manager.enable = true;
}
