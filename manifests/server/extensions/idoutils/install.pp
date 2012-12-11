# == Class: icinga::server::extensions::idoutils::install
#
# This class provides the idoutils plugin's installation.
#
class icinga::server::extensions::idoutils::install {
  package { $::icinga::server::idoutils_pkg:
    ensure => present;
  }
}
