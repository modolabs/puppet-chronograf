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
# PRIVATE CLASS: do not use directly
class chronograf::service inherits chronograf {
  # The base class must be included first because parameter defaults depend on it
  if ! defined(Class['chronograf::params']) {
    fail('You must include the chronograf::params class before using any chronograf defined resources')
  }

  case $chronograf::service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $chronograf::service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }
  if $chronograf::service_manage {
    service { 'chronograf':
      ensure     => $_service_ensure,
      name       => $chronograf::service_name,
      enable     => $chronograf::service_enable,
      restart    => $chronograf::service_restart,
      hasrestart => true,
      hasstatus  => true,
      require    => Package[$chronograf::package_name]
    }
  }
}

