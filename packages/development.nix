{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        git
        cargo
        rustup
        rustc
        rust-analyzer
        gcc
        libgccjit
        binutils
        docker
        nodejs_22
        nodePackages_latest.npm
        gh
    ];
}

