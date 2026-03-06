{ ... }:

{
  programs.nixvim.plugins.distant = {
    enable = true;
    # Plugin broken :(
    settings = {
      client = {
        log_level = "trace";
        log_file = "/tmp/distant_client.log";
      };
      manager = {
        log_level = "trace";
        log_file = "/tmp/distant_manager.log";
      };
    };
  };
}
