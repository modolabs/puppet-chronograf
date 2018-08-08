# @summary Set up TLS Certificate for Chronograf
#
# @example
#   include chronograf::certs
class chronograf::certs (
  String $cert      = undef,
  String $cert_key  = undef,
  String $cert_name = undef,
) {
  file { "/etc/pki/tls/certs/${cert_name}.cert":
      ensure  => 'present',
      owner   => 'chronograf',
      group   => 'chronograf',
      content => template('chronograf/ssl_cert.cert.erb'),
      mode    => '0644',
      notify  => Class['chronograf::service'],
  }

  file { "/etc/pki/tls/private/${cert_name}.key":
      ensure  => 'present',
      owner   => 'chronograf',
      group   => 'chronograf',
      content => template('chronograf/ssl_cert.key.erb'),
      mode    => '0600',
      notify  => Class['chronograf::service'],
  }
}
