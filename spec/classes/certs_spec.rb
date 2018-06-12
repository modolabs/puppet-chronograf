require 'spec_helper'

describe 'chronograf::certs' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          cert_name: 'example_cert',
          cert: 'example_cert_content',
          cert_key: 'example_key',
        }
      end

      describe 'os-independent items' do
        describe 'basic assumptions' do
          it do
            is_expected.to contain_file('/etc/pki/tls/certs/example_cert').with(
              'ensure'  => 'present',
              'owner'   => 'chronograf',
              'group'   => 'chronograf',
              'mode'    => '0644',
            )
            is_expected.to contain_file('/etc/pki/tls/private/example_cert.key').with(
              'ensure'  => 'present',
              'owner'   => 'chronograf',
              'group'   => 'chronograf',
              'mode'    => '0600',
            )
          end
        end
      end

      it { is_expected.to compile }
    end
  end
end
