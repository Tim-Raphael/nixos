{
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./settings
    ./plugins
  ];

  stylix.targets.nixvim.enable = true;
  programs.nixvim = {
    enable = true;
    viAlias = true;
    nixpkgs.useGlobalPackages = true;
  };
}
