{ inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];
  stylix.targets.zen-browser.enable = false;
  programs.zen-browser.enable = true;

  programs.chromium.enable = true;
}
