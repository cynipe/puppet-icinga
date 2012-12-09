# == Class: icinga::plugins::idoutils::config
#
# This class provides the idoutils plugin's configuration.
#
class icinga::plugins::idoutils::config {

  File {
    owner   => $icinga::server_user,
    group   => $icinga::server_group,
    require => Package[$icinga::idoutils_pkg],
    notify  => Service[$icinga::service_server],
  }

  file {
    "/etc/icinga/ido2db.cfg":
      ensure  => present,
      content => template('icinga/plugins/idoutils/ido2db.cfg.erb');

    "/etc/icinga/idomod.cfg":
      content => template('icinga/plugins/idoutils/idomod.cfg.erb');
  }

  Exec {
    require => Package[$icinga::idoutils_pkg]
  }

  exec { 'icinga-db-tables':
    command   => "/usr/bin/mysql -u ${::icinga::idoutils_dbuser} --password=${::icinga::idoutils_dbpass} ${::icinga::idoutils_dbname} < ${::icinga::idoutils_dbsql}",
    unless    => "/usr/bin/mysqlshow ${::icinga::idoutils_dbname} | grep icinga_contacts",
  }
}
