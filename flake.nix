{
  description = "Ahh yes, a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter.${system} = pkgs.nixfmt;

      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/thinkpad/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };

        tower = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/tower/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
