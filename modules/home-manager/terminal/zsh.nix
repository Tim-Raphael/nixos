{ config, lib, ... }:

{
  programs.zsh = {
    enable = lib.mkDefault true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      if [[ ! -o interactive ]]; then
        emulate -R sh
      fi
    '';

    initContent = ''
      export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
      export GPG_TTY="$(tty)"

      bindkey -M emacs '^W' backward-kill-word
      bindkey -M viins '^W' backward-kill-word

      autoload -Uz add-zsh-hook vcs_info
      setopt PROMPT_PERCENT

      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:git:*' formats '%b'
      zstyle ':vcs_info:git:*' actionformats '%b|%a'

      function __update_prompt() {
        emulate -L zsh
        vcs_info
        local git_prompt=""
        if [[ -n "$vcs_info_msg_0_" ]]; then
          git_prompt=" %F{#${config.lib.stylix.colors.base04}}::%f %F{green}''${vcs_info_msg_0_//\%/%%}%f"
        fi
        PROMPT="%F{white}%~%f''${git_prompt} %F{#${config.lib.stylix.colors.base04}}λ%f "
      }

      add-zsh-hook precmd __update_prompt

      function __remember_pwd() {
        emulate -L zsh
        mkdir -p "$HOME/.cache"
        print -r -- "$PWD" > "$HOME/.cache/zsh_last_pwd"
      }

      if [[ -r "$HOME/.cache/zsh_last_pwd" ]]; then
        last_pwd="$(cat "$HOME/.cache/zsh_last_pwd")"
        if [[ -d "$last_pwd" && -x "$last_pwd" ]]; then
          cd -- "$last_pwd"
        fi
        unset last_pwd
      fi

      add-zsh-hook chpwd __remember_pwd
    '';
  };
}
