{ ... }:

{
  programs.nixvim = {
    # Auto groups for organizing autocommands
    autoGroups = {
      directory_sync = {
        clear = true;
      };
    };

    # Autocommand to write current directory on exit
    autoCmd = [
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
