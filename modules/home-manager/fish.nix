{ pkgs, ... }:

{
  home.packages = with pkgs; [ neofetch ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      neofetch
    '';
  };
}
