{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    killall
    tmate
    sshfs
    tree
    tealdeer
    mosh
    nix-search
  ];

  programs.alacritty = {
    enable = true;
    settings.terminal.shell.program = "${pkgs.zsh}/bin/zsh";
  };
}
