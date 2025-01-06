{ pkgs, ... }:

{
  home.packages = with pkgs; [ pass gnupg pinentry-tty git ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    extraConfig = ''
      default-cache-ttl 14400
      max-chache-ttl 28800
      enable-shh-support
    '';
  };

  programs.gpg = { enable = true; };
}
