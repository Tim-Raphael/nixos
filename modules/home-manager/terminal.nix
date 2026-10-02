{
  config,
  lib,
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

  programs.fish = {
    enable = true;

    interactiveShellInit = lib.mkAfter ''
      set -g fish_greeting
    '';

    functions.fish_prompt = ''
      set_color normal
      printf '%s' (prompt_pwd --dir-length=0)
      set -l git_prompt (fish_git_prompt '%s')
      if test -n "$git_prompt"
        set_color ${colors.base04}
        printf ' :: '
        set_color ${colors.base0B}
        printf '%s' "$git_prompt"
      end
      set_color normal
      printf ' λ '
      set_color normal
    '';
  };

  programs.alacritty = {
    enable = true;
    settings.terminal.shell.program = "${pkgs.fish}/bin/fish";
  };
}
