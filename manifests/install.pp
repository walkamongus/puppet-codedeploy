# @summary Installs the AWS CodeDeploy agent.
class codedeploy::install {
  case $facts['os']['name'] {
    'RedHat', 'Amazon': {
      $region = $codedeploy::aws_region
      package { $codedeploy::package_name:
        ensure   => present,
        provider => 'rpm',
        source   => "https://aws-codedeploy-${region}.s3.${region}.amazonaws.com/latest/codedeploy-agent.noarch.rpm",
      }
    }
    'Debian', 'Ubuntu': {
      ensure_packages(['ruby-full'], { 'ensure' => 'present' })

      $region  = $codedeploy::aws_region
      $deb_url = "https://aws-codedeploy-${region}.s3.${region}.amazonaws.com/latest/codedeploy-agent_all.deb"

      archive { '/tmp/codedeploy-agent.deb':
        source  => $deb_url,
        creates => '/tmp/codedeploy-agent.deb',
      }
      # The upstream .deb only lists ruby <= 3.2 in Depends, but the agent
      # is verified compatible with Ruby 3.3. Patch the control file to add
      # ruby3.3 as an alternative so dpkg/apt are satisfied natively.
      # Only needed on OS versions that ship Ruby 3.3+ (Ubuntu 26.04+).
      if $facts['os']['name'] == 'Ubuntu' and versioncmp($facts['os']['release']['major'], '26') >= 0 {
        file { '/tmp/patch_codedeploy_deb.sh':
          ensure => file,
          source => 'puppet:///modules/codedeploy/patch_codedeploy_deb.sh',
          mode   => '0755',
        }
        exec { 'patch_codedeploy_deb':
          command => '/tmp/patch_codedeploy_deb.sh',
          unless  => '/usr/bin/dpkg-deb -I /tmp/codedeploy-agent.deb | /usr/bin/grep -q ruby3.3',
          require => [Archive['/tmp/codedeploy-agent.deb'], File['/tmp/patch_codedeploy_deb.sh']],
          path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
        }
        package { $codedeploy::package_name:
          ensure   => present,
          provider => 'dpkg',
          source   => '/tmp/codedeploy-agent-patched.deb',
          require  => [Exec['patch_codedeploy_deb'], Package['ruby-full']],
        }
      } else {
        package { $codedeploy::package_name:
          ensure   => present,
          provider => 'dpkg',
          source   => '/tmp/codedeploy-agent.deb',
          require  => [Archive['/tmp/codedeploy-agent.deb'], Package['ruby-full']],
        }
      }
    }
    default: {
      fail("${facts['os']['name']} not supported")
    }
  }
}
