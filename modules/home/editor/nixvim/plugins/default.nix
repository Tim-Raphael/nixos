{ ... }:

{
  imports = [
    ./blink-cmp.nix
    ./conform.nix
    ./fzf-lua.nix
    ./git.nix
    ./lsp.nix
    ./oil.nix
    ./treesitter.nix
  ];

  programs.nixvim.plugins = {
    grug-far.enable = true;
    indent-o-matic.enable = true;
    lz-n.enable = true;
    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
  };
}
