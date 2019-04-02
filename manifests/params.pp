# == Class codedeploy::params
#
# This class is meant to be called from codedeploy.
# It sets variables according to platform.
#
class codedeploy::params {
  case $::osfamily {
    'Debian': {
      $package_url  = 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent_all.deb'
      $package_name = 'codedeploy-agent'
      $service_name = 'codedeploy-agent'
      $config_location = '/etc/codedeploy-agent/conf/codedeployagent.yml'
      $log_dir = '/var/log/aws/codedeploy-agent/'
      $pid_dir = '/opt/codedeploy-agent/state/.pid/'
      $program_name = 'codedeploy-agent'
      $root_dir = '/opt/codedeploy-agent/deployment-root'
      $verbose = false
    }
    'RedHat', 'Amazon': {
      $package_url  = 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent.noarch.rpm'
      $package_name = 'codedeploy-agent'
      $service_name = 'codedeploy-agent'
      $config_location = '/etc/codedeploy-agent/conf/codedeployagent.yml'
      $log_dir = '/var/log/aws/codedeploy-agent/'
      $pid_dir = '/opt/codedeploy-agent/state/.pid/'
      $program_name = 'codedeploy-agent'
      $root_dir = '/opt/codedeploy-agent/deployment-root'
      $verbose = false
    }
    'Windows': {
      $package_url  = 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent.msi'
      $package_name = 'codedeployagent'
      $service_name = 'codedeployagent'
      $config_location = 'C:\ProgramData\Amazon\CodeDeploy\conf.yml'
      $log_dir = 'C:\ProgramData\Amazon\CodeDeploy\log'
      $pid_dir = undef
      $program_name = undef
      $root_dir = 'C:\ProgramData\Amazon\CodeDeploy'
      $verbose = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  $log_aws_wire = false
  $wait_between_runs = 1
  $max_revisions = 5

}
