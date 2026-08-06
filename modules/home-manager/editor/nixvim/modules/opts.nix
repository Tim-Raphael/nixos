{ ... }:

{
  programs.nixvim.opts = {
    # Uses indent from previous line
    autoindent = true;
    # Keep indentation shape when creating/reindenting lines
    copyindent = true;
    # Convert tabs into spaces
    expandtab = true;
    # Display tabs as 4 spaces
    tabstop = 4;
    # Use tabstop value for softtabstop
    softtabstop = -1;
    # Use tabstop value for autoindent
    shiftwidth = 0;
    # Disable swapfile (causes conflicts)
    swapfile = false;
    # Enable persistent undo
    undofile = true;
    # Faster completion
    updatetime = 100;
    # Ignore case in search patterns
    ignorecase = true;
    # Enable 24-bit colors
    termguicolors = true;
    number = true;
    relativenumber = true;
    # Always show signs (no layout shifting)
    signcolumn = "yes";
    # Scroll offset
    scrolloff = 10;
    colorcolumn = "81,101";
    wrap = true;
    linebreak = true;
    breakindent = true;
    showbreak = "ͱ";
    # Skip intro message
    shortmess = "ltToOCFI";
    # Found out, that this plays nice with darkmode themes, but not the other
    # way around, so I'm going to leave it on light for now.
    #background = "light";
    winborder = "single";
    # Hopefully fixes some issues I had with vimdiff
    diffopt = [
      "internal"
      "filler"
      "closeoff"
      "algorithm:histogram"
      "indent-heuristic"
    ];
  };
}
