class nexus::plugin::yum ( 
  $version = $::nexus::version
) {

  require ::nexus

  if !defined(Package['createrepo']) {
    package { 'createrepo':
      ensure => present
    }
  }

  exec { 'install_yum':
    command => "wget http://search.maven.org/remotecontent?filepath=org/sonatype/nexus/plugins/nexus-yum-repository-plugin/${version}/nexus-yum-repository-plugin-${version}.jar",
    path    => ['/bin', '/usr/bin'],
    cwd     => '/opt/sonatype-nexus/sonatype-work/nexus/plugin-repository',
    creates => "/opt/sonatype-nexus/sonatype-work/nexus/plugin-repository/nexus-yum-repository-plugin-${version}.jar",
    notify  => Class['::nexus::service']
  }

  file { '/opt/sonatype-nexus/nexus/conf/yum.xml':
    ensure  => file,
    owner   => $::nexus::params::user,
    group   => $::nexus::params::group,
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/yum.xml",
    replace => false,
    notify  => Class['::nexus::service']
  }

}
