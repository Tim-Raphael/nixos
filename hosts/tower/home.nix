{
  user,
  userDir,
  ...
}:

{
  home = {
    stateVersion = "25.11";
    username = user;
    homeDirectory = userDir;
  };

  imports = [
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/editor
    ../../modules/home-manager/desktop
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/agents
    ../../modules/home-manager/direnv.nix
    ../../modules/home-manager/scripts
    ../../modules/home-manager/utils.nix
    ../../modules/home-manager/browser.nix
    ../../modules/home-manager/communication.nix
    ../../modules/home-manager/multimedia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/password.nix
    ../../modules/home-manager/crypt.nix
    ../../modules/home-manager/kanshi.nix
    ../../modules/home-manager/user-dirs.nix
  ];

  i3status = {
    enable = true;

    system = {
      cpu = {
        usage.enable = true;
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
      raster.enable = true;
    };
  };

  password = {
    pass.enable = true;
  };

  editor = {
    zed.enable = true;
    vscode.enable = true;
  };

  development = {
    direnv.enable = true;

    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };
  };

  agents = {
    claude.enable = true;
    codex.enable = true;
    copilot.enable = true;
  };
}
