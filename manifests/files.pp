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
        $logdir = "${::nexus::install_directory}/nexus/logs"
        file { "${::nexus::install_directory}/sonatype-work/nexus/plugin-repository":
          ensure  => directory,
          owner   => $::nexus::params::user,
          group   => $::nexus::params::group,
          mode    => '0755',
          replace => false
        }
      } else {
        $logdir = "${::nexus::data_directory}/log"
      }

      file { $logdir:
        ensure => link,
        target => '/var/log/nexus',
        force  => true
      }

      file { $::nexus::data_directory:
        ensure => directory,
        owner  => $::nexus::params::user,
        group  => $::nexus::params::group,
        mode   => '0755',
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
