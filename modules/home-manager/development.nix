{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # todo!();
    git
    gh
    cargo
    # rustup
    rustc
    gcc
    # libgccjit
    binutils
    nodejs_22
  ];
}
