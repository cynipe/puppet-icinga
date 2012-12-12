# == Class: icinga::config::client::redhat
#
# This class provides client configuration for RHEL and derivative distro's.
#
class icinga::config::client::redhat {
  File {
    owner   => $::icinga::client_user,
    group   => $::icinga::client_group,
    notify  => Service[$::icinga::service_client],
    require => Class['icinga::install'],
  }

  file {
    '/etc/nagios':
      ensure  => directory,
      recurse => true;

    $::icinga::client::plugindir:
      ensure => directory;

    "/etc/nagios/nrpe.cfg":
      ensure  => present,
      content => template('icinga/redhat/nrpe.cfg.erb');

    '/var/log/nrpe':
      ensure => directory;

    '/etc/nrpe.d':
      ensure  => directory
      recurse => true,
      purge   => true;

    "/etc/nrpe.d/default.cfg":
      ensure  => present,
      content => template('icinga/redhat/nrpe_default.cfg.erb');
  }
}
