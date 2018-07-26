# Yum repo configuration for RHEL/CentOS
#
# @example
#   include chronograf::repo
# PRIVATE CLASS: do not use directly
class chronograf::repo {

    # Using other influxdata modules may include these, so don't redeclare them in that case.
    if !defined(Yumrepo['influxdb']) and !defined(Yumrepo['influxdata']) {
        yumrepo { 'influxdata':
            descr    => 'influxdb',
            baseurl  => 'https://repos.influxdata.com/rhel/$releasever/$basearch/stable',
            enabled  => 1,
            gpgcheck => 1,
            gpgkey   => 'https://repos.influxdata.com/influxdb.key',
        }
    }

    if !defined(File['/etc/yum.repos.d/influxdb-unstable.repo']) {
        file { '/etc/yum.repos.d/influxdb-unstable.repo':
            ensure => absent,
        }
    }
}
