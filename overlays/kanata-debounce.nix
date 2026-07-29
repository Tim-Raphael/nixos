{ inputs }:

# Key-chatter debounce ("cap double taps within N ms") is not in any released
# kanata yet. It lives in the open PR jtroo/kanata#1605, which adds the
# `debounce-duration` / `debounce-algorithm` defcfg options. Pull kanata from
# that PR branch so those options are available (see modules/system/keyboard.nix
# where they are used for the NuPhy Air 60 V2).
#
# Pinned by commit for reproducibility. Once the PR is merged and released,
# delete this overlay and drop it from flake.nix — the config options stay the
# same, only the package source changes back to upstream.

final: prev:

let
  # Base on the unstable kanata (1.12.0); the PR branch is cut from jtroo/kanata
  # main, so its build recipe and Cargo.lock are closest to unstable's.
  kanataUnstable = final.unstable.kanata;

  src = final.fetchFromGitHub {
    owner = "Loosetooth";
    repo = "kanata";
    rev = "3e2d752f724930a7498e21cf912497180edd099e"; # PR #1605 head
    hash = "sha256-vtcwHyrqIJ3dILuamkhRT1pxWxCZR1K3MO0h0gcV1SU=";
  };
in
{
  kanata = kanataUnstable.overrideAttrs (old: {
    inherit src;

    cargoDeps = final.unstable.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-T9fZxv3aujYparzVphfYBJ+5ti/T1VkeCeCqWPyllY8=";
    };

    # The fork's reported version need not match the pinned 1.12.0, so skip the
    # version check that upstream runs at install time.
    doInstallCheck = false;
  });
}
