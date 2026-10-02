{ inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];
  stylix.targets.zen-browser.enable = false;
  programs.zen-browser.enable = true;

  # Set zen as default browser
  home.sessionVariables.BROWSER = "zen-beta";
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "zen-beta.desktop" ];
      "application/xhtml+xml" = [ "zen-beta.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
    };
  };

  programs.chromium.enable = true;
}
