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
        end
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
