# == Class: nexus::package
#
# Installs Nexus
# Should be replaced with RPM
#
class nexus::package {

  case $::nexus::ensure {
    present: {
      case $::nexus::version {
        latest: {
          $url = regsubst($::nexus::download_url, '__VERSION__', 'latest')
          $command = "wget --no-check-certificate -O - ${url} | tar zxf - && ln -s ${::nexus::install_directory}/$(ls -d nexus-*|tail -1) ${::nexus::install_directory}/nexus"
          $creates = "${::nexus::install_directory}/nexus"
        }
        /^[0-9]+[0-9\.]+/: {
          $url = regsubst($::nexus::download_url, '__VERSION__', $::nexus::version)
          $command = "wget --no-check-certificate -O - ${url} | tar zxf - && rm -f ${::nexus::install_directory}/nexus && ln -s ${::nexus::install_directory}/nexus-${::nexus::version} ${::nexus::install_directory}/nexus"
          $creates = "${::nexus::install_directory}/nexus-${::nexus::version}"
        }
        default: {
          fail("Could not parse version ${::nexus::version}")
        }
      }

      exec { 'install_nexus':
        command => $command,
        cwd     => $::nexus::install_directory,
        path    => ['/bin', '/usr/bin'],
        creates => $creates,
        require => File[$::nexus::install_directory],
      } ~>
      exec { 'set_nexus_permissions':
        command     => "chown -R ${::nexus::params::user}:${::nexus::params::group} ${::nexus::install_directory}",
        path        => ['/bin', '/usr/bin'],
        refreshonly => true
      }

      file { '/etc/init.d/nexus':
        ensure  => link,
        target  => "${::nexus::install_directory}/nexus/bin/nexus",
        require => Exec['install_nexus']
      }

      file { $::nexus::install_directory:
        ensure => directory,
        owner  => $::nexus::params::user,
        group  => $::nexus::params::group,
        mode   => '0755'
      }
    }

    absent: {
      file { '/etc/init.d/nexus':
        ensure  => absent
      }

      file { $::nexus::install_directory:
        ensure  => absent,
        force   => true,
        purge   => true,
        recurse => true
      }
    }

    default: {}

  }

}
