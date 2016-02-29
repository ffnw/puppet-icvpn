class icvpn::config inherits icvpn {

  include router
  include network

  file {
    '/etc/tinc/icvpn/tinc.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/tinc.conf.epp', {
        community => $community,
        'node'    => $node,
      }),
      notify  => Service['tinc'];
  } ->
  file {
    '/etc/tinc/icvpn/.git/hooks/post-merge':
      ensure => link,
      target => '../../scripts/post-merge';
  }

  file {
    default:
      owner => 'root',
      group => 'root';
    '/etc/bird/bird.conf.d/icvpn/':
      ensure => directory,
      mode   => '0755';
    '/etc/bird/bird.conf.d/icvpn/peers.roa':
      ensure  => file,
      replace => false,
      mode    => '0644',
      content => '';
    '/etc/bird/bird.conf.d/icvpn.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/bird.epp', {
        allnets      => $allnets,
        transfer_net => $transfer_net,
        local_as     => $local_as,
      }),
      notify  => File['/etc/bird/bird.conf'];
  }

  file {
    default:
      owner => 'root',
      group => 'root';
    '/etc/bird/bird6.conf.d/icvpn/':
      ensure => directory,
      mode   => '0755';
    '/etc/bird/bird6.conf.d/icvpn/peers.roa':
      ensure  => file,
      replace => false,
      mode    => '0644',
      content => '';
    '/etc/bird/bird6.conf.d/icvpn.conf':
      ensure  => file,
      mode    => '0644',
      content => epp('icvpn/bird6.epp', {
        allnets6      => $allnets6,
        transfer_net6 => $transfer_net6,
        local_as      => $local_as,
      }),
      notify  => File['/etc/bird/bird6.conf'];
  } ->
  file {
    '/opt/icvpn-scripts/icvpn-meta/.git/post-merge':
      ensure  => file,
      mode    => '0744',
      content => epp('icvpn/icvpn-meta_post-merge.epp', {
        community => $community,
      });
  }

  if ($kernel_table) {
    $ip4_rule_up   = [ "/bin/ip -4 rule add pref 31000 iif $IFACE table ${kernel_table}",
                       "/bin/ip -4 rule add pref 31001 iif $IFACE unreachable", ]
    $ip6_rule_up   = [ "/bin/ip -6 rule add pref 31000 iif $IFACE table ${kernel_table}",
                       "/bin/ip -6 rule add pref 31001 iif $IFACE unreachable", ]
    $ip4_rule_down = [ "/bin/ip -4 rule del pref 31000 iif $IFACE table ${kernel_table}",
                       "/bin/ip -4 rule del pref 31001 iif $IFACE unreachable", ]
    $ip6_rule_down = [ "/bin/ip -6 rule del pref 31000 iif $IFACE table ${kernel_table}",
                       "/bin/ip -6 rule del pref 31001 iif $IFACE unreachable", ]
  } else {
    $ip4_rule_up   = []
    $ip6_rule_up   = []
    $ip4_rule_down = []
    $ip6_rule_down = []
  }

  network::inet::static { 'icvpn':
    address   => $transfer_net,
    pre_up    => $ip4_rule_up,
    post_down => $ip4_rule_down,
  }
  network::inet6::static { 'icvpn':
    address => $transfer_net6,
    pre_up    => $ip6_rule_up,
    post_down => $ip6_rule_down,
  }

}
