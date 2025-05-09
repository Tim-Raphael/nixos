{
  description = "Ahh yes, a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-colors,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit nix-colors;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/default/configuration.nix
          ];
        };

        work = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit nix-colors;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/work/configuration.nix
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit nix-colors;
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/thinkpad/configuration.nix
          ];
        };

        tower = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit nix-colors;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/tower/configuration.nix
          ];
        };

        notebook = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit nix-colors;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/notebook/configuration.nix
          ];
        };
      };
    };
}
