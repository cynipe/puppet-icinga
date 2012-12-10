# == Class: icinga::extensions::pnp4nagios
#
# This class provides the pnp4nagios plugin.
#
class icinga::extensions::pnp4nagios (
  $ensure = present
) {
  if $icinga::server {
    include icinga::extensions::pnp4nagios::install
    include icinga::extensions::pnp4nagios::config

    Class['icinga::extensions::pnp4nagios::install'] -> Class['icinga::extensions::pnp4nagios::config']
  }
}
