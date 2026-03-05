{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim

    # Lazy Load Provider
    ./modules/lazy-load.nix

    # Settings
    ./modules/colorschemes.nix
    ./modules/clipboard.nix
    ./modules/globals.nix
    ./modules/opts.nix
    ./modules/keymaps.nix

    # Plugins
    ./modules/blink-cmp.nix
    ./modules/conform.nix
    ./modules/fugitive.nix
    ./modules/goyo.nix
    ./modules/indent-o-matic.nix
    ./modules/lsp.nix
    ./modules/nvim-surround.nix
    ./modules/oil.nix
    ./modules/remote-ssh.nix
    ./modules/statusline.nix
    ./modules/telescope.nix
    ./modules/treesitter.nix
    ./modules/vimtex.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
  };
}
