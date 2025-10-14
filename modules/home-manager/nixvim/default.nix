{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    # SETTINGS
    ./modules/colorschemes.nix
    ./modules/clipboard.nix
    ./modules/globals.nix
    ./modules/opts.nix
    ./modules/keymaps.nix
    ./modules/auto-cmd.nix

    # PLUGINS
    ./modules/alpha.nix
    ./modules/conform.nix
    ./modules/cmp.nix
    ./modules/fugitive.nix
    ./modules/indent-blankline.nix
    ./modules/lsp.nix
    ./modules/lualine.nix
    ./modules/oil.nix
    ./modules/plugins.nix
    ./modules/treesitter.nix
    ./modules/telescope.nix
    ./modules/toggleterm.nix
    ./modules/spectre.nix
    ./modules/obsidian.nix
    ./modules/vimtex.nix
    ./modules/workspace-diagnostics.nix
  ];

  programs.nixvim.enable = true;
}
