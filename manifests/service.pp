class icvpn::service inherits icvpn {

  service { 'tinc':
    enable => true,
    ensure => running,
  }

}

