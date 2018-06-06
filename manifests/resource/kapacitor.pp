# @summary Kapacitor Resource file setup for Chronograf
# See https://github.com/influxdata/chronograf/issues/2659#issuecomment-354164604 for reference.
#
# Parameters
#   dir_path     - the location to store these resources. Defaults to $::chronograf::canned_path
#   org_id       - the unique id of the organization. Should be a file-name friendly string
#   instance_id  - the unique integer id of this instance. Can be any non-negative integer as long as it is not shared with another resource
#   influx_id    - the unique integer id of the related source (i.e. influx)
#   name         - the full, friendly name of the organization
#   active       - whether this kapacitor resource is active
#   url          - the full url of the kapacitor instance. Include http(s) and port. Defaults to http://localhost:9092
#
# Actions
#
# Requires
#   chronograf
#
# Sample Usage
#   chronograf::resource::kapacitor {
#     instance_id  => 10000,
#     name         => "My Example Kapacitor Instance",
#     active       => true,
#     url          => "https://example.com:9092",
#     org_id       => "example_org"
#   }
define chronograf::resource::kapacitor (
  String $dir_path         = $::chronograf::resource_path,
  Optional[String] $org_id = undef,
  Integer $instance_id     = undef,
  Integer $influx_id       = undef,
  String $instance_name    = undef,
  Boolean $active          = true,
  String $url              = 'http://localhost:9092'
) {
  if ! defined(Class['chronograf']) {
    fail('You must include the chronograf base class before using any defined resources')
  }

  file { "${dir_path}/kapacitor_${instance_id}.kap":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('chronograf/resource/kapacitor.json.erb'),
    notify  => Class['chronograf::service']
  }
}
