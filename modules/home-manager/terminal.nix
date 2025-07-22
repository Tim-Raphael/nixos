{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tmate
    tig
    git
    gh
    sshfs
    tree
    tealdeer
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "${config.fonts.systemFont.main.name}";
        size = config.fonts.systemFont.main.size-medium;
      };

      colors = {
        primary = {
          background = "#${config.colorScheme.palette.base00}";
          foreground = "#${config.colorScheme.palette.base05}";
        };

        normal = {
          black = "#${config.colorScheme.palette.base00}";
          red = "#${config.colorScheme.palette.base08}";
          green = "#${config.colorScheme.palette.base0B}";
          yellow = "#${config.colorScheme.palette.base0A}";
          blue = "#${config.colorScheme.palette.base0D}";
          magenta = "#${config.colorScheme.palette.base0E}";
          cyan = "#${config.colorScheme.palette.base0C}";
          white = "#${config.colorScheme.palette.base05}";
        };

        bright = {
          black = "#${config.colorScheme.palette.base03}";
          red = "#${config.colorScheme.palette.base08}";
          green = "#${config.colorScheme.palette.base0B}";
          yellow = "#${config.colorScheme.palette.base0A}";
          blue = "#${config.colorScheme.palette.base0D}";
          magenta = "#${config.colorScheme.palette.base0E}";
          cyan = "#${config.colorScheme.palette.base0C}";
          white = "#${config.colorScheme.palette.base07}";
        };
      };
    };
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      if status is-interactive
          set fish_greeting
          set PATH $HOME/.local/bin $PATH # for some util scripts
          set -gx GPG_TTY (tty)
      end
    '';
  };
}
