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

This module requires ffnw-bird and lex-dnsmasq.

### Beginning with icvpn

```puppet
class { '::icvpn':
  name      => 'city1',
  community => 'city',
  local_as  => 65536,
  source    => '1.2.3.4',
  self_net  => '10.x.0.0/16',
  self_net6 => 'fc00::/48',
)
```

## Usage

```puppet
class { '::icvpn':
  name      => 'city1',
  community => 'city',
  local_as  => 65536,
  source    => '1.2.3.4',
  self_net  => '10.x.0.0/16',
  self_net6 => 'fc00::/48',
)
```

## Reference

* class icvpn
  * name
  * community
  * local\_as
  * source
  * self\_net
  * self\_net6

## Limitations

### OS compatibility
* Debian 8

## Development

### How to contribute
Fork the project, work on it and submit pull requests, please.

