{
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./settings
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    nixpkgs.useGlobalPackages = true;

    # The stylix nixvim target breaks several highlight groups, so the
    # scheme is resolved by name through the builtins of base16-nvim
    colorschemes.base16 = {
      enable = true;
      colorscheme = config.lib.stylix.colors.slug;
    };
  };
}
