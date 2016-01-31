class icvpn (
  String        $name,
  String        $community,
  Integer       $local_as,
  String        $source,
  Array[String] $self_net,
  Array[String] $self_net6,
) inherits icvpn::params {

  ($self_net + $self_net6).each | $value | {
    validate_ip_address($value)
  }
  
  validate_ip_address($source)

  contain bird::install
  contain bird::config

  class { '::bird::install': } ->
  class { '::bird::config': }

}
