{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      # TODO: Lazy load fugitive
      fugitive.enable = true;
      gitsigns.enable = true;
      git-conflict.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<leader>vD";
        action = "<cmd>Gvdiffsplit!<CR>";
        options = {
          desc = "Git diff split";
        };
      }

      {
        mode = "n";
        key = "<leader>vd";
        action = "<cmd>Gvdiffsplit<CR>";
        options = {
          desc = "Git diff split";
        };
      }

      {
        mode = "n";
        key = "<leader>vS";
        action = "<cmd>Gwrite<CR>";
        options = {
          desc = "Git stage file";
        };
      }

      {
        mode = "n";
        key = "<leader>vs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options = {
          desc = "Git stage hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>vu";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options = {
          desc = "Git unstage stage hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>vv";
        action = "<cmd>vertical Git<CR>";
        options = {
          desc = "Toggle Git View";
        };
      }

      {
        mode = "n";
        key = "<leader>vp";
        action = "<cmd>Git push<CR>";
        options = {
          desc = "Git push";
        };
      }

      {
        mode = "n";
        key = "<leader>vP";
        action = "<cmd>Git pull<CR>";
        options = {
          desc = "Git pull";
        };
      }

      {
        mode = "n";
        key = "<leader>vc";
        action = "<cmd>Git commit<CR>";
        options = {
          desc = "Git commit";
        };
      }

      {
        mode = "n";
        key = "<leader>vb";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options = {
          desc = "Toggle git blame";
        };
      }
    ];
  };
}
