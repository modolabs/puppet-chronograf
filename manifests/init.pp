# Class: chronograf
# ===========================
#
# A class for managing and configuring InfluxDB's Chronograf service
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# The puppet parameter names mirror the names in the chronograf configuration file.
#
# See https://docs.influxdata.com/chronograf/v1.4/administration/config-options/ or or chronograf.conf.erb
# in the templates folder for configuration details
#
# Authors
# -------
#
# Adam Olgin <adam.olgin@modolabs.com>
#
# Copyright
# ---------
#
# Copyright 2018 Modo Labs, Inc., unless otherwise noted.
#
class chronograf (
  String $host                              = '0.0.0.0',
  Integer $port                             = 8888,
  Boolean $reporting_disabled               = false,
  Enum['debug', 'info', 'error'] $log_level = 'info',
  String $status_feed_url                   = 'https://www.influxdata.com/feed/json',
  String $canned_path                       = '/usr/share/chronograf/canned',
  String $bolt_path                         = './chronograf-v1.db',
  String $tls_certificate_path              = undef,
  String $tls_private_key_path              = undef,
  Hash $influx_config                       = {},
  Hash $kapacitor_config                    = {},
  String $public_url                        = 'http://localhost:8888',
  String $token_secret                      = undef,
  Integer $auth_duration                    = 720,
  Optional[String] $google_client_id        = undef,
  Optional[String] $google_client_secret    = undef,
  Optional[Array] $google_domains           = undef,
  Optional[String] $github_client_id        = undef,
  Optional[String] $github_client_secret    = undef,
  Optional[Array] $github_organizations     = undef,
  Optional[String] $heroku_client_id        = undef,
  Optional[String] $heroku_client_secret    = undef,
  Optional[Array] $heroku_organizations     = undef,

  # Service Options
  $version                                  = 'latest',
  $service_name                             = $chronograf::params::service_name,
  $package_name                             = $chronograf::params::package_name,
  $service_ensure                           = $chronograf::params::service_ensure,
  $service_enable                           = $chronograf::params::service_enable,
  $service_restart                          = $chronograf::params::service_restart,

) inherits chronograf::params {
  include chronograf::repo
  include chronograf::install
  include chronograf::config
  include chronograf::service
}
