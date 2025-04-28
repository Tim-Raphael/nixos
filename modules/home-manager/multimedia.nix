{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pdfarranger
    gimp
    darktable
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
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    obs-studio
    pdfarranger
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
}
