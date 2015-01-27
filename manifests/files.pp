# == Class: nexus::files
#
# Manages directories
#
class nexus::files {

  case $::nexus::ensure {
    present: {
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

      file { '/opt/sonatype-nexus/sonatype-work/nexus/plugin-repository':
        ensure  => directory,
        owner   => $::nexus::params::user,
        group   => $::nexus::params::group,
        mode    => '0755',
        replace => false
      }
    }

    absent: {
      file { '/var/log/nexus':
        ensure  => absent,
        purge   => true,
        force   => true,
        recurse => true
      }
    }

    default: {}
  }

}
