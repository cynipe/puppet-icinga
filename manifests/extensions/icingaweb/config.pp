class icinga::extensions::icingaweb::config {
  File {
    owner => $icinga::webserver_user,
    group => $icinga::webserver_group,
    require => Package[$icinga::icingaweb_pkg],
    notify => [
      Service[$icinga::service_server],
      Service[$icinga::service_webserver],
    ]
  }

  file {
    $::icinga::icingaweb_vhost:
      ensure  => present,
      content => template('icinga/extensions/icingaweb/httpd.conf.erb'),
      notify  => Service[$::icinga::service_webserver];

    "/etc/icinga-web/conf.d/databases.xml":
      ensure => present,
      content => template('icinga/extensions/icingaweb/databases.xml.erb'),
      notify => Exec['icingaweb-db-tables'];
  }

  exec { 'icingaweb-db-tables':
    command   => "/usr/bin/mysql -u ${::icinga::icingaweb_dbuser} --password=${::icinga::icingaweb_dbpass} ${::icinga::icingaweb_dbname} < ${::icinga::icingaweb_dbsql}",
    unless    => "/usr/bin/mysqlshow ${::icinga::icingaweb_dbname} | grep cronk",
  }

}
