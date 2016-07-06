# == Class: nexus::config
#
# Manages configuration entities
#
class nexus::config {

  file_line { 'nexus_initscript_home':
    path  => '/etc/init.d/nexus',
    line  => 'NEXUS_HOME="/opt/sonatype-nexus/nexus"',
    match => '^NEXUS_HOME='
  }

  if versioncmp($::nexus::version, '3.0.0') < 0 or $::nexus::version == 'latest' {
    $nexus_config_file = '/opt/sonatype-nexus/nexus/conf/nexus.properties'
    if $::nexus::javacommand {
      file_line { 'nexus_javacommand':
        path  => '/opt/sonatype-nexus/nexus/bin/jsw/conf/wrapper.conf',
        line  => "wrapper.java.command=${::nexus::javacommand}",
        match => '^wrapper.java.command='
      }
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
    file_line { 'nexus_initscript_user':
      path  => '/etc/init.d/nexus',
      line  => "RUN_AS_USER=\"${::nexus::params::user}\"",
      match => '^#?RUN_AS_USER='
    }
  } else {
    $nexus_config_file = '/opt/sonatype-nexus/nexus/etc/org.sonatype.nexus.cfg'
    if $::nexus::javacommand {
      file_line { 'nexus_javacommand':
        path  => '/etc/init.d/nexus',
        line  => "INSTALL4J_JAVA_HOME_OVERRIDE=${::nexus::javacommand}",
        match => '^# INSTALL4J_JAVA_HOME_OVERRIDE=',
      }
    }
    if $::nexus::initmemory {
      file_line { 'nexus_initmemory':
        path  => '/opt/sonatype-nexus/nexus/bin/nexus.vmoptions',
        line  => "-Xms${::nexus::initmemory}",
        match => '^-Xms'
      }
    }
    if $::nexus::maxmemory {
      file_line { 'nexus_maxmemory':
        path  => '/opt/sonatype-nexus/nexus/bin/nexus.vmoptions',
        line  => "-Xmx${::nexus::maxmemory}",
        match => '^-Xmx'
      }
    }
    file_line { 'nexus_initscript_user':
      path  => '/etc/init.d/nexus',
      line  => "run_as_user=\"${::nexus::params::user}\"",
      match => '^run_as_user='
    }
  }

  file_line { 'nexus_config_port':
    path  => $nexus_config_file,
    line  => "application-port=${::nexus::port}",
    match => '^application-port'
  }

  if $::nexus::maxpermsize {
    file_line { 'nexus_permgen':
      path  => '/opt/sonatype-nexus/nexus/bin/jsw/conf/wrapper.conf',
      line  => "wrapper.java.additional.1=-XX:MaxPermSize=${::nexus::maxpermsize}",
      match => '^wrapper.java.additional.1=-XX:MaxPermSize='
    }
  }

}
