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
    nodejs_23
    pnpm_10
    nodePackages.typescript
    nodePackages.live-server
  ];
}
