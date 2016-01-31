class icvpn (
  String        $community,
  String        $community_node,
  Integer       $local_as,
  String        $transfer_net,
  String        $transfer_net6,
  Array[String] $self_net,
  Array[String] $self_net6,
) inherits icvpn::params {

  ($self_net + $self_net6).each | $value | {
    validate_ip_address($value)
  }
  
  validate_ip_address($transfer_net)
  validate_ip_address($transfer_net6)

  contain bird::install
  contain bird::config

  class { '::bird::install': } ->
  class { '::bird::config': }

}
