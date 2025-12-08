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
        key = "tg";
        # TODO: Pressing tg again should close git view
        action = "<cmd>vertical Git<CR>";
        options = {
          desc = "Toggle Git View";
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
