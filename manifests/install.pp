# Installs the chronograf package and any related dependencies
#
# @summary A short summary of the purpose of this class
#
# @example
#   include chronograf::install
# PRIVATE CLASS: do not use directly
class chronograf::install inherits chronograf {

  $packages = [
    $chronograf::package_name,
  ]

  package { $packages:
    ensure => $chronograf::version,
  }
}
