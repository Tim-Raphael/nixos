{ pkgs, ... }:

{
  # Zed's remote server downloads a generic-linux `node` binary and runs it
  # on this host. NixOS ships no global dynamic linker, so that binary fails
  # with a stub-ld error. nix-ld installs a linker shim plus the libraries
  # these prebuilt binaries expect at runtime.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
    ];
  };
}
