{ pkgs, ... }:

{
  home.packages = with pkgs; [ tmate git neofetch sshfs ranger tree tealdeer ];

  xdg.configFile."fish/config.fish".text = ''
    if status is-interactive
        set fish_greeting
        set PATH $HOME/.local/bin $PATH # for some util scripts
        set -gx GPG_TTY (tty)
        ${pkgs.neofetch}/bin/neofetch
    end
  '';

}
