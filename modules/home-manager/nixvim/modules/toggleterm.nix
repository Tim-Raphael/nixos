{ ... }:

{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;

      settings = {
        autochdir = true;
        direction = "vertical";
      };
    };

    keymaps = [
      {
        key = "tt";
        action = "<cmd>ToggleTerm size=75 direction=vertical<CR>";
        options.desc = "Open terminal";
        options.silent = true;
      }
    ];

    extraConfigLuaPost = ''
      require("toggleterm").setup()

      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}

        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

        vim.keymap.set('t', '<A-t>', [[<cmd>ToggleTerm<CR>]], opts)

        vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<CR>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      vim.cmd('autocmd! TermOpen term://*toggleterm lua set_terminal_keymaps()')
    '';
  };
}
