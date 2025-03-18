{ pkgs, ... }:

{
  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    defaultCacheTtl = 14400;
    maxCacheTtl = 28800;
  };
}
