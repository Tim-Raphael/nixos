{
  config,
  pkgs,
  ...
}:

let
  colors = config.lib.stylix.colors;
in
{
  home.packages = with pkgs; [
    tealdeer
  ];

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";

    envExtra = ''
      if [[ ! -o interactive ]]; then
        emulate sh
      fi
    '';

    initContent = ''
      autoload -Uz vcs_info add-zsh-hook
      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:git:*' formats '%b'
      zstyle ':vcs_info:git:*' actionformats '%b|%a'

      update_prompt() {
        vcs_info
        PROMPT='%~'
        if [[ -n "$vcs_info_msg_0_" ]]; then
          PROMPT+="%F{#${colors.base04}} :: %F{#${colors.base0B}}''${vcs_info_msg_0_//\%/%%}"
        fi
        PROMPT+='%f λ '
      }
      add-zsh-hook precmd update_prompt
    '';
  };

  programs.alacritty = {
    enable = true;
    settings.terminal.shell.program = "${pkgs.zsh}/bin/zsh";
  };
}
