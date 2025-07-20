{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      biome
      nixfmt-rfc-style
      rustfmt
      shfmt
      yamlfmt
    ];

    plugins.conform-nvim = {
      enable = true;

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
          typescript = [ "biome" ];
          typescriptreact = [ "biome" ];
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
