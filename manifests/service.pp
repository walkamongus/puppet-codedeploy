# == Class codedeploy::service
#
# This class is meant to be called from codedeploy.
# It ensure the service is running.
#
class codedeploy::service {

  service { $::codedeploy::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
