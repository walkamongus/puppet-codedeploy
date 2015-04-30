# == Class codedeploy::install
#
# This class is called from codedeploy for install.
#
class codedeploy::install {

  case $::osfamily {
    'RedHat', 'Amazon': {
      package { $::codedeploy::package_name:
        ensure => present,
        source => $::codedeploy::package_url,
      }
    }
    'Debian': {
      $package_url  = 'https://s3.amazonaws.com/aws-codedeploy-us-east-1/latest/codedeploy-agent_all.deb'
      $package_name = 'codedeploy-agent'
      $service_name = 'codedeploy-agent'
      package { [ 'awscli','ruby2.0' ]:
        ensure => present,
      }
      exec { 'download_codedeploy_installer':
        command => '/usr/bin/aws s3 cp s3://aws-codedeploy-us-east-1/latest/install . --region is-east-1',
        cwd     => '/home/ubuntu',
        creates => '/home/ubuntu/install'
      }
      file { '/home/ubuntu/install':
        ensure    => present,
        owner     => 'root',
        group     => 'root',
        mode      => '0740',
        subscribe => Exec['download_codedeploy_installer'],
        notify    => Exec['install_codedeploy_agent'],
      }
      exec { 'install_codedeploy_agent':
        command     => '/home/ubuntu/install auto',
        cwd         => '/home/ubuntu',
        refreshonly => true,
      }
    }
    'windows': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
