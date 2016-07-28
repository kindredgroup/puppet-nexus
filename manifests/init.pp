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
#   Latest will imply the latest version of 2.x, if you set the version to any
#   valid 3.x version some conditional logic in the configuration class will
#   detect that and configure the correct configuration files
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
# [*initmemory*]
#   Optional Nexus jvm Xms parameter in megabytes
#
# [*maxmemory*]
#   Optional Nexus jvm Xmx parameter in megabytes
#
# [*maxpermsize*]
#   Optional Nexus jvm permgen size with unit suffix (ex: 123M)
#
# [*javacommand*]
#   Optional Name or full path to java executable
#
# [*plugins*]
#   Array of plugins to install, must be ::nexus::plugin::<THIS> class
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
  $ensure            = 'present',
  $version           = 'latest',
  $service_ensure    = 'running',
  $service_enable    = true,
  $service_refresh   = true,
  $port              = 8080,
  $manage_user       = true,
  $initmemory        = undef,
  $maxmemory         = undef,
  $maxpermsize       = undef,
  $javacommand       = undef,
  $plugins           = [],
  $download_url      = $::nexus::params::download_url,
  $install_directory = $::nexus::params::install_directory,
  $data_directory    = $::nexus::params::data_directory,
  $tmp_directory     = $::nexus::params::tmp_directory,
) inherits ::nexus::params {

  # contain the class
  case $ensure {
    present: {
      anchor { '::nexus::begin': } ->
      class { '::nexus::user': } ->
      class { '::nexus::package': } ->
      class { '::nexus::files': } ->
      class { '::nexus::config': } ->
      class { '::nexus::service': } ->
      anchor { '::nexus::end': }

      if !empty($plugins) {
        $plugin_classes = regsubst($plugins, '(.*)', '::nexus::plugin::\1')
        class { $plugin_classes:
          before => Class['::nexus::service']
        }
      } else {
        $plugin_classes = []
      }

      if $service_refresh {
        Class['::nexus::package'] ~> Class['::nexus::service']
        Class['::nexus::config'] ~> Class['::nexus::service']
        Class[$plugin_classes] ~> Class['::nexus::service']
      }
    }

    absent: {
      anchor { '::nexus::begin': } ->
      class { '::nexus::service': } ->
      class { '::nexus::files': } ->
      class { '::nexus::package': } ->
      class { '::nexus::user': } ->
      anchor { '::nexus::end': }
    }

    default: {
      fail("Unsupported ensure value ${ensure}")
    }

  }

}
