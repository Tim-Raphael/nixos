The single wallpaper is GNOME Blobs light by Jakub Steiner, downloaded from the
[original GNOME source](https://github.com/GNOME/gnome-backgrounds/blob/0e0489d8366c5ba813f82f4c5aefb36831f3a155/backgrounds/blobs-l.svg).
Its embedded metadata records the Creative Commons Attribution-ShareAlike 3.0 license.

`wallpaper.nix` renders the vector source at 8192 × 8192 and lets Stylix derive a
light Base16 palette, with pale neutral tints derived from its foreground color.
`appearance.nix` configures Inter through Stylix's sans-serif
font setting. Waybar's Stylix target supplies its font and palette.
Waybar has a transparent background. The wallpaper renderer samples the visible
top 30 logical pixels separately for each output and chooses dark or light text
by relative luminance and contrast. Sampling follows the animated wallpaper crop
at most every 100 milliseconds. A 15 percent switching margin prevents flicker.
The renderer writes output-specific colors to `~/.cache/waybar-wallpaper.css`
when the mode changes, and Waybar reloads the imported stylesheet automatically.
Warnings and errors use matching contrast variants, and a small text shadow
helps with local variation. The choice applies to Waybar text only.
Alacritty and Fish use the fixed Gruvbox Material Dark Medium palette.
Neovim uses the native Gruvbox Material theme with the light variant
and medium contrast, independently of the wallpaper palette.

Niri uses the Quickshell renderer in `wallpaper` with 12 percent overscan.
The background sits behind the workspace animation, with transparent workspace
backgrounds so the image remains visible at rest. Each output has independent
offsets based on its active workspace and actual horizontal viewport position.
Offsets ease toward their targets and stay within four percent of the screen
dimensions, including on very long workspaces. Sway displays the same image statically.

The renderer listens to Niri's IPC event stream and reconnects after disconnects.
It responds to layout events, so centering and touchpad scrolling also update
the horizontal offset. It does not poll Niri or regenerate wallpaper images while scrolling.
