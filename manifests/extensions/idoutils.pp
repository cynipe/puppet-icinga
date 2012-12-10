# == Class: icinga::extensions::idoutils
#
# This class provides the idoutils plugin.
#
class icinga::extensions::idoutils {
  if $icinga::server {
    include icinga::extensions::idoutils::install
    include icinga::extensions::idoutils::config
    include icinga::extensions::idoutils::service

    Class['icinga::extensions::idoutils::install'] ->
    Class['icinga::extensions::idoutils::config'] ->
    Class['icinga::extensions::idoutils::service']
  }
}
