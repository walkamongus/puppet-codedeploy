require 'spec_helper'

describe 'codedeploy' do
  context "on Ubuntu" do
    let(:facts) do
      {
        os: { 'name' => 'Ubuntu', 'family' => 'Debian', 'release' => { 'major' => '24' } },
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('codedeploy::params') }
    it { is_expected.to contain_class('codedeploy::install').that_comes_before('Class[codedeploy::config]') }
    it { is_expected.to contain_class('codedeploy::config').that_notifies('Class[codedeploy::service]') }
    it { is_expected.to contain_class('codedeploy::service') }
  end

  context "on RedHat" do
    let(:facts) do
      {
        os: { 'name' => 'RedHat', 'family' => 'RedHat' },
      }
    end

    it { is_expected.to compile.with_all_deps }
  end

  context "with custom parameters" do
    let(:facts) do
      {
        os: { 'name' => 'Ubuntu', 'family' => 'Debian', 'release' => { 'major' => '24' } },
      }
    end
    let(:params) { { aws_region: 'ap-southeast-1' } }

    it { is_expected.to compile.with_all_deps }
  end

  context "unsupported OS" do
    let(:facts) do
      {
        os: { 'name' => 'Solaris', 'family' => 'Solaris' },
      }
    end

    it { is_expected.to compile.and_raise_error(%r{Solaris not supported}) }
  end
end
