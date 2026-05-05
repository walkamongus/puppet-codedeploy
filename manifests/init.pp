# @summary Installs and configures the AWS CodeDeploy agent.
#
# @param package_name Name of the codedeploy-agent package.
# @param service_name Name of the codedeploy-agent service.
# @param config_location Path to the agent configuration file.
# @param log_aws_wire Enable AWS wire logging.
# @param log_dir Directory for agent logs.
# @param pid_dir Directory for agent PID files.
# @param program_name Program name for the agent.
# @param root_dir Root directory for deployments.
# @param verbose Enable verbose logging.
# @param wait_between_runs Seconds between agent polling runs.
# @param max_revisions Maximum number of deployment revisions to retain.
# @param aws_region AWS region for the CodeDeploy S3 bucket.
class codedeploy (
  String $package_name    = $codedeploy::params::package_name,
  String $service_name    = $codedeploy::params::service_name,
  String $config_location = $codedeploy::params::config_location,
  Boolean $log_aws_wire   = $codedeploy::params::log_aws_wire,
  String $log_dir         = $codedeploy::params::log_dir,
  Optional[String] $pid_dir = $codedeploy::params::pid_dir,
  Optional[String] $program_name = $codedeploy::params::program_name,
  String $root_dir        = $codedeploy::params::root_dir,
  Boolean $verbose        = $codedeploy::params::verbose,
  Integer $wait_between_runs = $codedeploy::params::wait_between_runs,
  Integer $max_revisions  = $codedeploy::params::max_revisions,
  String $aws_region      = $codedeploy::params::aws_region,
) inherits codedeploy::params {
  class { 'codedeploy::install': }
  -> class { 'codedeploy::config': }
  ~> class { 'codedeploy::service': }
  -> Class['codedeploy']
}
