{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    killall
    tmate
    sshfs
    tree
    tealdeer
    mosh
    nix-search
  ];

  programs.alacritty.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set PATH $HOME/.local/bin $PATH # For some util scripts
      set PATH $HOME/.cargo/bin $PATH
      set -gx GPG_TTY (tty)

      # Use vim key-bindings
      function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
      end

      # Remember last directory
      function __remember_pwd --on-variable PWD
          echo $PWD > ~/.cache/fish_last_pwd
      end

      # Load last directory on startup
      if status is-interactive
          set -l last_pwd ~/.cache/fish_last_pwd
          if test -f $last_pwd
              cd (cat $last_pwd)
          end
      end
    '';
  };
}
