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
    ./modules/clipboard.nix
    ./modules/globals.nix
    ./modules/opts.nix
    ./modules/keymaps.nix

    # Plugins
    ./modules/autopairs.nix
    ./modules/blink-cmp.nix
    ./modules/conform.nix
    ./modules/gitsigns.nix
    ./modules/fugitive.nix
    ./modules/indent-o-matic.nix
    ./modules/lsp.nix
    ./modules/surround.nix
    ./modules/obsidian.nix
    ./modules/oil.nix
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
