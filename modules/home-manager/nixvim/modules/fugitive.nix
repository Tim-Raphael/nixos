{ lib, ... }:

{
  programs.nixvim = {
    plugins = {
      # TODO: Lazy load fugitive
      fugitive.enable = true;
      gitsigns.enable = true;
    };

    keymaps = lib.mkAfter [
      {
        mode = "n";
        key = "<C-c>";
        action = "<cmd>vertical Git commit<CR>";
        options = {
          desc = "Git commit";
        };
      }

      {
        mode = "n";
        key = "<C-S-s>";
        action = "<cmd>Gwrite<CR>";
        options = {
          desc = "Git stage file";
        };
      }

      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options = {
          desc = "Git stage hunk";
        };
      }

      {
        mode = "n";
        key = "<C-u>";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options = {
          desc = "Git unstage stage hunk";
        };
      }

      {
        mode = "n";
        key = "<C-g>";
        action = "<cmd>vertical Git<CR>";
        options = {
          desc = "Git View";
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
