# Installs the chronograf package and any related dependencies
#
# @summary Class for installing the chronograf package
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
