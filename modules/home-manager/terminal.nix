{
  config,
  pkgs,
  inputs,
  ...
}:

let
  systemFont = config.fonts.systemFont.main;
  colorScheme = config.colorScheme.palette;
  nixColorsLib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    killall
    tmate
    sshfs
    tree
    tealdeer
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "${systemFont.name}";
        size = systemFont.size-medium;
      };
      colors = {
        primary = {
          background = "#${colorScheme.base00}";
          foreground = "#${colorScheme.base05}";
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set PATH $HOME/.local/bin $PATH # for some util scripts
      set -gx GPG_TTY (tty)
      sh ${
        nixColorsLib.shellThemeFromScheme {
          scheme = config.colorScheme;
        }
      }
    '';
  };
}
