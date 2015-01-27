# nexus

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

### Setup Requirements **OPTIONAL**

This module assumes you already have the required JDK installed, and the
tar ball installation depends on wget, tar and gzip, rather than locking
you to a particular module implementation of these tools you should
install them outside of this module.

### Beginning with nexus

See test/integration/default/puppet/manifests/site.pp for minimal RHEL
setup.

## Usage

The only class that should be included in your manifest is the nexus class.

## Limitations

Only tested on RHEL6.

