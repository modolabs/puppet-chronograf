# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include chronograf::certs
class chronograf::certs (
  $cert      = undef,
  $cert_key  = undef,
  $cert_name = undef,
) {
  validate_string($cert)
  validate_string($cert_key)
  validate_string($cert_name)

  file { "/etc/pki/tls/certs/${cert_name}":
      owner   => 'chronograf',
      group   => 'chronograf',
      content => template('chronograf/ssl_cert.cert.erb'),
      mode    => '0644',
  }

  file { "/etc/pki/tls/private/${cert_name}.key":
      owner   => 'chronograf',
      group   => 'chronograf',
      content => template('chronograf/ssl_cert.key.erb'),
      mode    => '0600',
  }
}
