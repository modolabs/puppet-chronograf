# @summary Configuration file setup for Chronograf
#
# @example
#   include chronograf::config
class chronograf::config inherits chronograf {

  # Main config file
  file { '/etc/default/chronograf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('chronograf/chronograf.conf.erb'),
    notify  => Class['chronograf::service']
  }
}
