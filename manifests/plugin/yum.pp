# == Class: nexus::plugin::yum
#
# Installs the Nexus yum repository plugin
#
# === Parameters:
#
# [*version*]
#   Version of the plugin to be installed
#
class nexus::plugin::yum (
  $version = $::nexus::version
) inherits ::nexus::params {

  warning('This module is deprecated, yum is provided by default in recent versions of nexus 2.x')

}
