{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tmate
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

    functions = {
      # Function to sync terminal directory with nvim
      nv = ''
        # Run nvim with arguments
        nvim $argv

        # Check if nvim wrote its final directory
        set nvim_dir_file "$HOME/.nvim_last_dir"
        if test -f $nvim_dir_file
            set nvim_dir (cat $nvim_dir_file)
            if test -d $nvim_dir
                cd $nvim_dir
                echo "Changed to: $nvim_dir"
            end
            rm $nvim_dir_file 2>/dev/null
        end
      '';
    };
  };
}
