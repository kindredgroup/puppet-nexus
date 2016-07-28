# == Class: nexus::config
#
# Manages Nexus configuration settings
#
class nexus::config {

  #
  # Nexus 2.x config
  #
  if versioncmp($::nexus::version, '3.0.0') < 0 or $::nexus::version == 'latest' {
    $nexus_config_file = "${::nexus::install_directory}/nexus/conf/nexus.properties"
    contain ::nexus::config::v2
  }

  #
  # Nexus 3.x config
  #
  else {
    $nexus_config_file = "${::nexus::install_directory}/nexus/etc/org.sonatype.nexus.cfg"
    contain ::nexus::config::v3
  }

  #
  # Generic config
  #
  file_line { 'nexus_config_port':
    path  => $nexus_config_file,
    line  => "application-port=${::nexus::port}",
    match => '^application-port'
  }

  file_line { 'nexus_initscript_home':
    path  => '/etc/init.d/nexus',
    line  => "NEXUS_HOME=\"${::nexus::install_directory}/nexus\"",
    match => '^NEXUS_HOME='
  }

  if $::osfamily == 'RedHat' and versioncmp($::operatingsystemmajrelease, '7') >= 0 {
    file { '/etc/systemd/system/nexus.service':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/${module_name}/nexus.service",
    }
  }

}
