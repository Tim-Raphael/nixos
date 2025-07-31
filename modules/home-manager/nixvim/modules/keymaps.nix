{ ... }:

{
  programs.nixvim.keymaps = [
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
    # Lizard Mode
    {
      mode = "n";
      key = "tl";
      action = ":%s/./🦎/g<CR>";
      options = {
        desc = "Toggle Lizard Mode";
        noremap = true;
        silent = true;
      };
    }
  ];
}
