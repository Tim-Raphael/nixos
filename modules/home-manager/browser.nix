{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  programs.qutebrowser = {
    enable = true;

    extraConfig = ''
      c.hints.padding = {"top": 1, "bottom": 1, "left": 1, "right": 1}
      c.qt.force_software_rendering = "chromium"
    '';

    keyBindings = {
      normal = {
        "<Space>g" = "cmd-set-text -s :open";
        "<Space>f" = "cmd-set-text -s :tab-select";
        "<Space>p" = "cmd-set-text -s :quickmark-load";

        "<Ctrl-Shift-l>" = "tab-next";
        "<Ctrl-Shift-h>" = "tab-prev";

        "J" = "scroll-px 0 750";
        "K" = "scroll-px 0 -750";

        "td" = "config-cycle colors.webpage.darkmode.enabled false true";
      };
    };

    settings = {
      fonts = {
        default_family = "${config.fonts.systemFont.main.name}";
        default_size = "${toString config.fonts.systemFont.main.size-medium}pt";

        completion = {
          entry = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
          category = "bold ${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        };

        debug_console = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        downloads = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        hints = "bold ${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        keyhint = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        messages = {
          error = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
          info = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
          warning = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        };
        prompts = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        statusbar = "${toString config.fonts.systemFont.main.size-small}pt ${config.fonts.systemFont.main.name}";
        tabs = {
          selected = "${toString config.fonts.systemFont.main.size-medium}pt ${config.fonts.systemFont.main.name}";
          unselected = "${toString config.fonts.systemFont.main.size-medium}pt ${config.fonts.systemFont.main.name}";
        };
        web = {
          family = {
            standard = "${config.fonts.systemFont.main.name}";
            serif = "${config.fonts.systemFont.main.name}";
            sans_serif = "${config.fonts.systemFont.main.name}";
            cursive = "${config.fonts.systemFont.main.name}";
            fantasy = "${config.fonts.systemFont.main.name}";
            fixed = "${config.fonts.systemFont.main.name}";
          };
          size = {
            default = config.fonts.systemFont.main.size-medium;
            default_fixed = config.fonts.systemFont.main.size-medium;
            minimum = 10;
            minimum_logical = 8;
          };
        };
      };

      colors = {
        completion = {
          fg = "#${config.colorScheme.palette.base05}";
          odd.bg = "#${config.colorScheme.palette.base01}";
          even.bg = "#${config.colorScheme.palette.base00}";
          category = {
            fg = "#${config.colorScheme.palette.base0A}";
            bg = "#${config.colorScheme.palette.base00}";
            border = {
              top = "#${config.colorScheme.palette.base00}";
              bottom = "#${config.colorScheme.palette.base00}";
            };
          };
          item.selected = {
            fg = "#${config.colorScheme.palette.base01}";
            bg = "#${config.colorScheme.palette.base0A}";
            border = {
              top = "#${config.colorScheme.palette.base0A}";
              bottom = "#${config.colorScheme.palette.base0A}";
            };
            match.fg = "#${config.colorScheme.palette.base00}";
          };
          match.fg = "#${config.colorScheme.palette.base09}";
          scrollbar = {
            fg = "#${config.colorScheme.palette.base05}";
            bg = "#${config.colorScheme.palette.base00}";
          };
        };

        contextmenu = {
          disabled = {
            bg = "#${config.colorScheme.palette.base01}";
            fg = "#${config.colorScheme.palette.base04}";
          };
          menu = {
            bg = "#${config.colorScheme.palette.base00}";
            fg = "#${config.colorScheme.palette.base05}";
          };
          selected = {
            bg = "#${config.colorScheme.palette.base02}";
            fg = "#${config.colorScheme.palette.base05}";
          };
        };

        downloads = {
          bar.bg = "#${config.colorScheme.palette.base00}";
          start = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0D}";
          };
          stop = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0C}";
          };
          error.fg = "#${config.colorScheme.palette.base08}";
        };

        hints = {
          fg = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base0A}";
          match.fg = "#${config.colorScheme.palette.base05}";
        };

        keyhint = {
          fg = "#${config.colorScheme.palette.base05}";
          suffix.fg = "#${config.colorScheme.palette.base05}";
          bg = "#${config.colorScheme.palette.base00}";
        };

        messages = {
          error = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base08}";
            border = "#${config.colorScheme.palette.base08}";
          };
          warning = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0E}";
            border = "#${config.colorScheme.palette.base0E}";
          };
          info = {
            fg = "#${config.colorScheme.palette.base05}";
            bg = "#${config.colorScheme.palette.base00}";
            border = "#${config.colorScheme.palette.base00}";
          };
        };

        prompts = {
          fg = "#${config.colorScheme.palette.base05}";
          border = "#${config.colorScheme.palette.base00}";
          bg = "#${config.colorScheme.palette.base00}";
          selected = {
            bg = "#${config.colorScheme.palette.base02}";
            fg = "#${config.colorScheme.palette.base05}";
          };
        };

        statusbar = {
          normal = {
            fg = "#${config.colorScheme.palette.base0B}";
            bg = "#${config.colorScheme.palette.base00}";
          };
          insert = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0B}";
          };
          passthrough = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0C}";
          };
          private = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base01}";
          };
          command = {
            fg = "#${config.colorScheme.palette.base05}";
            bg = "#${config.colorScheme.palette.base00}";
            private = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base00}";
            };
          };
          caret = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0E}";
            selection = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base0D}";
            };
          };
          progress.bg = "#${config.colorScheme.palette.base0D}";
          url = {
            fg = "#${config.colorScheme.palette.base05}";
            error.fg = "#${config.colorScheme.palette.base08}";
            hover.fg = "#${config.colorScheme.palette.base05}";
            success.http.fg = "#${config.colorScheme.palette.base0C}";
            success.https.fg = "#${config.colorScheme.palette.base0B}";
            warn.fg = "#${config.colorScheme.palette.base0E}";
          };
        };

        tabs = {
          bar.bg = "#${config.colorScheme.palette.base00}";
          indicator = {
            start = "#${config.colorScheme.palette.base0B}";
            stop = "#${config.colorScheme.palette.base0B}";
            error = "#${config.colorScheme.palette.base08}";
          };
          odd = {
            fg = "#${config.colorScheme.palette.base07}";
            bg = "#${config.colorScheme.palette.base00}";
          };
          even = {
            fg = "#${config.colorScheme.palette.base07}";
            bg = "#${config.colorScheme.palette.base00}";
          };
          pinned = {
            even = {
              bg = "#${config.colorScheme.palette.base0C}";
              fg = "#${config.colorScheme.palette.base07}";
            };
            odd = {
              bg = "#${config.colorScheme.palette.base07}";
              fg = "#${config.colorScheme.palette.base00}";
            };
            selected = {
              even = {
                bg = "#${config.colorScheme.palette.base0B}";
                fg = "#${config.colorScheme.palette.base00}";
              };
              odd = {
                bg = "#${config.colorScheme.palette.base0B}";
                fg = "#${config.colorScheme.palette.base00}";
              };
            };
          };
          selected = {
            odd = {
              bg = "#${config.colorScheme.palette.base03}";
              fg = "#${config.colorScheme.palette.base07}";
            };
            even = {
              bg = "#${config.colorScheme.palette.base03}";
              fg = "#${config.colorScheme.palette.base07}";
            };
          };
        };

        webpage = {
          bg = "#${config.colorScheme.palette.base00}";
          darkmode.enabled = true;
          darkmode = {
            algorithm = "lightness-cielab";
            threshold = {
              foreground = 150;
              background = 100;
            };
            policy = {
              page = "smart";
              images = "never";
            };
          };
          preferred_color_scheme = "dark";
        };
      };

      tabs.background = true;
      tabs.show = "multiple";
      tabs.position = "top";
      statusbar.show = "always";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/x-extension-htm" = "org.qutebrowser.qutebrowser.desktop";
      "application/x-extension-html" = "org.qutebrowser.qutebrowser.desktop";
      "application/x-extension-shtml" = "org.qutebrowser.qutebrowser.desktop";
      "application/x-extension-xht" = "org.qutebrowser.qutebrowser.desktop";
      "application/x-extension-xhtml" = "org.qutebrowser.qutebrowser.desktop";
      "application/xhtml+xml" = "org.qutebrowser.qutebrowser.desktop";
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/chrome" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
    };
  };

  programs.chromium = {
    enable = true;

    dictionaries = with pkgs; [
      hunspellDictsChromium.en_US
      hunspellDictsChromium.de_DE
    ];

    extensions = [
      # Darkreader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }

      # Ublock Origin Lite
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }

      # React Developer Tools
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; }

      # LanguageTool
      { id = "oldceeleldhonbafppcapldpdifcinji"; }
    ];
  };
}
