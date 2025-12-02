{ ... }:

{
  programs.nixvim = {
    opts = {
      # Edit
      mouse = "";
      autoindent = true; # Uses indent from prev line
      expandtab = true; # Convert tabs into spaces
      tabstop = 4; # Display tabs as 4 spaces
      softtabstop = -1; # Use tabstop value for softtabstop
      shiftwidth = 0; # Use tabstop value for autoindent
      swapfile = false;
      undofile = true; # Enable persistent undo
      updatetime = 100; # Faster completion
      ignorecase = true; # Ignore case in search patterns

      # View
      termguicolors = true; # Enable 24-bit colors
      number = true;
      showmode = false; # Should live in lualine
      relativenumber = true;
      signcolumn = "yes"; # Always show signs (no layout shifting)
      scrolloff = 10; # Scroll offset
      colorcolumn = "81";
      wrap = true;
      linebreak = true;
      breakindent = true;
      showbreak = "ͱ";
      hidden = true;

      # Found out, that this plays nice with darkmode themes, but not the other
      # way around, so I'm going to leave it on light for now.
      background = "light";
    };
  };
}
