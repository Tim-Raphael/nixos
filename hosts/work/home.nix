{
  lib,
  config,
  pkgs,
  ...
}:

{
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "25.05";

  # home.packages = [ ];

  # home.sessionVariables = { };

  # home.file = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/scripts.nix
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/kanshi.nix
    ../../modules/home-manager/i3status.nix
  ];

  i3status = {
    enable = true;
    system = {
      cpu = {
        usage.enable = true;
        temperature.enable = true;
      };
      disk = {
        root.enable = true;
      };
    };
    time = {
      date.enable = true;
      clock.enable = true;
    };
    audio = {
      volume.enable = true;
    };
    network = {
      wireless = {
        enable = true;
        interface = "wlp2s0";
      };
      ethernet = {
        enable = true;
        interface = "enp1s0f0";
      };
    };
    power = {
      battery.enable = true;
    };
  };

  multimedia = {
    office = {
      libreoffice.enable = true;
      pdf.enable = true;
      notes.enable = true;
    };
    video = {
      vlc.enable = true;
      obs.enable = true;
    };
    audio = {
      effects.enable = true;
    };
    graphics = {
      penpot.enable = true;
    };
  };
}
