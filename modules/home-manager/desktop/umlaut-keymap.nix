{ pkgs }:

pkgs.writeText "us-mac-umlauts.xkb" ''
  xkb_keymap {
    xkb_keycodes { include "evdev+aliases(qwerty)" };
    xkb_types {
      include "complete"
      type "MAC_UMLAUT" {
        modifiers = Shift+Lock+Mod1;
        map[None] = Level1;
        map[Shift] = Level2;
        map[Lock] = Level2;
        map[Shift+Lock] = Level1;
        map[Mod1] = Level3;
        map[Shift+Mod1] = Level3;
        map[Lock+Mod1] = Level3;
        map[Shift+Lock+Mod1] = Level3;
      };
    };
    xkb_compatibility { include "complete" };
    xkb_symbols {
      include "pc+us+inet(evdev)+compose(ralt)"
      key <AD07> {
        type[Group1] = "MAC_UMLAUT",
        symbols[Group1] = [ u, U, dead_diaeresis ]
      };
    };
  };
''
