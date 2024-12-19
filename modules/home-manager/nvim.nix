{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      xclip
      ripgrep

      # LSP
      lua-language-server
      rust-analyzer
      rustfmt
      clippy
      nixd
      nixfmt
      nodePackages_latest.typescript-language-server
      vscode-langservers-extracted
      intelephense
    ];
  };

  home.file = {
    ".config/nvim/init.lua" = { source = ./nvim/init.lua; };
    ".config/nvim/lua" = { source = ./nvim/lua; };
  };
}

