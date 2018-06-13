# @summary InfluxDB Resource file setup for Chronograf
# See https://github.com/influxdata/chronograf/issues/2659#issuecomment-354164604 for reference
#
# Parameters
#   dir_path     - the location to store these resources. Defaults to $::chronograf::canned_path
#   org_id       - the unique id of the organization. Should be a file-name friendly string
#   instance_id  - the unique integer id of this instance. Can be any non-negative integer as long as it is not shared with another resource
#   name         - the full, friendly name of the organization
#   username     - username for influx user
#   password     - password for influx user
#   influx_type  - the type of influx instance. One of: influx, influx-enterprise. Defaults to: influx
#   org_default  - is this the org default influx db?
#   url          - the full url of the influx instance. Include http(s) and port. Defaults to http://localhost:8086
#   telegraf_db  - the name of the telegraf db on the influx server
#   insecure_default_verify - Set to true if you are using a self signed ssl cert on your InfluxDB server.
#
# Actions
#
# Requires
#   chronograf
#
# Sample Usage
#   chronograf::resource::influxdb {
#     instance_id  => 10000,
#     name         => "My Example InfluxDB Instance",
#     type         => "influx",
#     url          => "https://example.com:8086",
#     org_default  => true,
#     telegraf_db  => "telegraf",
#     org_id       => "example_org"
#   }
define chronograf::resource::influxdb (
  String $dir_path              = $::chronograf::resource_path,
  Optional[String] $org_id      = undef,
  Integer $instance_id          = undef,
  Optional[String] $username    = undef,
  Optional[String] $password    = undef,
  Boolean $org_default          = true,
  String $instance_name         = undef,
  String $telegraf_db           = 'telegraf',
  String $url                   = 'http://localhost:8086',
  Boolean $insecure_skip_verify = false,
  Enum['influx', 'influx-enterprise'] $influx_type = 'influx',
) {
  if ! defined(Class['chronograf']) {
    fail('You must include the chronograf base class before using any defined resources')
  }

  file { "${dir_path}/influx_${instance_id}.src":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('chronograf/resource/influxdb.json.erb'),
    notify  => Class['chronograf::service']
  }
}
