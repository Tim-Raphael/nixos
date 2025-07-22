{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    # SETTINGS
    ./modules/globals.nix
    ./modules/opts.nix
    ./modules/clipboard.nix
    ./modules/keymaps.nix
    ./modules/colorschemes.nix
    ./modules/auto-indent.nix

    # PLUGINS
    ./modules/plugins.nix
    ./modules/oil.nix
    ./modules/conform.nix
    ./modules/treesitter.nix
    ./modules/telescope.nix
    ./modules/lsp.nix
    ./modules/cmp.nix
    ./modules/alpha.nix
    ./modules/lualine.nix
  ];

  programs.nixvim.enable = true;
}
