{
  ...
}:

{
  home = {
    stateVersion = "25.11";
    username = "raphael";
    homeDirectory = "/home/raphael";
  };

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/direnv.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser
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
        temperature = {
          enable = true;
          path = "/sys/class/hwmon/hwmon1/temp1_input";
        };
      };
      disk = {
        root.enable = true;
      };
      memory.enable = true;
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
        interface = "wlp12s0";
      };
      ethernet = {
        enable = true;
        interface = "eno1";
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
      obs.enable = true;
    };

    audio = {
      effects.enable = true;
      noise.enable = true;
    };

    graphics = {
      kicad.enable = false;
    };
  };

  password = {
    pass.enable = true;
  };

  development = {
    tools = {
      claudeCode.enable = true;
      copilot.enable = true;
    };

    direnv.enable = true;

    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };
  };
}
