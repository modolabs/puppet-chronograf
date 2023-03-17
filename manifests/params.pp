# @summaryThe OS-related parameters for chronograf
#
# @example
#   include chronograf::params
# PRIVATE CLASS: do not use directly
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
      $manage_repo     = true
    }
    default: {
      fail( "Unsupported platform: ${::osfamily}" )
    }
  }
}
