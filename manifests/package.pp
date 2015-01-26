# == Class: nexus::package
#
# Installs Nexus
# Should be replaced with RPM
#
class nexus::package {

  file { '/opt/sonatype-nexus':
    ensure => directory,
    owner  => $::nexus::params::user,
    group  => $::nexus::params::group,
    mode   => '0755'
  }

  case $::nexus::version {
    latest: {
      $url = regsubst($::nexus::params::download_url, '__VERSION__', 'latest')
      $command = "wget --no-check-certificate -O - ${url} | tar zxf - && ln -s /opt/sonatype-nexus/$(ls -d nexus-*|tail -1) /opt/sonatype-nexus/nexus"
    }
    /^[0-9]+[0-9\.]+/: {
      $url = regsubst($::nexus::params::download_url, '__VERSION__', $::nexus::version)
      $command = "wget --no-check-certificate -O - ${url} | tar zxf - && ln -s /opt/sonatype-nexus/nexus-${::ensure} /opt/sonatype-nexus/nexus"
    }
    default: {
      fail("Could not parse version ${::nexus::version}")
    }
  }

  exec { 'install_nexus':
    command => $command,
    cwd     => '/opt/sonatype-nexus',
    path    => ['/bin', '/usr/bin'],
    creates => '/opt/sonatype-nexus/nexus',
    require => File['/opt/sonatype-nexus']
  } ~>
  exec { 'set_nexus_permissions':
    command     => "chown -R ${::nexus::params::user}:${::nexus::params::group} /opt/sonatype-nexus",
    path        => ['/bin', '/usr/bin'],
    refreshonly => true
  }

  file { '/etc/init.d/nexus':
    ensure  => link,
    target  => '/opt/sonatype-nexus/nexus/bin/nexus',
    require => Exec['install_nexus']
  }

}
