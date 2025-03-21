{ pkgs, ... }:

{
  home.packages = with pkgs; [
    networkmanagerapplet
    lxappearance
  ];

  home.file = {
    ".config/sway" = {
      source = ./i3;
    };
  };
}
