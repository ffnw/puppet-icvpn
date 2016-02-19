# puppet-icvpn

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with icvpn](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with icvpn](#beginning-with-icvpn)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This puppet module manages ICVPN connections.

## Setup

### Setup Requirements

This module requires ffnw-bird, ffnw-network, lex-dnsmasq and inkblot-ipcalc.

### Beginning with icvpn

```puppet
class { 'icvpn':
  community     => 'city',
  node          => '1',
  local_as      => 65536,
  transfer_net  => '10.207.0.0/16',
  transfer_net6 => 'fec0::a:cf:0:0/96',
  self_net      => '10.x.0.0/16',
  self_net6     => 'fc00::/48',
}
```

## Usage

```puppet
class { 'icvpn':
  community     => 'city',
  node          => '1',
  local_as      => 65536,
  transfer_net  => '10.207.0.0/16',
  transfer_net6 => 'fec0::a:cf:0:0/96',
  self_net      => '10.x.0.0/16',
  self_net6     => 'fc00::/48',
}
```

## Reference

* class icvpn
  * community
  * node
  * local\_as
  * transfer\_net
  * transfer\_net6
  * nets
  * nets6
  * nets_self (optional, default [])
  * nets_self6 (optional, default [])

## Limitations

### OS compatibility
* Debian 8

## Development

### How to contribute
Fork the project, work on it and submit pull requests, please.

