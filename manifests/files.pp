# == Class: nexus::files
#
# Manages directories
#
class nexus::files {

  file { '/var/log/nexus':
    ensure => directory,
    owner  => $::nexus::params::user,
    group  => $::nexus::params::group,
    mode   => '0755'
  }

  file { '/opt/sonatype-nexus/nexus/log':
    ensure => link,
    target => '/var/log/nexus'
  }

}
