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

      if versioncmp($::nexus::version, '3.0.0') < 0 or $::nexus::version == 'latest' {
        $logdir = '/opt/sonatype-nexus/nexus/logs'
        file { '/opt/sonatype-nexus/sonatype-work/nexus/plugin-repository':
          ensure  => directory,
          owner   => $::nexus::params::user,
          group   => $::nexus::params::group,
          mode    => '0755',
          replace => false
        }
      } else {
        $logdir = '/opt/sonatype-nexus/nexus/data/log'
      }

      file { $logdir:
        ensure => link,
        target => '/var/log/nexus',
        force  => true
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
