# == Class: icinga::server::extensions::idoutils
#
# This class provides the idoutils plugin.
#
class icinga::server::extensions::idoutils {
  include icinga::server::extensions::idoutils::install
  include icinga::server::extensions::idoutils::config
  include icinga::server::extensions::idoutils::service

  anchor {'icinga::server::extensions::idoutils::begin': } ->
  Class['icinga::server::extensions::idoutils::install'] ->
  Class['icinga::server::extensions::idoutils::config'] ->
  Class['icinga::server::extensions::idoutils::service'] ->
  anchor {'icinga::server::extensions::idoutils::end': }
}
