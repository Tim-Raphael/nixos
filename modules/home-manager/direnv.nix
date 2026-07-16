{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.development.direnv;

  # Names of subflakes under `flakesPath`. Each must expose
  # `devShells.<system>.default`.
  languages = [
    "rust"
    "web"
    "python"
    "c"
    "markdown"
  ];
in
{
  options.development.direnv = {
    enable = mkEnableOption "direnv with auto-detected per-language dev shells";

    flakesPath = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/nixos/main/flakes";
      description = ''
        Absolute path to the directory holding the per-language flakes
        (one subdirectory per language, each with its own flake.nix).
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Flake registry so `nix develop rust` (and the other language names)
    # resolves from any cwd, mirroring what `use project` picks.
    xdg.configFile."nix/registry.json".text = builtins.toJSON {
      version = 2;
      flakes = map (name: {
        from = {
          type = "indirect";
          id = name;
        };
        to = {
          type = "path";
          path = "${cfg.flakesPath}/${name}";
        };
      }) languages;
    };
  };
}
