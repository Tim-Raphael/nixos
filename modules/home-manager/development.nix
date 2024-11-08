{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    gh
    cargo
    rustc
    gcc
    binutils
    nodejs_22
    nodePackages.typescript
    nodePackages.live-server
  ];
}
