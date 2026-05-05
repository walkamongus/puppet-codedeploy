require 'spec_helper'

describe 'codedeploy::install' do
  context "on RedHat" do
    let(:facts) do
      {
        os: { 'name' => 'RedHat', 'family' => 'RedHat' },
      }
    end
    let(:pre_condition) { 'include codedeploy' }

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_package('codedeploy-agent').with(
        ensure: 'present',
        provider: 'rpm',
        source: 'https://aws-codedeploy-us-west-1.s3.us-west-1.amazonaws.com/latest/codedeploy-agent.noarch.rpm',
      )
    }
  end

  context "on Ubuntu 24.04" do
    let(:facts) do
      {
        os: { 'name' => 'Ubuntu', 'family' => 'Debian', 'release' => { 'major' => '24' } },
      }
    end
    let(:pre_condition) { 'include codedeploy' }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_package('ruby-full').with_ensure('installed') }
    it { is_expected.not_to contain_exec('patch_codedeploy_deb') }
    it {
      is_expected.to contain_package('codedeploy-agent').with(
        ensure: 'present',
        provider: 'dpkg',
        source: '/tmp/codedeploy-agent.deb',
      )
    }
  end

  context "on Ubuntu 26.04" do
    let(:facts) do
      {
        os: { 'name' => 'Ubuntu', 'family' => 'Debian', 'release' => { 'major' => '26' } },
      }
    end
    let(:pre_condition) { 'include codedeploy' }

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_package('ruby-full').with_ensure('installed') }
    it { is_expected.to contain_exec('patch_codedeploy_deb') }
    it {
      is_expected.to contain_package('codedeploy-agent').with(
        provider: 'dpkg',
        source: '/tmp/codedeploy-agent-patched.deb',
      )
    }
  end

  context "with custom region" do
    let(:facts) do
      {
        os: { 'name' => 'Ubuntu', 'family' => 'Debian', 'release' => { 'major' => '24' } },
      }
    end
    let(:pre_condition) { "class { 'codedeploy': aws_region => 'eu-west-1' }" }

    it {
      is_expected.to contain_archive('/tmp/codedeploy-agent.deb').with(
        source: 'https://aws-codedeploy-eu-west-1.s3.eu-west-1.amazonaws.com/latest/codedeploy-agent_all.deb',
      )
    }
  end

  context "on unsupported OS" do
    let(:facts) do
      {
        os: { 'name' => 'Solaris', 'family' => 'Solaris' },
      }
    end
    let(:pre_condition) { 'include codedeploy' }

    it { is_expected.to compile.and_raise_error(%r{Solaris not supported}) }
  end
end
