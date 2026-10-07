The single wallpaper is GNOME Blobs light by Jakub Steiner, downloaded from the
[original GNOME source](https://github.com/GNOME/gnome-backgrounds/blob/0e0489d8366c5ba813f82f4c5aefb36831f3a155/backgrounds/blobs-l.svg).
Its embedded metadata records the Creative Commons Attribution-ShareAlike 3.0 license.

`wallpaper.nix` renders the vector source at 8192 × 8192 and lets Stylix derive a
light Base16 palette, with pale neutral tints derived from its foreground color.
`appearance.nix` configures Inter through Stylix's sans-serif
font setting. Waybar's Stylix target supplies its font and palette.
Waybar uses a transparent background and fixed light text.
Alacritty and Fish use the fixed Gruvbox Material Dark Medium palette.
Neovim uses the native Gruvbox Material theme with the dark variant
and medium contrast, independently of the wallpaper palette.

Niri runs swaybg as a session service to display the wallpaper statically.
The wallpaper stays fixed behind transparent workspaces during switching and overview.
Sway displays the same image through its output configuration.
All wallpaper and bar behavior is configured in Nix.
