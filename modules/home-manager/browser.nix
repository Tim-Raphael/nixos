{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  programs.qutebrowser = {
    enable = true;

    settings = {
      colors = {
        webpage.darkmode = {
          enabled = true;
        };
      };
    };

    keyBindings = {
      normal = {
        "<Space>g" = "cmd-set-text -s :open";
        "<Space>f" = "cmd-set-text -s :tab-select";
        "<Space>p" = "cmd-set-text -s :quickmark-load";

        # cheeky i know :P
        "td" = "set colors.webpage.darkmode.enabled false";
        "tdd" = "set colors.webpage.darkmode.enabled true";

        "<Ctrl-Shift-j>" = "tab-next";
        "<Ctrl-Shift-k>" = "tab-prev";
        "J" = "scroll-px 0 750";
        "K" = "scroll-px 0 -750";
      };
    };
  };

  programs.chromium = {
    enable = true;

    dictionaries = with pkgs; [
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

      # LanguageTool
      { id = "oldceeleldhonbafppcapldpdifcinji"; }
    ];
  };
}
