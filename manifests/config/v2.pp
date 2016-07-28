class nexus::config::v2 {

  if $::nexus::javacommand {
    file_line { 'nexus_javacommand':
      path  => "${::nexus::install_directory}/nexus/bin/jsw/conf/wrapper.conf",
      line  => "wrapper.java.command=${::nexus::javacommand}",
      match => '^wrapper.java.command='
    }
  }

  if $::nexus::initmemory {
    file_line { 'nexus_initmemory':
      path  => "${::nexus::install_directory}/nexus/bin/jsw/conf/wrapper.conf",
      line  => "wrapper.java.initmemory=${::nexus::initmemory}",
      match => '^wrapper.java.initmemory='
    }
  }

  if $::nexus::maxmemory {
    file_line { 'nexus_maxmemory':
      path  => "${::nexus::install_directory}/nexus/bin/jsw/conf/wrapper.conf",
      line  => "wrapper.java.maxmemory=${::nexus::maxmemory}",
      match => '^wrapper.java.maxmemory='
    }
  }

  file_line { 'nexus_initscript_user':
    path  => '/etc/init.d/nexus',
    line  => "RUN_AS_USER=\"${::nexus::params::user}\"",
    match => '^#?RUN_AS_USER='
  }

  if $::nexus::maxpermsize {
    file_line { 'nexus_permgen':
      path  => "${::nexus::install_directory}/nexus/bin/jsw/conf/wrapper.conf",
      line  => "wrapper.java.additional.1=-XX:MaxPermSize=${::nexus::maxpermsize}",
      match => '^wrapper.java.additional.1=-XX:MaxPermSize='
    }
  }

}
