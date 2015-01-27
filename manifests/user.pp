# == Class: nexus::user
#
# Manages the Nexus service user
#
class nexus::user {

  if !defined(User[$::nexus::params::user]) and $::nexus::manage_user {
    @user { $::nexus::params::user:
      ensure     => present,
      gid        => $::nexus::params::group,
      home       => "/home/${::nexus::params::user}",
      managehome => true
    }
  }

  if !defined(Group[$::nexus::params::group]) and $::nexus::manage_user {
    @group { $::nexus::params::group:
      ensure => present
    }
  }

  Group <| title == $::nexus::params::group |> ->
  User <| title == $::nexus::params::user |>

}
