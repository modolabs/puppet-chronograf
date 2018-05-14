# == Class: chronograf::service
#
# Manage the Chronograf service
#
# === Authors
#
# Adam Olgin <adam.olgin@modolabs.com>
#
# === Copyright
#
# Copyright 2018 Modo Labs, Inc.
#
class chronograf::service inherits chronograf {
  # The base class must be included first because parameter defaults depend on it
  if ! defined(Class['chronograf::params']) {
    fail('You must include the chronograf::params class before using any chronograf defined resources')
  }
  validate_bool($service_enable)
  validate_bool($service_manage)

  case $service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }
  if $service_manage {
    service { 'chronograf':
      ensure     => $_service_ensure,
      name       => $service_name,
      enable     => $service_enable,
      restart    => $service_restart,
      hasrestart => true,
      hasstatus  => true,
      require    => Package[$package_name]
    }
  }
}

