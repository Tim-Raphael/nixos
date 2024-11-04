{ pkgs, ... }:

{
  home.packages = with pkgs; [ neofetch sshfs ranger tree ];

  home.file = {
    ".config/fish/config.fish" = { source = ./fish/config.fish; };
  };
}
