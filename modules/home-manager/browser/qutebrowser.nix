{ ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig = ''
      c.hints.padding = {"top": 1, "bottom": 1, "left": 1, "right": 1}
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
      webpage = {
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

      tabs.background = true;
      tabs.show = "multiple";
      tabs.position = "top";
      statusbar.show = "always";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };
}
