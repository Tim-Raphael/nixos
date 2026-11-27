{ inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.chromium.enable = true;
  programs.zen-browser.enable = true;
  # Set zen as default browser
  home.sessionVariables.BROWSER = "zen-beta";
}
