require 'spec_helper'

describe 'codedeploy::service' do
  context "on Ubuntu" do
    let(:facts) do
      {
        os: { 'name' => 'Ubuntu', 'family' => 'Debian', 'release' => { 'major' => '24' } },
      }
    end
    let(:pre_condition) { 'include codedeploy' }

    it { is_expected.to compile.with_all_deps }
    it {
      is_expected.to contain_service('codedeploy-agent').with(
        ensure: 'running',
        enable: true,
      )
    }
  end
end
