{ inputs }:

# Docker Compose v5 (5.1.4 in nixos-26.05, 5.3.1 in unstable) stopped registering
# the service name as a Docker network alias when it creates containers. Containers
# then resolve only by container name (e.g. `myproj-postgres-1`) and NOT by service
# name (`postgres`), which breaks every compose stack that relies on service-name
# DNS between containers — e.g. the OpenTalk testing-environment, where keycloak
# connects via `jdbc:postgresql://postgres/keycloak` and crash-loops with
# `UnknownHostException: postgres`.
#
# Verified 2026-07-31 with a throwaway 2-service stack:
#   compose 5.1.4  -> endpoint Aliases = null
#   compose 2.36.0 -> endpoint Aliases = ["<service>"]
# The daemon honours aliases fine (explicit `docker run --network-alias` works); it
# is purely the v5 client that stopped setting them.
#
# Pin docker-compose to the last-known-good v2 (2.36.0, from nixos-25.05) until the
# v5 regression is fixed upstream. Once fixed, delete this overlay, drop the
# `nixpkgs-compose` input from flake.nix, and remove it from the overlays list.

final: prev:

let
  pkgs2505 = import inputs.nixpkgs-compose {
    system = final.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  docker-compose = pkgs2505.docker-compose;
}
