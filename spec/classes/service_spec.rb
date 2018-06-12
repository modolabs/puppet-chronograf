require 'spec_helper'

describe 'chronograf::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let :pre_condition do
        [
          'include ::chronograf::params',
        ]
      end

      it { is_expected.to compile }
    end
  end
end
