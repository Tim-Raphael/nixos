{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    # SETTINGS
    ./modules/globals.nix
    ./modules/keymaps.nix
    ./modules/colorschemes.nix

    # PLUGINS
    ./modules/plugins.nix
    ./modules/treesitter.nix
    ./modules/telescope.nix
  ];

  programs.nixvim.enable = true;
}
