{ ... }:

{
  programs.nixvim.opts = {
    autoindent = true; # uses indent from prev. line
    relativenumber = true;
    number = true;
    expandtab = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
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
