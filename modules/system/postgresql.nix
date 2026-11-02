{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
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
