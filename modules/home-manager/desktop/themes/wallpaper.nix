{
  config,
  lib,
  pkgs,
  ...
}:

let
  wallpaper = ./backgrounds/blobs-light.svg;
  palette = config.stylix.base16.mkSchemeAttrs config.stylix.generated.palette;
  tint =
    amount:
    let
      channel =
        name:
        let
          value = lib.toInt palette.${"base05-rgb-${name}"};
          mixed = builtins.div (value * (100 - amount) + 255 * amount) 100;
        in
        lib.fixedWidthString 2 "0" (lib.toHexString mixed);
    in
    lib.toLower (
      lib.concatMapStrings channel [
        "r"
        "g"
        "b"
      ]
    );
in
{
  stylix = {
    enable = true;
    polarity = "light";
    # Render the vector at 8K to leave room for the wallpaper's zoom.
    image = pkgs.runCommand "wallpaper.png" { nativeBuildInputs = [ pkgs.librsvg ]; } ''
      rsvg-convert --width 8192 --height 8192 ${wallpaper} --output "$out"
    '';
    imageScalingMode = "fill";
    # Pale tints preserve light-mode contrast with a saturated wallpaper.
    override = {
      base00 = tint 96;
      base01 = tint 91;
      base02 = tint 83;
      base03 = tint 55;
      base04 = tint 30;
    };
  };
}
