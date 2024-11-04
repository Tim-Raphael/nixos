{ pkgs, ... }:

{
  home.packages = with pkgs; [ neofetch sshfs ranger tree ];

  programs.alacritty = { enable = true; };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      neofetch
    '';
  };
}
