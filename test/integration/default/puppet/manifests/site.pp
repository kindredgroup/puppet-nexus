# install java
$java_packages = $::osfamily ? {
  redhat  => 'java-1.7.0-openjdk',
  debian  => ['openjdk-7-jdk', 'openjdk-7-jre']
}
package { $java_packages: ensure => installed }

# install requirements to maven class
package { ['tar', 'gzip', 'wget']: ensure => present } ->
class { '::nexus': }
class { '::nexus::plugin::yum': }
