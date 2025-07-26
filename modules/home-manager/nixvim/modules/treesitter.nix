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
      foldenable = false; # disable autofolding
      foldexpr = "nvim_treesitter#foldexpr()";
      foldmethod = "expr";
    };

    keymaps = lib.mkAfter [
      # Folding
      {
        mode = [
          "n"
          "v"
        ];
        key = "<C-k>";
        action = "zc";
        options = {
          desc = "Fold";
          noremap = true;
          silent = true;
        };
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "<C-j>";
        action = "zo";
        options = {
          desc = "Unfold";
          noremap = true;
          silent = true;
        };
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "<C-J>";
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
