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

      # Search
      ignorecase = true; # ignore case in search patterns

      # View
      termguicolors = true; # eanble 24-bit colors
      number = true;
      relativenumber = true;
      signcolumn = "yes"; # always show signs (no layout shifting)
      scrolloff = 10; # scroll offset
      colorcolumn = "+1";
      wrap = true;
      linebreak = true;
      breakindent = true;
      showbreak = "ͱ";
      showmode = false;
      conceallevel = 1;

      # Found out that this plays nice with darkmode themes, but not the other
      # way around, so I'm going to leave it on light for now.
      background = "light";

      # File
      swapfile = false;
      undofile = true; # enable persistent undo
      updatetime = 100; # faster completion
    };
  };
}
