class icinga::server::config {

  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      include icinga::server::config::debian
      $require_class_name = 'icinga::server::config::debian'
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      include icinga::server::config::redhat
      $require_class_name = 'icinga::server::config::redhat'
    }

    default: {}
  }

  @group {
    'nagios':
      ensure  => present,
      members => [
        $::icinga::server::server_group,
        $::icinga::server::webserver_group
      ];

    'icinga':
      ensure  => present,
      members => [
        $::icinga::server::server_group,
        $::icinga::server::webserver_group
      ];

    'icingacmd':
      ensure  => present,
      members => [
        $::icinga::server::server_group,
        $::icinga::server::webserver_group
      ];
  }
  realize Group[$::icinga::server::server_cmd_group]

  Nagios_service {
    host_name           => $::hostname,
    use                 => 'generic-service',
    notification_period => $::icinga::server::notification_period,
    max_check_attempts  => $::icinga::server::max_check_attempts,
    target              => "/etc/icinga/objects/services/${::fqdn}.cfg",
    require             => Class[$require_class_name]
  }

  icinga::host { $::hostname:
    fqdn            => $::icinga::server::collect_hostname,
    ipaddress       => $::icinga::server::collect_ipaddress,
    operatingsystem => $::operatingsystem,
    require             => Class[$require_class_name]
  }

  nagios_service {
    "check_ssh_${::icinga::server::collect_hostname}":
      check_command       => 'check_ssh!-p 22',
      service_description => 'check ssh';
  }

  if defined(Class['icinga::server::extensions::idoutils']) or defined(Class['icinga::server::extensions::icingaweb']) {
    nagios_service { "check_mysql_${::icinga::server::collect_hostname}":
      check_command       => 'check_mysql',
      service_description => 'check mysql';
    }
  }
}
