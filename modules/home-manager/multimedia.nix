{ pkgs, ... }:

{
  home.packages = with pkgs; [
    easyeffects
    pdfarranger
    gimp
    unstable.darktable
    inkscape
    scribus
    shotcut
    imagemagick
    ffmpeg_7
    pandoc
    obsidian
    vlc
    opentabletdriver
    libreoffice-qt
    languagetool
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    obs-studio
    (texlive.combine {
      inherit (texlive)
        apa
        biblatex
        biblatex-apa
        csquotes
        glossaries
        fontaxes
        hyphenat
        latexindent
        latexmk
        lipsum
        listing
        plex
        scheme-full
        textpos
        ;
    })
    setzer
  ];

  systemd.user.services.opentabletdriver = {
    Unit = {
      Description = "OpenTabletDriver Daemon";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.opentabletdriver}/bin/otd-daemon";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.languagetool-http-server = {
    Unit = {
      Description = "Languagetool HTTP Server";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.languagetool}/bin/languagetool-http-server --port 1470";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
