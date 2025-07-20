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
    ./modules/keymaps.nix
    ./modules/colorschemes.nix

    # PLUGINS
    ./modules/plugins.nix
    ./modules/oil.nix
    ./modules/conform.nix
    ./modules/treesitter.nix
    ./modules/telescope.nix
  ];

  programs.nixvim.enable = true;
}
