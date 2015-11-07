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
    }
    'RedHat', 'Amazon': {
      $package_url  = 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent.noarch.rpm'
      $package_name = 'codedeploy-agent'
      $service_name = 'codedeploy-agent'
    }
    'Windows': {
      $package_url  = 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent.msi'
      $package_name = 'codedeployagent'
      $service_name = 'codedeployagent'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
