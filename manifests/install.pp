# == Class codedeploy::install
#
# This class is called from codedeploy for install.
#
class codedeploy::install {

  package { $::codedeploy::package_name:
    ensure => present,
    source => $::codedeploy::package_url,
  }
}
