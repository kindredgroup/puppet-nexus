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

  if $::nexus::initmemory {
    file_line { 'nexus_initmemory':
      path  => '/opt/sonatype-nexus/nexus/bin/jsw/conf/wrapper.conf',
      line  => "wrapper.java.initmemory=${::nexus::initmemory}",
      match => '^wrapper.java.initmemory='
    }
  }

  if $::nexus::maxmemory {
    file_line { 'nexus_maxmemory':
      path  => '/opt/sonatype-nexus/nexus/bin/jsw/conf/wrapper.conf',
      line  => "wrapper.java.maxmemory=${::nexus::maxmemory}",
      match => '^wrapper.java.maxmemory='
    }
  }

  if $::nexus::maxpermsize {
    file_line { 'nexus_permgen':
      path  => '/opt/sonatype-nexus/nexus/bin/jsw/conf/wrapper.conf',
      line  => "wrapper.java.additional.1=-XX:MaxPermSize=${::nexus::maxpermsize}",
      match => '^wrapper.java.additional.1=-XX:MaxPermSize='
    }
  }

  if $::nexus::javacommand {
    file_line { 'nexus_javacommand':
      path  => '/opt/sonatype-nexus/nexus/bin/jsw/conf/wrapper.conf',
      line  => "wrapper.java.command=${::nexus::javacommand}",
      match => '^wrapper.java.command='
    }
  }

}
