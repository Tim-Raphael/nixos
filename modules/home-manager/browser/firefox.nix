{ pkgs, ... }:

{
  stylix.targets.firefox.profileNames = [ "main" ];

  programs.firefox = {
    enable = true;
    profiles.main = {
      search = {
        default = "ddg";
        force = true;
      };
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
        ];
      };
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        #tabbrowser-tabs {
          &[orient="horizontal"] {
           --tab-max-width: none !important;
          }
          .tab-label-container {
            height: unset !important;
          }
        }
      '';
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
