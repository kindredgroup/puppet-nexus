class nexus::user {

  user { $::nexus::params::user:
    ensure     => present,
    gid        => $::nexus::params::group,
    home       => "/home/${::nexus::params::user}",
    managehome => true
  }

  group { $::nexus::params::group:
    ensure => present
  }

}
