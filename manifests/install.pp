# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include chronograf::install
class chronograf::install inherits chronograf {

  $packages = [
    $package_name,
  ]

  package { $packages:
    ensure => $version,
  }
}
