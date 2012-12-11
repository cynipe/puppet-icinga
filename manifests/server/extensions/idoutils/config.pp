# == Class: icinga::server::extensions::idoutils::config
#
# This class provides the idoutils plugin's configuration.
#
class icinga::server::extensions::idoutils::config {

  File {
    owner   => $::icinga::server::server_user,
    group   => $::icinga::server::server_group,
    require => Package[$::icinga::server::idoutils_pkg],
    notify  => Service[$::icinga::server::server_service],
  }

  file {
    "/etc/icinga/ido2db.cfg":
      ensure  => present,
      content => template('icinga/extensions/idoutils/ido2db.cfg.erb');

    "/etc/icinga/idomod.cfg":
      content => template('icinga/extensions/idoutils/idomod.cfg.erb');

    "${::icinga::server::targetdir}/ido2db_check_proc.cfg":
      ensure  => present,
      content => template('icinga/extensions/idoutils/ido2db_check_proc.cfg.erb');
  }

  Exec {
    require => Package[$::icinga::server::idoutils_pkg]
  }

  exec { 'icinga-db-tables':
    command   => "/usr/bin/mysql -u ${::icinga::server::idoutils_dbuser} --password=${::icinga::server::idoutils_dbpass} ${::icinga::server::idoutils_dbname} < ${::icinga::server::idoutils_dbsql}",
    unless    => "/usr/bin/mysqlshow ${::icinga::server::idoutils_dbname} | grep icinga_contacts",
  }
}
