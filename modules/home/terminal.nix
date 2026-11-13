{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    tealdeer
  ];

  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    envExtra = ''
      if [[ ! -o interactive ]]; then
        emulate sh
      fi
    '';

    initContent = ''
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^H' backward-kill-word
      bindkey '^[[127;5u' backward-kill-word
    '';
  };

  programs.starship = {
    enable = true;

    enableZshIntegration = true;
    presets = [ "pure-preset" ];

    settings.character = {
      error_symbol = "[λ](bold red)";
      success_symbol = "[λ](bold green)";
      vimcmd_symbol = "[λ](bold green)";
    };
  };

  stylix.targets.ghostty.enable = true;
  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      command = "${pkgs.zsh}/bin/zsh";
      cursor-style = "block";
      cursor-style-blink = false;
      shell-integration = "zsh";
      shell-integration-features = "no-cursor,ssh-env,ssh-terminfo";

      # tmux key-bindings
      keybind = [
        "ctrl+b>c=new_tab"
        "ctrl+b>n=next_tab"
        "ctrl+b>p=previous_tab"
        "ctrl+b>%=new_split:right"
        "ctrl+b>\"=new_split:down"
        "ctrl+b>o=goto_split:next"
        "ctrl+b>arrow_left=goto_split:left"
        "ctrl+b>arrow_down=goto_split:down"
        "ctrl+b>arrow_up=goto_split:up"
        "ctrl+b>arrow_right=goto_split:right"
        "ctrl+b>z=toggle_split_zoom"
        "ctrl+b>x=close_surface"
        "ctrl+b>ctrl+b=text:\\x02"
      ];
    };
  };
}
