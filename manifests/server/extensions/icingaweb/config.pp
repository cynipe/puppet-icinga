class icinga::server::extensions::icingaweb::config {
  File {
    owner => $icinga::server::webserver_user,
    group => $icinga::server::webserver_group,
    require => Package[$icinga::server::icingaweb_pkg],
    notify => [
      Service[$icinga::server::server_service],
      Service[$icinga::server::webserver_service],
    ]
  }

  file {
    $::icinga::server::icingaweb_vhost:
      ensure  => present,
      content => template('icinga/extensions/icingaweb/httpd.conf.erb'),
      notify  => Service[$::icinga::server::webserver_service];

    "/etc/icinga-web/conf.d/databases.xml":
      ensure => present,
      content => template('icinga/extensions/icingaweb/databases.xml.erb'),
      notify => Exec['icingaweb-db-tables'];
  }

  exec { 'icingaweb-db-tables':
    command   => "/usr/bin/mysql -u ${::icinga::server::icingaweb_dbuser} --password=${::icinga::server::icingaweb_dbpass} ${::icinga::server::icingaweb_dbname} < ${::icinga::server::icingaweb_dbsql}",
    unless    => "/usr/bin/mysqlshow ${::icinga::server::icingaweb_dbname} | grep cronk",
  }

}
