# Yum repo configuration for RHEL/CentOS
#
# @example
#   include chronograf::repo
# PRIVATE CLASS: do not use directly
class chronograf::repo {

    yumrepo { 'influxdata':
        descr    => 'influxdb',
        baseurl  => 'https://repos.influxdata.com/rhel/$releasever/$basearch/stable',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'https://repos.influxdata.com/influxdb.key',
    }

    file { '/etc/yum.repos.d/influxdb-unstable.repo':
        ensure => absent,
    }
}
