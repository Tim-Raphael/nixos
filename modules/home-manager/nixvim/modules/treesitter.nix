{ lib, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        folding = true;
        nixGrammars = true;
        nixvimInjections = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;

        settings = {
          indent.enable = false;
          highlight.enable = true;
          fold.enable = true; # add this
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

    opts = {
      foldenable = true; # disable autofolding
      foldlevel = 99;
      foldlevelstart = 99;
      #foldexpr = "nvim_treesitter#foldexpr()";
      foldmethod = "indent";
    };

    keymaps = lib.mkAfter [
      # Folding
      {
        mode = [
          "n"
          "v"
        ];
        key = "zz";
        action = "za";
        options = {
          desc = "Toggle Fold";
          noremap = true;
          silent = true;
        };
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "ZZ";
        action = "zR";
        options = {
          desc = "Unfold All";
          noremap = true;
          silent = true;
        };
      }
    ];
  };
}
