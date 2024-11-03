{ pkgs, ... }:

{
  home.packages = with pkgs; [ networkmanagerapplet lxappearance ];

  home.file = {
    ".config/i3" = { source = ./i3; };
    ".config/i3status" = { source = ./i3status; };
  };
}
