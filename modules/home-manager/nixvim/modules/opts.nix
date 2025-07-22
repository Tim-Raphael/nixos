{ ... }:

{
  programs.nixvim.opts = {
    autoindent = true; # uses indent from prev. line
    relativenumber = true;
    number = true;
    expandtab = true; # convert tabs into spaces
    tabstop = 4; # display tabs as 4 spaces
    softtabstop = -1; # use tabstop value for softtabstop
    shiftwidth = 0; # use tabstop value for autoindent
    textwidth = 80;
    colorcolumn = "+1";
    wrap = true;
    linebreak = true;
    breakindent = true;
    showbreak = "ͱ";
    swapfile = false;
    cursorcolumn = true;
    scrolloff = 10; # scroll offset
    undofile = true; # enable persistent undo
    updatetime = 100; # faster completion
  };
}
