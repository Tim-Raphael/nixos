{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      fugitive.enable = true;
      gitsigns.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<A-g>";
        action = ''
          function()
            vim.api.nvim_feedkeys(":Git ", "n", false)
          end
        '';
        lua = true;
        options = {
          desc = "Git ...";
        };
      }

      {
        mode = "n";
        key = "<A-d>";
        action = "<cmd>Gvdiff<CR>";
        options = {
          desc = "Show git diff";
        };
      }

      {
        mode = "n";
        key = "<A-v>";
        action = "<cmd>vertical Git<CR>";
        options = {
          desc = "Git View";
        };
      }

      {
        mode = "n";
        key = "<A-c>";
        action = "<cmd>vertical Git commit<CR>";
        options = {
          desc = "Git commit";
        };
      }

      {
        mode = "n";
        key = "<A-p>";
        action = "<cmd>Git push<CR>";
        options = {
          desc = "Git push";
        };
      }

      {
        mode = "n";
        key = "<A-S>";
        action = "<cmd>Gwrite<CR>";
        options = {
          desc = "Git stage file";
        };
      }

      {
        mode = "n";
        key = "<A-u>";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options = {
          desc = "Git stage hunk";
        };
      }

      {
        mode = "n";
        key = "<A-s>";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options = {
          desc = "Git stage hunk";
        };
      }

      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>Gitsigns nav_hunk prev<CR>";
        options = {
          desc = "Git nav hunk prev";
        };
      }

      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>Gitsigns nav_hunk next<CR>";
        options = {
          desc = "Git nav hunk next";
        };
      }

      {
        mode = "n";
        key = "tb";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options = {
          desc = "Toggle git blame";
        };
      }
    ];
  };
}
