{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwgen
    keepassxc
    pass
    gnupg
    pinentry-tty
    git
  ];
}
