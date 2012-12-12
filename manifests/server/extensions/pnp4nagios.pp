# == Class: icinga::server::extensions::pnp4nagios
#
# This class provides the pnp4nagios plugin.
#
class icinga::server::extensions::pnp4nagios (
  $ensure = present
) {
  include icinga::server::extensions::pnp4nagios::install
  include icinga::server::extensions::pnp4nagios::config

  Class['icinga::server::extensions::pnp4nagios::install'] ->
  Class['icinga::server::extensions::pnp4nagios::config']
}