{ ... }:

{
  programs.nixvim = {
    opts = {
      # Edit
      autoindent = true; # uses indent from prev. line
      expandtab = true; # convert tabs into spaces
      tabstop = 4; # display tabs as 4 spaces
      softtabstop = -1; # use tabstop value for softtabstop
      shiftwidth = 0; # use tabstop value for autoindent
      textwidth = 80;

      # View
      termguicolors = true; # eanble 24-bit colors
      number = true;
      relativenumber = true;
      scrolloff = 10; # scroll offset
      colorcolumn = "+1";
      wrap = true;
      linebreak = true;
      breakindent = true;
      showbreak = "ͱ";
      showmode = false;

      # File
      swapfile = false;
      undofile = true; # enable persistent undo
      updatetime = 100; # faster completion
    };
  };
}
