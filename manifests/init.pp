class icvpn (
  String        $community,
  String        $community_node,
  Integer       $local_as,
  String        $transfer_net,
  String        $transfer_net6,
  Array[String] $nets,
  Array[String] $nets6,
  Array[String] $nets_self      = [],
  Array[String] $nets_self6     = [],
) inherits icvpn::params {

  ($nets + $nets6 + $nets_self + $nets_self6).each | $value | {
    validate_ip_address($value)
  }
  
  validate_ip_address($transfer_net)
  validate_ip_address($transfer_net6)

  class { 'icvpn::install': } ->
  class { 'icvpn::config': }

  contain icvpn::install
  contain icvpn::config

}
