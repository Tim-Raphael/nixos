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
      nodejs_23

      # LSP
      rust-analyzer
      rustfmt
      clippy
      nixd
      nixfmt
      intelephense
      lua-language-server
      typescript-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
    ];
  };

  home.file = {
    ".config/nvim/init.lua" = { source = ./nvim/init.lua; };
    ".config/nvim/lua" = { source = ./nvim/lua; };
  };
}

