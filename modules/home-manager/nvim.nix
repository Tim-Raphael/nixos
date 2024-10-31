{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [ xclip ];
  };

  home.file = { ".config/nvim" = { source = ./nvim; }; };
}

