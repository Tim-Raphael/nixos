{
  description = "Ahh yes, a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Pinned solely to source a working docker-compose v2 — see
    # overlays/docker-compose-pin.nix for the why. Drop once the v5 regression is fixed.
    nixpkgs-compose.url = "github:nixos/nixpkgs/nixos-25.05";

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fonts = {
      url = "git+ssh://git@github.com/hemisphere-systems/fonts?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ocular.url = "git+ssh://git@github.com/hemisphere-systems/ocular";
  };

  outputs =
    { ... }@inputs:
    let
      # The dev shell and its tooling only target the workstation architecture.
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };

      hostModules = {
        default = ./hosts/default/configuration.nix;
        work = ./hosts/work/configuration.nix;
        thinkpad = ./hosts/thinkpad/configuration.nix;
        tower = ./hosts/tower/configuration.nix;
        notebook = ./hosts/notebook/configuration.nix;
      };

      # The bootstrap host reads its hardware profile from a path outside the
      # flake, which pure evaluation forbids. Taking that path as an argument
      # lets the profile check substitute a stand-in for it.
      mkSystem =
        name: hostPath: hardwareProfile:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs hardwareProfile;
          };

          modules = [
            { nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; }
            {
              nixpkgs = {
                overlays = [
                  (import ./overlays/unstable.nix { inherit inputs; })
                  (import ./overlays/kanata-debounce.nix { inherit inputs; })
                  #(import ./overlays/docker-compose-pin.nix { inherit inputs; })
                  inputs.nur.overlays.default
                  inputs.rust-overlay.overlays.default
                ]
                # The fonts overlay pulls a private hemisphere flake over ssh.
                # Keep it off the default host so it builds without extra auth.
                ++ inputs.nixpkgs.lib.optionals (name != "default") [
                  inputs.fonts.overlays.default
                ];
                config = {
                  allowUnfree = true;
                  allowBroken = true;
                  # Required by nheko
                  permittedInsecurePackages = [
                    "olm-3.2.16"
                  ];
                };
              };
            }
            hostPath
          ];
        };

      # Evaluate every host profile down to its top-level derivation. Evaluation
      # fails on any module or type error, so this catches a broken profile
      # without paying for a full build. Impure mode lets host-local paths such
      # as /etc/nixos/hardware-configuration.nix resolve on the target machine.
      buildProfiles = pkgs.writeShellApplication {
        name = "build-profiles";
        runtimeInputs = [ pkgs.nix ];
        text = ''
          profiles=(${toString (builtins.attrNames hostModules)})
          failed=()
          for profile in "''${profiles[@]}"; do
            echo "==> $profile"
            if ! nix eval --impure --raw \
              ".#nixosConfigurations.$profile.config.system.build.toplevel.drvPath" \
              >/dev/null; then
              failed+=("$profile")
            fi
          done
          if [ ''${#failed[@]} -ne 0 ]; then
            echo "profiles failed to evaluate: ''${failed[*]}" >&2
            exit 1
          fi
        '';
      };

      # The heavy tier of the profile check, and the only host CI can run. The
      # four others pull the private hemisphere fonts and ocular repos over ssh,
      # which no runner holds a key for. Discarding the string context of the
      # derivation path forces the evaluation without building the system.
      bootstrapProfile =
        let
          bootstrap = mkSystem "default" hostModules.default ./checks/hardware-profile.nix;
          drvPath = bootstrap.config.system.build.toplevel.drvPath;
        in
        pkgs.runCommand "bootstrap-profile" { } ''
          echo ${builtins.unsafeDiscardStringContext drvPath} > $out
        '';

      preCommitCheck = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixfmt.enable = true;
        };
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs (
        name: hostPath: mkSystem name hostPath /etc/nixos/hardware-configuration.nix
      ) hostModules;

      checks.${system} = {
        pre-commit = preCommitCheck;
        bootstrap-profile = bootstrapProfile;
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;

      devShells.${system}.default = pkgs.mkShell {
        inherit (preCommitCheck) shellHook;
        packages = preCommitCheck.enabledPackages ++ [ buildProfiles ];
      };
    };
}
