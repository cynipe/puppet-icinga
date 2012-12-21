class icinga::server(
  $master_id                   = '',
  $version                     = $::icinga::params::version,
  $manage_repo                 = $::icinga::params::manage_repo,
  $use_auth                    = $::icinga::params::use_auth,
  $extensions                  = $::icinga::params::extensions,
  $icinga_admins               = $::icinga::params::icinga_admins,
  $collect_hostname            = $::icinga::params::collect_hostname,
  $collect_ipaddress           = $::icinga::params::collect_ipaddress,
  $notification_cmd_host       = $::icinga::params::notification_cmd_host,
  $notification_cmd_service    = $::icinga::params::notification_cmd_service,
  $notification_period         = $::icinga::params::notification_period,
  $notification_host_enable    = $::icinga::params::notification_host_enable,
  $notification_service_enable = $::icinga::params::notification_service_enable,
  $max_check_attempts          = $::icinga::params::max_check_attempts,
  $server_package              = $::icinga::params::server_package,
  $server_service              = $::icinga::params::server_service,
  $server_service_ensure       = $::icinga::params::server_service_ensure,
  $server_user                 = $::icinga::params::server_user,
  $server_group                = $::icinga::params::server_group,
  $server_cmd_group            = $::icinga::params::server_cmd_group,
  $htpasswd_file               = $::icinga::params::htpasswd_file,
  $targetdir                   = $::icinga::params::targetdir,
  $webserver_service           = $::icinga::params::webserver_service,
  $webserver_user              = $::icinga::params::webserver_user,
  $webserver_group             = $::icinga::params::webserver_group,
  $icinga_vhost                = $::icinga::params::icinga_vhost,
  $icingaweb_pkg               = $::icinga::params::icingaweb_pkg,
  $icingaweb_pkg_dep           = $::icinga::params::icingaweb_pkg_dep,
  $icingaweb_sharedir          = $::icinga::params::icingaweb_sharedir,
  $icingaweb_confdir           = $::icinga::params::icingaweb_confdir,
  $icingaweb_dbsql             = $::icinga::params::icingaweb_dbsql,
  $icingaweb_dbname            = $::icinga::params::icingaweb_dbname,
  $icingaweb_dbuser            = $::icinga::params::icingaweb_dbuser,
  $icingaweb_dbpass            = $::icinga::params::icingaweb_dbpass,
  $icingaweb_vhost             = $::icinga::params::icingaweb_vhost,
  $idoutils_pkg                = $::icinga::params::idoutils_pkg,
  $idoutils_service            = $::icinga::params::idoutils_service,
  $idoutils_dbsql              = $::icinga::params::idoutils_dbsql,
  $idoutils_dbname             = $::icinga::params::idoutils_dbname,
  $idoutils_dbuser             = $::icinga::params::idoutils_dbuser,
  $idoutils_dbpass             = $::icinga::params::idoutils_dbpass
) inherits icinga::params {

  include icinga::server::preinstall
  include icinga::server::install
  include icinga::server::config
  include icinga::server::extensions
  include icinga::server::collect
  include icinga::server::service

  Class['icinga::server::preinstall'] ->
  Class['icinga::server::install'] ->
  Class['icinga::server::config'] ->
  Class['icinga::server::extensions'] ->
  Class['icinga::server::collect'] ->
  Class['icinga::server::service']

}
