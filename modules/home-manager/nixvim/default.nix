{
  inputs,
  config,
  pkgs,
  ...
}:

{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim	
	];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    globals.localmapleader = " ";

    imports = [
      ./config/keymaps.nix
      ./config/options.nix
      ./config/plugins.nix
    ];
  };
}
