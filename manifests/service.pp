# == Class: nexus::service
#
# Manages the Nexus daemon
#
class nexus::service {

  service { 'nexus':
    ensure => $::nexus::service_ensure,
    enable => $::nexus::service_enable
  }

}
