{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    gh
    glab
    websocat
    postman
    yarn
    rustup
    taplo
    mdl
    lld
    llvm
    clang
    commitlint
    # gcc
    # binutils
    nodejs_23
    pnpm_10
    nodePackages.typescript
    nodePackages.live-server
  ];

  xdg.configFile.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';
}
