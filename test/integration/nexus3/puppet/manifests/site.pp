# install java
$java_packages = $::osfamily ? {
  redhat  => 'java-1.8.0-openjdk',
  debian  => ['openjdk-8-jdk', 'openjdk-8-jre']
}
if $::osfamily == 'RedHat' {
  package { 'epel-release': ensure => installed } -> Package[$java_packages]
}
package { $java_packages: ensure => installed }

package { ['tar', 'gzip', 'wget']: ensure => present } ->
class { '::nexus':
  download_url   => 'http://download.sonatype.com/nexus/3/nexus-3.0.1-01-unix.tar.gz',
  version        => '3.0.1-01',
  initmemory     => '512M',
  maxmemory      => '512M',
  data_directory => '/opt/sonatype-nexus/data',
  tmp_directory  => '/opt/sonatype-nexus/data/tmp',
}
