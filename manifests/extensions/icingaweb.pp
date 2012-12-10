# == Class: icinga::extensions::icingaweb
#
# This class provides the Icinga-web plugin.
#
class icinga::extensions::icingaweb {
  if $icinga::server {
    include icinga::extensions::icingaweb::install
    include icinga::extensions::icingaweb::config

    Class['icinga::extensions::icingaweb::install'] ->
    Class['icinga::extensions::icingaweb::config']
  }
}
