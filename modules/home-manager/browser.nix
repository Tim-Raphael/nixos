{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  programs.chromium = {
    enable = true;

    dictonarys = with pkgs; [
      hunspellDictsChromium.en_US
      hunspellDictsChromium.de_DE
    ];

    extensions = [
      # Darkreader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }

      # Ublock Origin Lite
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }

      # React Developer Tools
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; }
    ];
  };
}
