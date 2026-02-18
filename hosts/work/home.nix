{ ... }:

{
  home = {
    stateVersion = "25.05";
    username = "raphael";
    homeDirectory = "/home/raphael";
  };

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/sway.nix
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
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
      latex.enable = true;
      presentation.enable = true;
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

  password = {
    pass.enable = true;
    keepass.enable = true;
  };

  development = {
    tools = {
      postman.enable = true;
      dbBeaver.enable = true;
      opencode.enable = true;
    };

    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };

    languages = {
      rust = {
        enable = true;
        lld = true;
      };
      web.enable = true;
      markdown.enable = true;
    };

    databases = {
      postgresql.enable = true;
    };
  };
}
