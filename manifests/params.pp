# == Class: nexus::params
#
# Centralized configuration parameters
#
class nexus::params {

  $download_url = 'http://download.sonatype.com/nexus/oss/nexus-__VERSION__-bundle.tar.gz'
  $user = 'nexus'
  $group = 'nexus'
  $install_directory = '/opt/sonatype-nexus'
  $data_directory = '/opt/sonatype-nexus/nexus/data'
  $tmp_directory = '/opt/sonatype-nexus/nexus/data/tmp'

}
