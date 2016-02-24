class icvpn::install inherits icvpn {

  require bird
  require dnsmasq

  package { 'tinc':
    ensure => installed,
  }
  
  package { 'git':
    ensure => installed,
  }

  package { 'python-yaml':
    ensure => installed,
  }

  vcsrepo { '/etc/tinc/icvpn':
    ensure   => latest,
    owner    => 'root',
    group    => 'root',
    provider => 'git',
    require  => [ Package['git'] ],
    source   => 'https://github.com/freifunk/icvpn.git',
    revision => 'master',
  } ->
  exec { '/usr/sbin/tincd -n icvpn -K':
    unless  => '/usr/bin/test -f /etc/tinc/icvpn/rsa_key.priv',
  } ->
  file {
    default:
      ensure => file,
      mode   => '0755',
      owner  => 'root',
      group  => 'root';
    '/etc/tinc/icvpn/tinc-up':
      source => 'puppet:///modules/icvpn/tinc-up';
    '/etc/tinc/icvpn/tinc-down':
      source => 'puppet:///modules/icvpn/tinc-down';
  } ->
  file_line { 'nets.boot icvpn':
    path => '/etc/tinc/nets.boot',
    line => 'icvpn',
  }

  vcsrepo { '/opt/icvpn-scripts':
    ensure   => latest,
    owner    => 'root',
    group    => 'root',
    provider => 'git',
    require  => [ Package['git'] ],
    source   => 'https://github.com/freifunk/icvpn-scripts.git',
    revision => 'master',
  } ->
  vcsrepo { '/opt/icvpn-meta':
    ensure   => latest,
    owner    => 'root',
    group    => 'root',
    provider => 'git',
    require  => [ Package['git'] ],
    source   => 'https://github.com/freifunk/icvpn-meta.git',
    revision => 'master',
  }

}

