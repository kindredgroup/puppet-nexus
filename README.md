# nexus

[![Build Status](https://secure.travis-ci.org/unibet/puppet-nexus.png)](http://travis-ci.org/unibet/puppet-nexus)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nexus](#setup)
    * [What nexus affects](#what-nexus-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nexus](#beginning-with-nexus)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

Installs Sonatype Nexus OSS from tar ball. Tested on RHEL derivates but should
work on any distro provided it has java, wget and tar/gzip installed.

## Module Description

Nexus is a commercial software artifact repository provided by Sonatype, this
module installs the open source version (Nexus OSS).

Configuration parameters is kept to a minimum, other modules such as the
nice nexus_rest module from Atlassian: https://forge.puppetlabs.com/atlassian/nexus_rest
could be used together with this module encapsulated in something like a
profile module.

## Setup

### What nexus affects

* Downloads and extract the Nexus OSS tar ball
* Creates user and group
* Supports installation of plugins

### Setup Requirements

This module assumes you already have the required JDK installed, and the
tar ball installation depends on wget, tar and gzip, rather than locking
you to a particular module implementation of these tools you should
install them outside of this module.

Oracle JDK is required for Nexus to function as expected, actually Nexus 2 does
not even start when using OpenJDK.

### Beginning with nexus

For Nexus 2 OSS example see test/integration/default/puppet/manifests/site.pp for minimal RHEL
setup.

Nexus 3 OSS support is available as well, see test/integration/nexus3/puppet/manifests/site.pp or this
section that I copy pasted into the readme:

```
$java_packages = $::osfamily ? {
  redhat  => 'java-1.8.0-openjdk',
  debian  => ['openjdk-8-jdk', 'openjdk-8-jre']
}
if $::osfamily == 'RedHat' {
  package { 'epel-release': ensure => installed } -> Package[$java_packages]
}
package { $java_packages: ensure => installed }

package { ['tar', 'gzip', 'wget']: ensure => present } ->
class { '::nexus':
  download_url => 'http://download.sonatype.com/nexus/3/nexus-3.0.0-03-unix.tar.gz',
  version      => '3.0.0-03',
  initmemory   => '512M',
  maxmemory    => '512M',
}
```

By default the data directory is stored in the installation folder of the Nexus 3 distribution
you should control this by setting some extra parameters, moving the data directory outside
of the installation dir:

```
class { '::nexus':
  download_url   => 'http://download.sonatype.com/nexus/3/nexus-3.0.0-03-unix.tar.gz',
  version        => '3.0.0-03',
  data_directory => '/opt/sonatype-data',
  tmp_directory  => '/opt/sonatype-data/tmp',
}
```

Upgrades can be done by setting a new version but take caution when doing this
on mission critical systems, it is recommended to test upgrade before hand, have the
proper backups in place etc. For example upgrading from 3.0.0-03 to 3.0.1-01 required
purging of karaf bundle cache files: https://issues.sonatype.org/browse/NEXUS-10449

## Usage

The only class that should be included in your manifest is the nexus class.

## Limitations

Only tested on EL6 and 7, may work on other distros and version combinations. Pull requests are always welcome!
