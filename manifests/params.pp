# A description of what this class does
#
# @summary Configuration for the chronograf module. Do not use this class directly.
#
# @example
#   include chronograf::params
class chronograf::params {
  case $::osfamily {
    'redhat', 'linux': {
      # Service configuration defaults
      $package_name    = 'chronograf'
      $service_name    = 'chronograf'
      $service_ensure  = 'running'
      $service_manage  = true
      $service_enable  = true
      $service_restart = "service ${service_name} restart"
      $pid_file        = '/var/run/chronograf/chronograf.pid'
      $log_level       = 'info'
    }
    default: {
      fail( "Unsupported platform: ${::osfamily}" )
    }
  }
}
