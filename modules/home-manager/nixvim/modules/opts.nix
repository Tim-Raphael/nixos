{ ... }:

{
  programs.nixvim.opts = {
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
  };
}
