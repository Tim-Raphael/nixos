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
        action = "<cmd>ToggleTerm direction=float<CR>";
        options.desc = "Toggle Term (floating)";
        options.silent = true;
      }
    ];

    extraConfigLuaPost = ''
      require("toggleterm").setup()

      -- TODO: Lazy load here

      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}

        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<A-tt>', [[<cmd>ToggleTerm<CR>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      vim.cmd('autocmd! TermOpen term://*toggleterm lua set_terminal_keymaps()')
    '';
  };
}
