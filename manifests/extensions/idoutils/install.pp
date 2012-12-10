# == Class: icinga::extensions::idoutils::install
#
# This class provides the idoutils plugin's installation.
#
class icinga::extensions::idoutils::install {
  package { $icinga::idoutils_pkg:
    ensure => present;
  }
}
