{
  ...
}:

{
  home = {
    stateVersion = "25.05";
    username = "raphael";
    homeDirectory = "/home/raphael";
  };

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development
    ../../modules/home-manager/scripts
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/kanshi.nix
    ../../modules/home-manager/i3status.nix
    ../../modules/home-manager/user-dirs.nix
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
        interface = "wlo1";
      };
    };
    power = {
      battery = {
        enable = true;
        path = "/sys/class/power_supply/BAT1/uevent";
      };
    };
  };

  multimedia = {
    office = {
      libreoffice.enable = true;
      pdf.enable = true;
      notes.enable = true;
      latex.enable = true;
      presentation.enable = true;
    };
    video = {
      vlc.enable = true;
    };
  };

  development = {
    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };
  };
}
