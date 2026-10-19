{ ... }:

{
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
      git-conflict.enable = true;
    };
  };
}
