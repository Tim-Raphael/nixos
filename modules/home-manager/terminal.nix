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
      success_symbol = "[λ](bold green)";
      error_symbol = "[λ](bold red)";
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
    };
  };
}
