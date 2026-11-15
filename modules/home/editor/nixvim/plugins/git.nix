{ ... }:

let
  openFileInTab = {
    mode = "n";
    key = "<leader>t";
    action.__raw = "require('diffview.actions').goto_file_tab";
    description = "Open file in new tab";
  };
in
{
  programs.nixvim = {
    plugins = {
      diffview = {
        enable = true;
        settings.keymaps = {
          view = [ openFileInTab ];
          file_panel = [ openFileInTab ];
          file_history_panel = [ openFileInTab ];
        };
      };
      gitsigns.enable = true;
      git-conflict.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>v";
        action.__raw = ''
          function()
            if require('diffview.lib').get_current_view() then
              vim.cmd('DiffviewClose')
            else
              vim.cmd('DiffviewFileHistory')
            end
          end
        '';
        options = {
          desc = "Toggle diff view";
          silent = true;
        };
      }
    ];
  };
}
