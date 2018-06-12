require 'spec_helper'

describe 'chronograf::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'os-independent items' do
        describe 'basic assumptions' do
          it do
            is_expected.to contain_file('/etc/default/chronograf').with(
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
              'ensure'  => 'present',
            ).that_notifies(['Class[chronograf::service]'])
          end
        end
      end

      it { is_expected.to compile }
    end
  end
end
