{ ... }:

{
  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>y";
      action.__raw = ''
        function()
          local path = vim.fn.expand('%:p')
          if path == "" or vim.bo.buftype ~= "" then
            vim.notify("Current buffer has no file path", vim.log.levels.WARN)
            return
          end

          local cwd = vim.fn.getcwd()
          local root = cwd == "/" and "/" or cwd .. "/"
          if path:sub(1, #root) == root then
            path = "/" .. path:sub(#root + 1)
          end

          local first_line = vim.fn.line('.')
          local last_line = first_line
          local mode = vim.fn.mode()
          if mode == "v" or mode == "V" or mode == "\22" then
            local anchor = vim.fn.line('v')
            first_line = math.min(first_line, anchor)
            last_line = math.max(last_line, anchor)
          end

          local location = path .. ":" .. first_line
          if last_line ~= first_line then
            location = location .. "-" .. last_line
          end

          vim.fn.setreg('+', location)
          vim.fn.setreg('"', location)
        end
      '';
      options = {
        desc = "Copy file path and line range";
        noremap = true;
        silent = true;
      };
    }

    {
      mode = "x";
      key = "<leader>p";
      action = "\"_dP";
      options = {
        desc = "Delete into blank registry and paste from clipboard";
        noremap = true;
        silent = true;
      };
    }

    {
      mode = "i";
      key = "<C-BS>";
      action = "<C-w>";
      options = {
        desc = "Delete previous word";
        noremap = true;
        silent = true;
      };
    }

    {
      key = "<C-S-r>";
      action = "<cmd>luafile $MYVIMRC<CR>";
      options = {
        desc = "Reload nvim";
        noremap = true;
        silent = true;
      };
    }

    # Window navigation
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        noremap = true;
        silent = true;
      };
    }

    # Tabs
    {
      key = "<C-t>";
      action = ":tabnew<cr>";
      options.silent = true;
      options.desc = "New Tab";
    }
    {
      key = "<C-S-l>";
      mode = "n";
      action = ":tabnext<CR>";
      options = {
        silent = true;
        desc = "Next Tab";
      };
    }
    {
      key = "<C-S-h>";
      mode = "n";
      action = ":tabprev<CR>";
      options = {
        silent = true;
        desc = "Previous Tab";
      };
    }
  ];
}
