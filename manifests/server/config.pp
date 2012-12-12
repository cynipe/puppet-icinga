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

}
