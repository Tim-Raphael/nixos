{
  pkgs,
  ...
}:

{
  # Polkit is used for controlling system-wide privileges. It provides an
  # organized way for non-privileged processes to communicate with privileged
  # ones. In contrast to sudo, it does not grant root permission to an entire
  # process, but rather allows a finer level of control of centralized system
  # policy.
  security.polkit.enable = true;
  security.pam.services.swaylock = { };
}
