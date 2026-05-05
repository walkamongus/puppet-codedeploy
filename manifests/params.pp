# @summary Default parameters for the CodeDeploy module.
class codedeploy::params {
  case $facts['os']['name'] {
    'Debian', 'Ubuntu': {
      $package_name    = 'codedeploy-agent'
      $service_name    = 'codedeploy-agent'
      $config_location = '/etc/codedeploy-agent/conf/codedeployagent.yml'
      $log_dir         = '/var/log/aws/codedeploy-agent/'
      $pid_dir         = '/opt/codedeploy-agent/state/.pid/'
      $program_name    = 'codedeploy-agent'
      $root_dir        = '/opt/codedeploy-agent/deployment-root'
      $verbose         = false
    }
    'RedHat', 'Amazon': {
      $package_name    = 'codedeploy-agent'
      $service_name    = 'codedeploy-agent'
      $config_location = '/etc/codedeploy-agent/conf/codedeployagent.yml'
      $log_dir         = '/var/log/aws/codedeploy-agent/'
      $pid_dir         = '/opt/codedeploy-agent/state/.pid/'
      $program_name    = 'codedeploy-agent'
      $root_dir        = '/opt/codedeploy-agent/deployment-root'
      $verbose         = false
    }
    default: {
      fail("${facts['os']['name']} not supported")
    }
  }

  $log_aws_wire      = false
  $wait_between_runs = 1
  $max_revisions     = 5
  $aws_region        = 'us-west-1'
}
