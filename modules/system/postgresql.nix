{ pkgs, ... }:

{
  services.postgresql = {
    enable = false;
    package = pkgs.postgresql_17;
    ensureDatabases = [ "misc" ];
    ensureUsers = [
      {
        name = "misc";
        ensureDBOwnership = true;
      }
    ];
  };
}
