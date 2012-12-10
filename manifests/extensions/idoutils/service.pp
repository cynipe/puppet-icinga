# == Class: icinga::extensions::idoutils::service
#
# This class provides the idoutils plugin's service.
#
class icinga::extensions::idoutils::service {
  service { $icinga::idoutils_service:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    subscribe => Class['icinga::extensions::idoutils::config'];
  }
}
