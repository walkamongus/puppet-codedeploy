# == Class: codedeploy
#
# Full description of class codedeploy here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class codedeploy (
  $package_url  = $::codedeploy::params::package_url,
  $package_name = $::codedeploy::params::package_name,
  $service_name = $::codedeploy::params::service_name,
) inherits ::codedeploy::params {

  # validate parameters here

  class { '::codedeploy::install': } ->
  class { '::codedeploy::service': } ->
  Class['::codedeploy']
}
