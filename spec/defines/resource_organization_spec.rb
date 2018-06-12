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
          org_id: "#{title}",
          org_name: 'Example Organizaton',
          default_role: 'viewer'
        }
      end

      let :pre_condition do
        [
          'include ::chronograf'
        ]
      end

      describe 'os-independent items' do
        describe 'basic assumptions' do
          let(:params) { default_params }

          it { is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").that_requires('File[/usr/share/chronograf/resources]') }
          it do
            is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").with(
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
              'ensure'  => 'file',
              'content' => %r{map \$uri \$#{title}}
            )
          end
        end

        describe "#{title} template content" do
          [
            {
              title: 'should set org_id',
              attr: 'organization_id',
              value: 'example_org',
              match: '  hostnames;'
            },
            {
              title: 'should set org_name',
              attr: 'name',
              value: 'Example Organization',
              match: '  Example Organization;'
            },
            {
              title: 'should set default_role',
              attr: 'default_role',
              value: 'viewer'
              match: '  viewer;'
            }
          ].each do |param|
            context "when #{param[:attr]} is #{param[:value]}" do
              let(:params) { default_params.merge(param[:attr].to_sym => param[:value]) }

              it { is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").with_mode('0644') }
              it param[:title] do
                verify_contents(catalogue, "/usr/share/chronograf/resources/#{title}.org", Array(param[:match]))
                Array(param[:notmatch]).each do |item|
                  is_expected.to contain_file("/usr/share/chronograf/resources/#{title}.org").without_content(item)
                end
              end
            end
          end
        end
      end
    end
  end
end
