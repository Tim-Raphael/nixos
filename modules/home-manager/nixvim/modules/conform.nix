{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      biome
      prettierd
      nixfmt-rfc-style
      rust-bin.nightly.latest.rustfmt
      shfmt
      yamlfmt
    ];

    plugins.conform-nvim = {
      enable = true;

      lazyLoad.settings = {
        event = [
          "BufReadPre"
          "BufNewFile"
        ];
      };

      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };

        notify_on_error = true;

        formatters_by_ft = {
          html = [ "biome" ];
          css = [ "biome" ];
          javascript = [ "biome" ];
          javascriptreact = [ "biome" ];
          typescript = [ "prettierd" ]; # Work
          typescriptreact = [ "prettierd" ]; # Work
          nix = [ "nixfmt" ];
          rust = [ "rustfmt" ];
          markdown = [ "biome" ];
          yaml = [ "yamlfmt" ];
          bash = [ "shfmt" ];
          sh = [ "shfmt" ];
        };
      };
    };
  };
}
