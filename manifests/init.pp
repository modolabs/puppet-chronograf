# Class: chronograf
# ===========================
#
# A class for managing and configuring InfluxDB's Chronograf service
#
# Parameters
# ----------
#
# Most of the puppet parameter names mirror the names in the chronograf configuration file.
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

  # Resources
  Optional[String] $bolt_path               = undef, #'/var/lib/chronogaf/chronogaf-v1.db', # './chronograf-v1.db',
  String $canned_path                       = '/usr/share/chronograf/canned',
  String $resource_path                     = '/usr/share/chronograf/resources',
  Optional[Hash] $influxdb_instances        = {},
  Optional[Hash] $kapacitor_instances       = {},
  Optional[Hash] $organizations             = {},

  # SSL
  Optional[String] $tls_certificate_path    = undef,
  Optional[String] $tls_private_key_path    = undef,

  # General Authentication
  Optional[String] $public_url              = 'http://localhost:8888',
  Optional[String] $token_secret            = undef,
  Optional[Integer] $auth_duration          = 720,

  # Google Auth
  Optional[String] $google_client_id        = undef,
  Optional[String] $google_client_secret    = undef,
  Optional[String] $google_domains          = undef,

  # Github Auth
  Optional[String] $github_client_id        = undef,
  Optional[String] $github_client_secret    = undef,
  Optional[Array] $github_organizations     = undef,

  # Heroku Auth
  Optional[String] $heroku_client_id        = undef,
  Optional[String] $heroku_client_secret    = undef,
  Optional[Array] $heroku_organizations     = undef,

  # Service Options
  String $version                           = 'latest',
  Boolean $service_manage                   = $chronograf::params::service_manage,
  String $service_name                      = $chronograf::params::service_name,
  String $package_name                      = $chronograf::params::package_name,
  String $service_ensure                    = $chronograf::params::service_ensure,
  Boolean $service_enable                   = $chronograf::params::service_enable,
  String $service_restart                   = $chronograf::params::service_restart,

) inherits chronograf::params {
  include chronograf::repo
  include chronograf::install
  include chronograf::config

  if $tls_certificate_path and $tls_private_key_path {
    include chronograf::certs
  }

  include chronograf::service

  create_resources('chronograf::resource::influxdb', $influxdb_instances)
  create_resources('chronograf::resource::kapacitor', $kapacitor_instances)
  if $token_secret {
    create_resources('chronograf::resource::organization', $organizations)
  }
}
