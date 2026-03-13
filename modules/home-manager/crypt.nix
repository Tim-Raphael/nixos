{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 14400;
    maxCacheTtl = 28800;
    pinentry = {
      package = pkgs.pinentry-tty;
    };
  };
}
