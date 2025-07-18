{
  description = "Ahh yes, a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nix-colors.url = "github:misterio77/nix-colors";

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
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/default/configuration.nix
          ];
        };

        work = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/work/configuration.nix
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = {
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
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/tower/configuration.nix
          ];
        };

        notebook = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/notebook/configuration.nix
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            { nix.nixPath = [ "nixpkgs=${nixpkgs}" ]; }
            ./hosts/server/configuration.nix
          ];
        };
      };
    };
}
