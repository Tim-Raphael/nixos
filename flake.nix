{
  description = "Ahh yes, a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-colors.url = "github:misterio77/nix-colors";

    fonts = {
      url = "git+ssh://git@github.com/hemisphere-systems/fonts?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      rust-overlay,
      ...
    }@inputs:
    let
      mkSystem =
        hostPath:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            {
              nixpkgs.overlays = [
                (import ./overlays/unstable.nix { inherit inputs; })
                inputs.fonts.overlays.default
                rust-overlay.overlays.default
              ];
            }
            hostPath
          ];
        };
    in
    {
      nixosConfigurations = {
        default = mkSystem ./hosts/default/configuration.nix;
        work = mkSystem ./hosts/work/configuration.nix;
        thinkpad = mkSystem ./hosts/thinkpad/configuration.nix;
        tower = mkSystem ./hosts/tower/configuration.nix;
        notebook = mkSystem ./hosts/notebook/configuration.nix;
      };
    };
}
