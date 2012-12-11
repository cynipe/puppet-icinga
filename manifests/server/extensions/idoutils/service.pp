# == Class: icinga::server::extensions::idoutils::service
#
# This class provides the idoutils plugin's service.
#
class icinga::server::extensions::idoutils::service {
  service { $icinga::server::idoutils_service:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    subscribe => Class['icinga::server::extensions::idoutils::config'];
  }
}
