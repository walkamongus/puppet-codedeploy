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
  $config_location = $::codedeploy::params::config_location,
  $log_aws_wire = $::codedeploy::params::log_aws_wire,
  $log_dir = $::codedeploy::params::log_dir,
  $pid_dir = $::codedeploy::params::pid_dir,
  $program_name = $::codedeploy::params::program_name,
  $root_dir = $::codedeploy::params::root_dir,
  $verbose = $::codedeploy::params::verbose,
  $wait_between_runs = $::codedeploy::params::wait_between_runs,
  $max_revisions = $::codedeploy::params::max_revisions,
  $proxy_uri = '',
) inherits ::codedeploy::params {

  # validate parameters here

  class { '::codedeploy::install': } ->
  class { '::codedeploy::config': } ->
  class { '::codedeploy::service': } ->
  Class['::codedeploy']
}
