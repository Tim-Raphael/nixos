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
            nixd
        ];
    };

    home.file = { ".config/nvim" = { source = ./nvim; }; };
}

