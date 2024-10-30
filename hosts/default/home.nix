{ config, pkgs, ... }: {
  home.username = "raphael";
  home.homeDirectory = "/home/raphael";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [ ];

  home.sessionVariables = { };

  home.file = {
    ".config/i3/config" = { source = ../../config/i3/config; };
    ".config/i3status/config" = { source = ../../config/i3status/config; };
    ".config/fish/config.fish" = { source = ../../config/fish/config.fish; };
  };

  imports = [ ../../modules/home-manager/nvim.nix ];

  programs.home-manager.enable = true;
}
