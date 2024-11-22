{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    gh
    websocat
    postman
    yarn
    cargo
    rustc
    gcc
    binutils
    nodejs_22
    nodePackages.typescript
    nodePackages.live-server
  ];
}
