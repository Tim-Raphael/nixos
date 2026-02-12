{ ... }:

{
  services.openvpn.servers = {
    officeVpnTcp = {
      config = "config /home/raphael/.openvpn/TCP.ovpn";
      #autoStart = true;
      #updateResolvConf = true;
    };
    officeVpnUdp = {
      config = "config /home/raphael/.openvpn/UDP.ovpn";
      #autoStart = true;
      #updateResolvConf = true;
    };
  };
}
