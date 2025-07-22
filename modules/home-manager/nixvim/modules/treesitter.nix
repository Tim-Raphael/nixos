{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      settings = {
        indent = {
          enable = false;
        };
        highlight = {
          enable = true;
        };
      };

      nixvimInjections = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    };

    treesitter-context = {
      enable = false;
    };

    treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
      };
    };
  };
}
