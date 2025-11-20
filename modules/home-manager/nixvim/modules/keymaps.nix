{ ... }:

{
  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "<C-BS>";
      action = "<C-w>";
      options = {
        desc = "Delete previous word.";
        noremap = true;
        silent = true;
      };
    }

    {
      key = "<C-S-r>";
      action = "<cmd>luafile $MYVIMRC<CR>";
      options = {
        desc = "Reload nvim.";
        noremap = true;
        silent = true;
      };
    }

    # Scroll
    {
      key = "<S-j>";
      action = "<C-d>"; # half page (full page: <C-b>)
      options = {
        noremap = true;
        silent = true;
      };
    }

    {
      key = "<S-k>";
      action = "<C-u>"; # half page (full page: <C-b>)
      options = {
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

    # Resize
    {
      mode = "n";
      key = "rv";
      action = ''
        function()
          vim.api.nvim_feedkeys(":vertical resize ", "n", false)
        end
      '';
      lua = true;
      options.silent = true;
      options.desc = "Resize Vertical";
    }
    {
      mode = "n";
      key = "rh";
      action = ''
        function()
          vim.api.nvim_feedkeys(":resize ", "n", false)
        end
      '';
      lua = true;
      options.silent = true;
      options.desc = "Resize Horizontal";
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

    # Lizard Mode
    {
      mode = "n";
      key = "tl";
      action = {
        __raw = ''
          function()
              vim.cmd(":%s/[^ \\t\\n\\r]/🦎/g")
              vim.cmd("noh")
              vim.cmd("normal! \\<C-o>")
          end
        '';
      };
      options = {
        desc = "Toggle Lizard Mode";
        noremap = true;
        silent = true;
      };
    }
  ];
}
