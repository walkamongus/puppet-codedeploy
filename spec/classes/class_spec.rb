require 'spec_helper'

describe 'codedeploy' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "codedeploy class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('codedeploy::params') }
          it { is_expected.to contain_class('codedeploy::install').that_comes_before('codedeploy::service') }
          it { is_expected.to contain_class('codedeploy::service').that_requires('codedeploy::install') }

          it { is_expected.to contain_service('codedeploy-agent') }
        end
      end
    end
    context "on redhat-x86_64" do
      let(:facts) do
        {
          :osfamily        => 'RedHat',
          :operatingsystem => 'RedHat',
        }
      end

      context "codedeploy class without any parameters" do
        let(:params) {{ }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_package('codedeploy-agent').with_ensure('present') }
      end
    end
    context "on debian-x86_64" do
      let(:facts) do
        {
          :osfamily        => 'Debian',
          :operatingsystem => 'Debian',
        }
      end

      context "codedeploy class without any parameters" do
        let(:params) {{ }}

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_exec('download_codedeploy_installer').with_command('/usr/bin/aws s3 cp s3://aws-codedeploy-us-east-1/latest/install . --region us-east-1') }
        it { is_expected.to contain_exec('install_codedeploy_agent').with_command('/home/ubuntu/install auto') }
        it { is_expected.to contain_file('/home/ubuntu/install').with({'mode' => '0740'}) }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'codedeploy class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('codedeploy') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
