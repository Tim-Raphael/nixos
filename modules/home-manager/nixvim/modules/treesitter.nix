{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        nixGrammars = true;
        nixvimInjections = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;

        settings = {
          indent.enable = false;
          highlight.enable = true;
        };
      };

      treesitter-textobjects = {
        enable = true;

        select = {
          enable = true;
          lookahead = true;
        };
      };
    };
  };
}
