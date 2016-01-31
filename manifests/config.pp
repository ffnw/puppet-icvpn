class icvpn::config inherits icvpn {

  file {
    '/etc/tinc/icvpn/tinc.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/tinc.conf.epp'),
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
      content => epp('icvpn/bird.epp'),
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
      content => epp('icvpn/bird6.epp'),
      notify  => File['/etc/bird/bird6.conf'];
  } ->
  file {
    '/opt/icvpn-scripts/icvpn-meta/.git/post-merge':
      ensure  => file,
      mode    => '0744',
      content => epp('icvpn/icvpn-meta_post-merge.epp');
  }

}
