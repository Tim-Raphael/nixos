{ inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];
  programs.zen-browser.enable = true;

  programs.chromium.enable = true;
}
