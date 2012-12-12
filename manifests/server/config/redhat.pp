# == Class: icinga::server::config::redhat
#
# This class provides server configuration for RHEL and derivative distro's.
#
class icinga::server::config::redhat {
  File {
    owner   => $::icinga::server::server_user,
    group   => $::icinga::server::server_group,
    require => Package[$::icinga::server::server_package],
    notify  => Service[$::icinga::server::server_service],
  }

  file {
    '/etc/icinga':
      ensure => directory,
      recurse => true,
      purge   => true;

    '/etc/icinga/conf.d':
      ensure => directory,
      recurse => true,
      purge   => true;

    '/etc/icinga/modules':
      ensure => directory,
      recurse => true,
      purge   => true;

    $::icinga::server::icinga_vhost:
      ensure  => present,
      content => template('icinga/redhat/httpd.conf.erb'),
      notify  => Service[$::icinga::server::webserver_service];

    '/etc/icinga/passwd':
      ensure => present,
      mode   => '0644';

    $::icinga::server::targetdir:
      ensure  => directory,
      recurse => true,
      purge   => true,
      mode    => '0644';

    "${::icinga::server::targetdir}/hosts":
      ensure  => directory,
      recurse => true;

    "${::icinga::server::targetdir}/services":
      ensure  => directory,
      recurse => true;

    "${::icinga::server::targetdir}/contacts":
      ensure => directory,
      recurse => true;

    "${::icinga::server::targetdir}/commands":
      ensure => directory,
      recurse => true;

    "/etc/icinga/cgi.cfg":
      ensure  => present,
      content => template('icinga/redhat/cgi.cfg.erb');

    "/etc/icinga/icinga.cfg":
      ensure  => present,
      content => template('icinga/redhat/icinga.cfg.erb');

    "/etc/icinga/resource.cfg":
      ensure  => present,
      content => template('icinga/redhat/resource.cfg.erb');

    "${::icinga::server::targetdir}/commands.cfg":
      ensure  => present,
      content => template('icinga/redhat/commands.cfg.erb');

    "${::icinga::server::targetdir}/generic-host.cfg":
      ensure  => present,
      content => template('icinga/redhat/generic-host.cfg.erb');

    "${::icinga::server::targetdir}/generic-service.cfg":
      ensure  => present,
      content => template('icinga/redhat/generic-service.cfg.erb');

    "${::icinga::server::targetdir}/hostgroups.cfg":
      ensure  => present,
      content => template('icinga/redhat/hostgroups.cfg.erb');

    "${::icinga::server::targetdir}/notifications.cfg":
      ensure  => present,
      content => template('icinga/redhat/notifications.cfg.erb');

    "${::icinga::server::targetdir}/timeperiods.cfg":
      ensure  => present,
      content => template('icinga/redhat/timeperiods.cfg.erb');

    "/usr/share/icinga/images/logos":
      ensure  => directory;

    "/usr/share/icinga/images/logos/os":
      ensure  => directory,
      recurse => true,
      source  => 'puppet:///modules/icinga/img-os';

  }
}
