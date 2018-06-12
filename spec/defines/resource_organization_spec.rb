require 'spec_helper'

describe 'chronograf::resource::organization' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let :title do
        'example_org'
      end

      let :default_params do
        {
          dir_path: '/usr/share/chronograf/resources',
          org_id: title.to_s,
          org_name: 'Example Organizaton',
          default_role: 'viewer',
        }
      end

      let :pre_condition do
        [
          'include ::chronograf',
        ]
      end

      describe 'os-independent items' do
        describe 'basic assumptions' do
          let(:params) { default_params }

          it { is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org") }
          it do
            is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").with(
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
              'ensure'  => 'present',
              'content' => "{\n  \"id\": \"#{title}\",\n  \"name\": \"Example Organizaton\",\n  \"defaultRole\": \"viewer\"\n}\n",
            ).that_notifies(['Class[chronograf::service]'])
          end
        end

        # describe 'organization template content' do
        #   [
        #     {
        #       title: 'should set id',
        #       attr: 'org_id',
        #       value: 'example_org',
        #       match: 'example_org',
        #     },
        #     {
        #       title: 'should set name',
        #       attr: 'org_name',
        #       value: 'Example Organization',
        #       match: 'Example Organization',
        #     },
        #     {
        #       title: 'should set defaultRole',
        #       attr: 'default_role',
        #       value: 'viewer',
        #       match: 'viewer',
        #     },
        #   ].each do |param|
        #     context "when #{param[:attr]} is #{param[:value]}" do
        #       let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

        #       it { is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").with_mode('0644') }
        #       it param[:title] do
        #         verify_contents(catalogue, "/usr/share/chronograf/resources/#{title}.org", Array(param[:match]))
        #         Array(param[:notmatch]).each do |item|
        #           is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").without_content(item)
        #         end
        #       end
        #     end
        #   end
        # end
      end
    end
  end
end
