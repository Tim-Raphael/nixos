{
  user,
  userDir,
  ...
}:

{
  home = {
    stateVersion = "25.05";
    username = user;
    homeDirectory = userDir;
  };

  imports = [
    ../../modules/home/theme.nix
    ../../modules/home/editor
    ../../modules/home/desktop
    ../../modules/home/terminal.nix
    ../../modules/home/development.nix
    ../../modules/home/direnv.nix
    ../../modules/home/utils.nix
    ../../modules/home/browser.nix
    ../../modules/home/communication.nix
    ../../modules/home/multimedia.nix
    ../../modules/home/gaming.nix
    ../../modules/home/password.nix
    ../../modules/home/crypt.nix
    ../../modules/home/kanshi.nix
    ../../modules/home/user-dirs.nix
  ];

  i3status = {
    enable = true;
    system = {
      memory.enable = true;
      cpu = {
        usage.enable = true;
      };
      disk = {
        root.enable = true;
      };
    };
    time = {
      date.enable = true;
      clock.enable = true;
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
    direnv.enable = true;

    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };
  };

  password = {
    pass.enable = true;
  };
}
