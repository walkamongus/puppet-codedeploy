require 'spec_helper'

describe 'codedeploy' do
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
   context "on windows-x86_64" do
    let(:facts) do
      {
        :osfamily        => 'Windows',
        :operatingsystem => 'Windows',
      }
    end

    context "codedeploy class without any parameters" do
      let(:params) {{ }}

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_package('codedeployagent').with_ensure('present') }
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
      it { is_expected.to contain_exec('install_codedeploy_agent').with_command('/tmp/install auto') }
      it { is_expected.to contain_file('/tmp/install').with({'mode' => '0740'}) }
      it { is_expected.to contain_package('awscli').with({'ensure' => 'present'}) }
    end
  end
end
