{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.multimedia;
in
{
  options.multimedia = {
    graphics = {
      enable = mkEnableOption "graphics and design tools";

      kicad.enable = mkEnableOption "KiCad EDA suite";
      penpot.enable = mkEnableOption "Penpot design tool";
      raster.enable = mkEnableOption "raster graphics tools (GIMP, Darktable)";
      vector.enable = mkEnableOption "vector graphics tools (Inkscape, Scribus)";
      pixelArt.enable = mkEnableOption "pixel art tools (Aseprite)";
      diagrams.enable = mkEnableOption "graph tools (mermaid cli)";
    };

    office = {
      enable = mkEnableOption "office and document tools";

      libreoffice.enable = mkEnableOption "LibreOffice suite";
      latex.enable = mkEnableOption "LaTeX distribution and tools";
      notes.enable = mkEnableOption "note-taking tools (Obsidian)";
      pdf.enable = mkEnableOption "PDF manipulation tools";
      pandoc.enable = mkEnableOption "Pandoc document converter";
      presentation.enable = mkEnableOption "Presenterm";
    };

    video = {
      enable = mkEnableOption "video tools";

      vlc.enable = mkEnableOption "video players (VLC)";
      shotcut.enable = mkEnableOption "video editing tools (Shotcut)";
      obs.enable = mkEnableOption "recording tools (OBS Studio)";
    };

    audio = {
      enable = mkEnableOption "audio tools";

      effects.enable = mkEnableOption "audio effects processing (EasyEffects)";
    };

    hardware = {
      enable = mkEnableOption "multimedia hardware support";

      tablet.enable = mkEnableOption "graphics tablet support (OpenTabletDriver)";
    };
  };

  config = mkMerge [
    # Graphic tools
    (mkIf cfg.graphics.kicad.enable {
      home.packages = with pkgs; [ kicad ];
    })

    (mkIf cfg.graphics.penpot.enable {
      home.packages = with pkgs; [ penpot-desktop ];
    })

    (mkIf cfg.graphics.raster.enable {
      home.packages = with pkgs; [
        gimp
        darktable
      ];
    })

    (mkIf cfg.graphics.vector.enable {
      home.packages = with pkgs; [
        inkscape
        scribus
      ];
    })

    (mkIf cfg.graphics.pixelArt.enable {
      home.packages = with pkgs; [ aseprite ];
    })

    # Office tools
    (mkIf cfg.office.libreoffice.enable {
      home.packages = with pkgs; [
        libreoffice-qt
      ];
    })

    (mkIf cfg.office.latex.enable {
      home.packages = with pkgs; [
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
    })

    (mkIf cfg.office.notes.enable {
      home.packages = with pkgs; [ obsidian ];
    })

    (mkIf cfg.office.pdf.enable {
      home.packages = with pkgs; [ pdfarranger ];
    })

    (mkIf cfg.office.pandoc.enable {
      home.packages = with pkgs; [ pandoc ];
    })

    (mkIf cfg.office.presentation.enable {
      home.packages = with pkgs; [
        presenterm
        mermaid-cli
        ghostty
      ];
      home.file.".config/presenterm/config.yaml".text = ''
        options:
          end_slide_shorthand: true
          strict_front_matter_parsing: false
      '';
    })

    # Video tools
    (mkIf cfg.video.vlc.enable {
      home.packages = with pkgs; [ vlc ];
    })

    (mkIf cfg.video.shotcut.enable {
      home.packages = with pkgs; [ shotcut ];
    })

    (mkIf cfg.video.obs.enable {
      home.packages = with pkgs; [ obs-studio ];
    })

    # Audio tools
    (mkIf cfg.audio.effects.enable {
      home.packages = with pkgs; [ easyeffects ];
    })

    # Hardware support
    (mkIf cfg.hardware.tablet.enable {
      home.packages = with pkgs; [ opentabletdriver ];

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
    })
  ];
}
