{ ... }:

{
  programs.nixvim.keymaps = [
    # Reload nvim
    {
      key = "<C-S-r>";
      action = "<cmd>luafile $MYVIMRC<CR>";
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

    # Tabs
    {
      key = "<C-w>";
      action = ":wq<cr>";
      options.silent = true;
      options.desc = "Close Tab";
    }
    {
      key = "<C-t>";
      action = ":tabnew<cr>";
      options.silent = true;
      options.desc = "New Tab";
    }
    {
      key = "<Tab>";
      mode = "n";
      action = ":tabnext<CR>";
      options.silent = true;
      options.desc = "Next Tab";
    }
    {
      key = "<S-Tab>";
      mode = "n";
      action = ":tabprev<CR>";
      options.silent = true;
      options.desc = "Previous Tab";
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
