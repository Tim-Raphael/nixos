{ lib, ... }:

{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;

      settings = {
        indent = {
          char = "▏";
          smart_indent_cap = true;
        };

        scope = {
          show_end = false;
          show_exact_scope = true;
          show_start = false;
        };
      };

      luaConfig.post = ''
        -- idk if there is a better way to disable by default
        vim.api.nvim_create_autocmd("BufEnter", {
          once = true,
          callback = function()
            vim.cmd("IBLDisable")
          end,
        })
      '';
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "fi";
        action = "<CMD>IBLToggle<CR>";
        options = {
          desc = "Toggle Ident-Guides";
          noremap = true;
          silent = true;
        };
      }
    ];
  };
}
