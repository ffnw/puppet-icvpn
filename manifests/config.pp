class icvpn::config inherits icvpn {

  include router
  include network

  file {
    '/etc/tinc/icvpn/tinc.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/tinc.conf.epp', { community => $community, node => $node }),
      notify  => Service['tinc'];
  } ->
  file {
    '/etc/tinc/icvpn/.git/hooks/post-merge':
      ensure => link,
      target => '../../scripts/post-merge';
  }

  file {
    '/etc/bird/bird.conf.d/icvpn/':
      ensure => directory,
      mode   => '0755',
      owner  => root,
      group  => root;
    '/etc/bird/bird.conf.d/icvpn.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/bird.epp', { allnets => $allnets, transfer_net => $transfer_net, local_as => $local_as }),
      notify  => File['/etc/bird/bird.conf'];
  } ->
  file {
    '/etc/bird/bird6.conf.d/icvpn/':
      ensure => directory,
      mode   => '0755',
      owner  => root,
      group  => root;
    '/etc/bird/bird6.conf.d/icvpn.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/bird6.epp', { allnets6 => $allnets6, transfer_net6 => $transfer_net6, local_as => $local_as }),
      notify  => File['/etc/bird/bird6.conf'];
  } ->
  file {
    '/opt/icvpn-scripts/icvpn-meta/.git/post-merge':
      ensure  => file,
      mode    => '0744',
      content => epp('icvpn/icvpn-meta_post-merge.epp', { community => $community });
  }

  network::inet::static { 'icvpn':
    address => $transfer_net,
  }
  network::inet6::static { 'icvpn':
    address => $transfer_net6,
  }

}
