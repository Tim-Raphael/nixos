{ pkgs, ... }:

{
  programs.claude-code = {
    enable = true;
    package = pkgs.unstable.claude-code;
    context = ./context.md;
  };

  programs.codex = {
    enable = true;
    package = pkgs.unstable.codex;
    context = ./context.md;
  };
}
