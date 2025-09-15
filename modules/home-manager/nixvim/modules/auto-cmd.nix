{ ... }:

{
  programs.nixvim = {
    # Auto groups for organizing autocommands
    autoGroups = {
      directory_sync = {
        clear = true;
      };
    };

    autoCmd = [
      # Close  all floating windows when opening oil (fix for lsp.buf.hover())
      {
        event = [ "User" ];
        pattern = "OilEnter";
        callback = {
          __raw = ''
            function()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local config = vim.api.nvim_win_get_config(win)
                if config.relative ~= "" then
                  pcall(vim.api.nvim_win_close, win, false)
                end
              end
            end
          '';
        };
      }

      # Autocommand to write current directory on exit
      {
        event = [ "VimLeave" ];
        group = "directory_sync";
        desc = "Write current directory to file for shell sync.";
        callback = {
          __raw = ''
            function()
              local cwd = vim.fn.getcwd()
              local home = vim.fn.expand("~")
              local file = io.open(home .. "/.nvim_last_dir", "w")
              if file then
                file:write(cwd)
                file:close()
              end
            end
          '';
        };
      }
    ];
  };
}
