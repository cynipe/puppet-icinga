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
  $client                      = true
  $server                      = false
  $use_auth                    = true
  $plugins                     = [ 'checkpuppet' ]
  $nrpe_allowed_hosts          = [ '127.0.0.1,', $::ipaddress ]
  $nrpe_server_address         = $::ipaddress
  $icinga_admins               = '*'
  $collect_hostname            = $::fqdn
  $notification_cmd_host       = 'notify-host-by-email'
  $notification_cmd_service    = 'notify-service-by-email'
  $notification_period         = '24x7'
  $notification_host_enable    = true
  $notification_service_enable = true
  $max_check_attempts          = '4'

  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      fail 'Currently not supported.'
      #$package = $::lsbdistcodename ? {
      #  'squeeze' => 'pnp4nagios/squeeze-backports',
      #  default   => 'pnp4nagios',
      #}
      #
      #$package_client_ensure     = 'present'
      #$package_server_ensure     = 'present'
      #$package_client            = [ 'nagios-nrpe-server', 'nagios-plugins' ]
      #$package_server            = [ 'icinga', 'icinga-api', 'icinga-doc', 'icinga-gui', 'nagios-plugins-nrpe' ]
      #$service_client            = 'nagios-nrpe-server'
      #$service_client_ensure     = 'running'
      #$service_client_enable     = true
      #$service_client_hasstatus  = false
      #$service_client_hasrestart = true
      #$service_client_pattern    = 'nrpe'
      #$service_server            = 'icinga'
      #$service_server_ensure     = 'running'
      #$service_server_enable     = true
      #$service_server_hasstatus  = true
      #$service_server_hasrestart = true
      #$pidfile_client            = '/var/run/nagios/nrpe.pid'
      #$pidfile_server            = '/var/run/icinga/icinga.pid'
      #$confdir_client            = '/etc/nagios'
      #$confdir_server            = '/etc/icinga'
      #$vardir_client             = '/var/lib/nagios'
      #$vardir_server             = '/var/lib/icinga'
      #$sharedir_server           = '/usr/share/icinga/htdocs'
      #$includedir_client         = '/etc/nagios/nrpe.d'
      #$usrlib                    = '/usr/lib'
      #$plugindir                 = "${usrlib}/nagios/plugins"
      #$service_webserver         = 'apache2'
      #$webserver_user            = 'www-data'
      #$webserver_group           = 'www-data'
      #$server_user               = 'nagios'
      #$server_group              = 'nagios'
      #$client_user               = $server_user
      #$client_group              = $server_group
      #$server_cmd_group          = $server_group
      #$htpasswd_file             = "${confdir_server}/htpasswd.users"
      #$targetdir                 = "${confdir_server}/objects"
      #$targetdir_contacts        = "${targetdir}/contacts/contacts.cfg"
      #$icinga_vhost              = '/etc/icinga/apache2.conf'
      #$logdir_client             = '/var/log/nrpe'
      #$logdir_server             = '/var/log/icinga'
      #
      ## IDOUTILS: TO BE REFACTORED
      #$idoutils_pkg     = 'icinga-idoutils'
      #$idoutils_confdir = '/etc/icinga/idoutils'
      #$idoutils_service = 'ido2db'
      #$idoutils_dbname  = 'icinga'
      #$idoutils_dbuser  = 'icinga'
      #$idoutils_dbpass  = 'icinga'
    }

    'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon': {
      case $::architecture {
        'x86_64': { $usrlib = '/usr/lib64' }
        default:  { $usrlib = '/usr/lib'   }
      }

      # Icinga
      $package_client_ensure     = 'present'
      $package_server_ensure     = 'present'
      $package_client            = [ 'nrpe', 'nagios-plugins', 'nagios-plugins-all' ]
      $package_server            = [ 'icinga', 'icinga-gui', 'icinga-doc', 'nagios-plugins-nrpe' ]
      $service_client            = 'nrpe'
      $service_client_ensure     = 'running'
      $service_client_enable     = true
      $service_client_hasstatus  = true
      $service_client_hasrestart = true
      $service_client_pattern    = ''
      $service_server            = 'icinga'
      $service_server_ensure     = 'running'
      $service_server_enable     = true
      $service_server_hasstatus  = true
      $service_server_hasrestart = true
      $pidfile_client            = '/var/run/nrpe/nrpe.pid'
      $pidfile_server            = ''
      $confdir_client            = '/etc/nagios'
      $confdir_server            = '/etc/icinga'
      $vardir_client             = '/var/icinga'
      $vardir_server             = '/var/icinga'
      $sharedir_server           = '/usr/share/icinga'
      $includedir_client         = '/etc/nrpe.d'
      $plugindir                 = "${usrlib}/nagios/plugins"
      $service_webserver         = 'httpd'
      $webserver_user            = 'apache'
      $webserver_group           = 'apache'
      $server_user               = 'icinga'
      $server_group              = 'icinga'
      $client_user               = 'nagios'
      $client_group              = 'nagios'
      $server_cmd_group          = 'icingacmd'
      $htpasswd_file             = "${confdir_server}/passwd"
      $targetdir                 = "${confdir_server}/objects"
      $targetdir_contacts        = "${targetdir}/contacts/contacts.cfg"
      $icinga_vhost              = '/etc/httpd/conf.d/icinga.conf'
      $logdir_client             = '/var/log/nrpe'
      $logdir_server             = '/var/log/icinga'


      # Plugin: Icinga Web
      $icingaweb_pkg     = [ 'icinga-web' ]
      $icingaweb_pkg_dep = [ 'php-xml', 'php-xmlrpc', 'php-soap', 'php-mysql' ]
      $icingaweb_sharedir = '/usr/share/icinga-web'
      $icingaweb_confdir  = '/etc/icinga-web'
      $icingaweb_dbsql    = "/usr/share/doc/icinga-web-${version}/schema/mysql.sql"
      $icingaweb_dbname  = 'icinga_web'
      $icingaweb_dbuser  = 'icinga_web'
      $icingaweb_dbpass  = 'icinga_web'
      $icingaweb_vhost   = '/etc/httpd/conf.d/icinga-web.conf'

      # Plugin: IDOUtils
      $idoutils_pkg        = 'icinga-idoutils-libdbi-mysql'
      $idoutils_service = 'ido2db'
      $idoutils_dbsql     = "/usr/share/doc/icinga-idoutils-libdbi-mysql-${version}/db/mysql/mysql.sql"
      $idoutils_dbname  = 'icinga'
      $idoutils_dbuser  = 'icinga'
      $idoutils_dbpass  = 'icinga'
    }

    default: {}
  }
}

