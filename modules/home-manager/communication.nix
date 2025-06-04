{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    thunderbird
    element-desktop
  ];
}
