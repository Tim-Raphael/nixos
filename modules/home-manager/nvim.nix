{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      gcc
      xclip
      ripgrep

      # LSP
      rust-analyzer
      rustfmt
      taplo-cli
      clippy
      nixd
      nixfmt-rfc-style
      intelephense
      lua-language-server
      typescript-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
    ];
  };

  home.file = {
    ".config/nvim/init.lua" = {
      source = ./nvim/init.lua;
    };
    ".config/nvim/lua" = {
      source = ./nvim/lua;
    };
  };
}
