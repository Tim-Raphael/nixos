{ pkgs, ... }:

{
  home.packages = with pkgs; [ pass gnupg pinentry-curses git ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };

  programs.gpg = {
    enable = true;
    settings.pinentry-mode = "loopback";
  };
}
