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
    ../../modules/home/theme.nix
    ../../modules/home/editor
    ../../modules/home/development.nix
    ../../modules/home/agents
    ../../modules/home/direnv.nix
    ../../modules/home/desktop
    ../../modules/home/terminal.nix
    ../../modules/home/utils.nix
    ../../modules/home/browser.nix
    ../../modules/home/password.nix
    ../../modules/home/crypt.nix
    ../../modules/home/communication.nix
    ../../modules/home/multimedia.nix
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
      noise.enable = true;
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

  editor = {
    vscode.enable = false;
  };

  development = {
    tools = {
      postman.enable = true;
      dbBeaver.enable = true;
    };

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
