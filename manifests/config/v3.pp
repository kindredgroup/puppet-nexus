class nexus::config::v3 {

  if $::nexus::javacommand {
    file_line { 'nexus_javacommand':
      path  => '/etc/init.d/nexus',
      line  => "INSTALL4J_JAVA_HOME_OVERRIDE=${::nexus::javacommand}",
      match => '^# INSTALL4J_JAVA_HOME_OVERRIDE=',
    }
  }

  if $::nexus::initmemory {
    file_line { 'nexus_initmemory':
      path  => "${::nexus::install_directory}/nexus/bin/nexus.vmoptions",
      line  => "-Xms${::nexus::initmemory}",
      match => '^-Xms'
    }
  }

  if $::nexus::maxmemory {
    file_line { 'nexus_maxmemory':
      path  => "${::nexus::install_directory}/nexus/bin/nexus.vmoptions",
      line  => "-Xmx${::nexus::maxmemory}",
      match => '^-Xmx'
    }
  }

  file_line { 'nexus_initscript_user':
    path  => '/etc/init.d/nexus',
    line  => "run_as_user=\"${::nexus::params::user}\"",
    match => '^run_as_user='
  }

  file_line { 'nexus_data_directory':
    path  => "${::nexus::install_directory}/nexus/bin/nexus.vmoptions",
    line  => "-Dkaraf.data=${::nexus::data_directory}",
    match => '^-Dkaraf.data=',
  }

  file_line { 'nexus_tmp_directory':
    path  => "${::nexus::install_directory}/nexus/bin/nexus.vmoptions",
    line  => "-Djava.io.tmpdir=${::nexus::tmp_directory}",
    match => '^-Djava.io.tmpdir=',
  }

}
