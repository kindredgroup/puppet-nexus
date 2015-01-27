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

  if !defined(Package['createrepo']) {
    package { 'createrepo':
      ensure => present
    }
  }

  exec { 'install_yum':
    command => "wget http://search.maven.org/remotecontent?filepath=org/sonatype/nexus/plugins/nexus-yum-repository-plugin/${version}/nexus-yum-repository-plugin-${version}.jar",
    path    => ['/bin', '/usr/bin'],
    cwd     => '/opt/sonatype-nexus/sonatype-work/nexus/plugin-repository',
    creates => "/opt/sonatype-nexus/sonatype-work/nexus/plugin-repository/nexus-yum-repository-plugin-${version}.jar"
  }

  file { '/opt/sonatype-nexus/nexus/conf/yum.xml':
    ensure  => file,
    owner   => $::nexus::params::user,
    group   => $::nexus::params::group,
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/yum.xml",
    replace => false
  }

}
