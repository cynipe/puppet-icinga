# == Class: icinga::server::extensions::icingaweb
#
# This class provides the Icinga-web plugin.
#
class icinga::server::extensions::icingaweb {
  include icinga::server::extensions::icingaweb::install
  include icinga::server::extensions::icingaweb::config

  anchor {'icinga::server::extensions::icingaweb::begin': } ->
  Class['icinga::server::extensions::icingaweb::install'] ->
  Class['icinga::server::extensions::icingaweb::config'] ->
  anchor {'icinga::server::extensions::icingaweb::end': }
}
