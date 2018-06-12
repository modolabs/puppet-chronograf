require 'spec_helper'

describe 'chronograf::resource::kapacitor' do
  let(:title) { 'example_kapacitor' }
  let(:params) do
    {
      dir_path: '/usr/share/chronograf/resources',
      org_id: 'example_org',
      instance_id: 10_000,
      influx_id: 10_001,
      instance_name: title.to_s,
      active: true,
      url: 'http://localhost:9092',
    }
  end

  let :pre_condition do
    [
      'include ::chronograf',
    ]
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'os-independent items' do
        describe 'basic assumptions' do
          it do
            is_expected.to contain_file('/usr/share/chronograf/resources/kapacitor_example_kapacitor.kap').with(
              'ensure'  => 'present',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
            )
          end
        end
      end
      it { is_expected.to compile }
    end
  end
end
