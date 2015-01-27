# == Class: nexus::service
#
# Manages the Nexus daemon
#
class nexus::service {

  case $::nexus::ensure {
    present: {
      $service_ensure = $::nexus::service_ensure
      $service_enable = $::nexus::service_enable
    }
    absent: {
      $service_ensure = 'stopped'
      $service_enable = false
    }
    default: {}
  }

  service { 'nexus':
    ensure => $service_ensure,
    enable => $service_enable
  }

}
