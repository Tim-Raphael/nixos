{ ... }:

{
  imports = [
    ./theme.nix
    ./editor
    ./development.nix
    ./language.nix
    ./agent
    ./direnv.nix
    ./terminal.nix
    ./utils.nix
    ./browser.nix
    ./password.nix
    ./crypt.nix
    ./communication.nix
    ./multimedia.nix
  ];

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
    graphics.penpot.enable = true;
  };

  password = {
    pass.enable = true;
    keepass.enable = true;
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
}
