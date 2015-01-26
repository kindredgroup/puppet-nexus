# == Class: nexus
#
# Full description of class nexus here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { nexus:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class nexus ( 
  $ensure          = 'present',
  $version         = 'latest',
  $service_ensure  = 'running',
  $service_enable  = true,
  $service_refresh = true,
  $port            = 8080
) inherits ::nexus::params {

  # contain the class
  anchor { '::nexus::begin': } ->
  class { '::nexus::user': } ->
  class { '::nexus::package': } ->
  class { '::nexus::config': } ->
  class { '::nexus::service': } ->
  anchor { '::nexus::end': }

  if $service_refresh {
    Class['::nexus::package'] ~> Class['::nexus::service']
    Class['::nexus::config'] ~> Class['::nexus::service']
  }

}
