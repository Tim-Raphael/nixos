{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };

  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    tealdeer
    alacritty
  ];
}
