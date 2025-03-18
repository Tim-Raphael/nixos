{ pkgs, ... }:

{
  home.packages = with pkgs; [ pwgen keepassxc ];
}
