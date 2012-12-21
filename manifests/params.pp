# == Class: icinga::params
#
# Full description of class icinga here.
#
class icinga::params {
  # FIXME Need to find the way to what version to be installed.
  # Since facter fetch the values at very first of the process,
  # it's impossible to do this before the yumrepo setuped. ugh
  # $version = ${::icinga_version}
  $version                     = '1.7.2'
  $manage_repo                 = false
  $use_auth                    = true
  $use_storedconfigs           = false
  $extensions                  = [ 'idoutils', 'icingaweb' ]
  $icinga_admins               = [ '*' ]
  $collect_hostname            = $::fqdn
  $collect_ipaddress           = $::ipaddress
  $notification_cmd_host       = 'notify-host-by-email'
  $notification_cmd_service    = 'notify-service-by-email'
  $notification_period         = '24x7'
  $notification_host_enable    = true
  $notification_service_enable = true
  $max_check_attempts          = '4'

  case $::architecture {
    'x86_64': { $usrlib = '/usr/lib64' }
    default:  { $usrlib = '/usr/lib'   }
  }

  # Icinga
  $server_package            = [ 'icinga', 'icinga-gui', 'icinga-doc', 'nagios-plugins-nrpe' ]
  $server_service            = 'icinga'
  $server_service_ensure     = 'running'
  $server_user               = 'icinga'
  $server_group              = 'icinga'
  $server_cmd_group          = 'icingacmd'
  $htpasswd_file             = "/etc/icinga/passwd"
  $targetdir                 = "/etc/icinga/objects"

  $webserver_service         = 'httpd'
  $webserver_user            = 'apache'
  $webserver_group           = 'apache'
  $icinga_vhost              = '/etc/httpd/conf.d/icinga.conf'

  # Extension: Icinga Web
  $icingaweb_pkg     = [ 'icinga-web' ]
  $icingaweb_pkg_dep = [ 'php-xml', 'php-xmlrpc', 'php-soap', 'php-mysql' ]
  $icingaweb_sharedir = '/usr/share/icinga-web'
  $icingaweb_confdir  = '/etc/icinga-web'
  $icingaweb_dbsql    = "/usr/share/doc/icinga-web-${version}/schema/mysql.sql"
  $icingaweb_dbname  = 'icinga_web'
  $icingaweb_dbuser  = 'icinga_web'
  $icingaweb_dbpass  = 'icinga_web'
  $icingaweb_vhost   = '/etc/httpd/conf.d/icinga-web.conf'

  # Extension: IDOUtils
  $idoutils_pkg        = 'icinga-idoutils-libdbi-mysql'
  $idoutils_service = 'ido2db'
  $idoutils_dbsql     = "/usr/share/doc/icinga-idoutils-libdbi-mysql-${version}/db/mysql/mysql.sql"
  $idoutils_dbname  = 'icinga'
  $idoutils_dbuser  = 'icinga'
  $idoutils_dbpass  = 'icinga'

}

