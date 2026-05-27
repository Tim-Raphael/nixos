{
  pkgs,
  config,
  lib,
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
    pay-respects
    nix-search
  ];

  programs.alacritty.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set PATH $HOME/.local/bin $PATH # for some util scripts
      set -gx GPG_TTY (tty)

      # Use vim key-bindings
      function fish_user_key_bindings
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
      end

      # Init pay-respects
      pay-respects fish | source
    '';
  };
}
