{ pkgs, ... }:

{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      nixGrammars = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cpp
        css
        csv
        dockerfile
        haskell
        html
        javascript
        json
        lua
        lua
        make
        markdown
        nix
        proto
        python
        regex
        rust
        sql
        terraform
        toml
        typescript
        vim
        vimdoc
        xml
        yaml
      ];

      folding = true;

      settings = {
        auto_install = true;
        ensure_installed = "all";
        highlight.enable = true;
      };
    };

    extraConfigLua = ''
      vim.cmd("syntax on")
    '';
  };
}
