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
    ./modules/oil.nix
    ./modules/treesitter.nix
    ./modules/telescope.nix
    ./modules/conform.nix
    ./modules/indent-o-matic.nix
    ./modules/statusline.nix
    ./modules/lsp.nix
    ./modules/blink-cmp.nix
    ./modules/fugitive.nix
    ./modules/vimtex.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
  };
}
