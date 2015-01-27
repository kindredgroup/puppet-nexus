# == Class: nexus
#
# Manages Sonatype Nexus maven (and other) artefact repository
#
# === Parameters
#
# [*ensure*]
#   Ensurable
#
# [*version*]
#   Version of Nexus to install, used to form the download url to the tar ball
#   See $download_url in params.pp
#
# [*service_ensure*]
#   Service ensureable
#
# [*service_enable*]
#   Service enable
#
# [*service_refresh*]
#   Boolean if config changes should restart the Nexus daemon
#
# [*port*]
#   Http listener port for Nexus
#
# [*manage_user*]
#   Boolean if user and group in user.pp should be used as fallback
#
# === Examples
#
# include ::nexus
#
# === Authors
#
# Johan Lyheden <johan.lyheden@unibet.com>
#
# === Copyright
#
# Copyright 2015 North Development AB, unless otherwise noted.
#
class nexus (
  $ensure          = 'present',
  $version         = 'latest',
  $service_ensure  = 'running',
  $service_enable  = true,
  $service_refresh = true,
  $port            = 8080,
  $manage_user     = true
) inherits ::nexus::params {

  # contain the class
  anchor { '::nexus::begin': } ->
  class { '::nexus::user': } ->
  class { '::nexus::package': } ->
  class { '::nexus::files': } ->
  class { '::nexus::config': } ->
  class { '::nexus::service': } ->
  anchor { '::nexus::end': }

  if $service_refresh {
    Class['::nexus::package'] ~> Class['::nexus::service']
    Class['::nexus::config'] ~> Class['::nexus::service']
  }

}
