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

      keybind = [
        "ctrl+b>t=new_tab"
        "ctrl+b>n=next_tab"
        "ctrl+b>p=previous_tab"

        "ctrl+b>v=new_split:right"
        "ctrl+b>s=new_split:down"

        "ctrl+b>h=goto_split:left"
        "ctrl+b>j=goto_split:down"
        "ctrl+b>k=goto_split:up"
        "ctrl+b>l=goto_split:right"
      ];
    };
  };
}
