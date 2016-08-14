# == Class codedeploy::config
#
# This class is called from codedeploy for install.
#
class codedeploy::config {
  case $::osfamily {
    'RedHat', 'Amazon', 'Debian': {
      file {
        $::codedeploy::config_location:
          ensure  => file,
          content => template('codedeploy/codedeployagent.yml.erb'),
          mode    => '0644',
          owner   => root,
          group   => root,
          notify  => Service[$::codedeploy::service_name];
      }
    }
    default: {
    }
  }
}
