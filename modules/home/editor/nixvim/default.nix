{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    # Lazy Load Provider
    ./lazy-load.nix

    # Settings
    ./clipboard.nix
    ./globals.nix
    ./opts.nix
    ./keymaps.nix

    # Plugins
    ./autopairs.nix
    ./blink-cmp.nix
    ./conform.nix
    ./fzf-lua.nix
    ./git.nix
    ./grug-far.nix
    ./indent-o-matic.nix
    ./lsp.nix
    ./oil.nix
    ./statusline.nix
    ./surround.nix
    ./treesitter.nix
    ./vimtex.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    nixpkgs.useGlobalPackages = true;
  };

  stylix.targets.nixvim.enable = true;
}
