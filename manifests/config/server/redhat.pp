# == Class: icinga::config::server::redhat
#
# This class provides server configuration for RHEL and derivative distro's.
#
class icinga::config::server::redhat {
  if $::icinga::server {
    File {
      owner   => $::icinga::server_user,
      group   => $::icinga::server_group,
      require => Class['icinga::config'],
      notify  => [
        Service[$::icinga::service_client],
        Service[$::icinga::service_server],
        Group[$::icinga::server_cmd_group],
        Exec['fix_collected_permissions']
      ],
    }

    exec { 'fix_collected_permissions':
      # temporary work-around
      command     => "chown -R ${::icinga::server_user}:${::icinga::server_group} .",
      cwd         => $icinga::params::targetdir,
      notify      => Service[$::icinga::service_server],
      require     => File[$::icinga::targetdir],
      refreshonly => true,
    }

    file {
      $::icinga::icinga_vhost:
        ensure  => present,
        content => template('icinga/redhat/httpd.conf.erb'),
        notify  => Service[$::icinga::service_webserver];

      $::icinga::htpasswd_file:
        ensure => present,
        mode   => '0644';

      "/etc/icinga/cgi.cfg":
        ensure  => present,
        content => template('icinga/redhat/cgi.cfg.erb');

      "/etc/icinga/icinga.cfg":
        ensure  => present,
        content => template('icinga/redhat/icinga.cfg.erb');

      "/etc/icinga/resource.cfg":
        ensure  => present,
        content => template('icinga/redhat/resource.cfg.erb');

      "/etc/icinga/objects/commands.cfg":
        ensure  => present,
        content => template('icinga/redhat/commands.cfg.erb');

      "/etc/icinga/objects/generic-host.cfg":
        ensure  => present,
        content => template('icinga/redhat/generic-host.cfg.erb');

      "/etc/icinga/objects/generic-service.cfg":
        ensure  => present,
        content => template('icinga/redhat/generic-service.cfg.erb');

      "/etc/icinga/objects/hostgroups.cfg":
        ensure  => present,
        content => template('icinga/redhat/hostgroups.cfg.erb');

      "/etc/icinga/objects/notifications.cfg":
        ensure  => present,
        content => template('icinga/redhat/notifications.cfg.erb');

      "/etc/icinga/objects/timeperiods.cfg":
        ensure  => present,
        content => template('icinga/redhat/timeperiods.cfg.erb');

      "/etc/icinga/objects/templates.cfg":
        ensure  => present,
        content => template('icinga/redhat/templates.cfg.erb');

      "/usr/share/icinga/images/logos":
        ensure  => directory;

      "/usr/share/icinga/images/logos/os":
        ensure  => directory,
        recurse => true,
        source  => 'puppet:///modules/icinga/img-os';
    }
  }
}
