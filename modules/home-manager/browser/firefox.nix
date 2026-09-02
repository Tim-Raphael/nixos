{ pkgs, ... }:

{
  # Firefox keeps its own chrome styling; only the reader mode and font
  # overrides from stylix would apply here and they clash with the defaults.
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
    # Vertical tabs and the sidebar revamp land in the release channel later
    # than upstream ships them, so track unstable.
    package = pkgs.unstable.firefox;
    configPath = ".mozilla/firefox";
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
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "always-show";
      };
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
