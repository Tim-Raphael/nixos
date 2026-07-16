{
  description = "Python dev shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" ];
      forSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      devShells = forSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          python = pkgs.python3.withPackages (ps: with ps; [ numpy ]);
        in
        {
          default = pkgs.mkShell {
            packages = [ python ];
          };
        }
      );
    };
}
