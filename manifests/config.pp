# == Class: nexus::config
#
# Manages configuration entities
#
class nexus::config {

  file_line { 'nexus_initscript_user':
    path  => '/etc/init.d/nexus',
    line  => "RUN_AS_USER=\"${::nexus::params::user}\"",
    match => '^#?RUN_AS_USER='
  }

  file_line { 'nexus_initscript_home':
    path  => '/etc/init.d/nexus',
    line  => 'NEXUS_HOME="/opt/sonatype-nexus/nexus"',
    match => '^NEXUS_HOME='
  }

  file_line { 'nexus_config_port':
    path  => '/opt/sonatype-nexus/nexus/conf/nexus.properties',
    line  => "application-port=${::nexus::port}",
    match => '^application-port'
  }

}
