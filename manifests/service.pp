# @summary Ensures the CodeDeploy agent service is running.
class codedeploy::service {
  service { $codedeploy::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
