{ pkgs, lib, ... }:

{
  programs.nixvim = {
    extraPackages = lib.mkAfter (
      with pkgs;
      [
        biome
        prettierd
        nixfmt-rfc-style
        taplo
        shfmt
        yamlfmt
        rust-bin.stable.latest.rustfmt
      ]
    );

    plugins.conform-nvim = {
      enable = true;

      settings = {
        notify_on_error = false;

        format_on_save = {
          lspFallback = false;
          timeoutMs = 500;
        };

        formatters_by_ft = {
          html = [ "biome" ];
          css = [ "biome" ];
          javascript = [ "biome" ];
          javascriptreact = [ "biome" ];
          typescript = [ "prettierd" ]; # Work
          typescriptreact = [ "prettierd" ]; # Work
          nix = [ "nixfmt" ];
          rust = [ "rustfmt" ];
          toml = [ "taplo" ];
          markdown = [ "biome" ];
          yaml = [ "yamlfmt" ];
          bash = [ "shfmt" ];
          sh = [ "shfmt" ];
        };
      };
    };
  };
}
