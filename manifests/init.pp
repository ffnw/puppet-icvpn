class icvpn (
  String        $community,
  String        $node,
  Integer       $local_as,
  String        $transfer_net,
  String        $transfer_net6,
  Array[String] $nets,
  Array[String] $nets6,
  Array[String] $nets_self      = [],
  Array[String] $nets_self6     = [],
) inherits icvpn::params {

  $allnets = $nets + $nets_self
  $allnets6 = $nets6 + $nets_self6

  ($allnets + $allnets6).each | $value | {
    validate_ip_address($value)
  }
  
  validate_ip_address($transfer_net)
  validate_ip_address($transfer_net6)

  class { 'icvpn::install': } ->
  class { 'icvpn::config': }

  contain icvpn::install
  contain icvpn::config

}
