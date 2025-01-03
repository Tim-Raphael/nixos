{ pkgs, ... }:

{
  home.packages = with pkgs; [ pass neofetch sshfs ranger tree tealdeer ];

  xdg.configFile."fish/config.fish".text = ''
    if status is-interactive
        set fish_greeting
        set PATH $HOME/.local/bin $PATH # for some util scripts

        ${pkgs.neofetch}/bin/neofetch
    end    
  '';
}
