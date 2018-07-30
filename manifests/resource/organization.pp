# @summary Organization Resource file setup for Chronograf
# See https://github.com/influxdata/chronograf/issues/2659#issuecomment-354164604 for reference.
#
# Parameters
#   dir_path     - the location to store these resources. Defaults to $::chronograf::canned_path
#   org_id       - the unique id of the organization. Should be a file-name friendly string
#   org_name     - the full, friendly name of the organization
#   default_role - the default role that new users in the org should recieve. One of: admin, editer, viewer, member
#
# Actions
#
# Requires
#   chronograf
#
# Sample Usage
#   chronograf::resource::organization {
#     org_id       => "example_org",
#     org_name     => "My Example Organization",
#     default_role => "editor"
#   }
define chronograf::resource::organization (
  String $dir_path = $::chronograf::resources_path,
  String $org_id   = undef,
  String $org_name = undef,
  Enum['admin', 'editor', 'viewer', 'member'] $default_role = 'viewer'
) {
  if ! defined(Class['chronograf']) {
    fail('You must include the chronograf base class before using any defined resources')
  }

  file { "${dir_path}/${org_id}.org":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('chronograf/resource/organization.json.erb'),
    notify  => Class['chronograf::service']
  }
}
