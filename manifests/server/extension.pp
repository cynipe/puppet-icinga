# == Define: icinga::extension
#
# This class provides extension support.
#
define icinga::server::extension {
  class { "icinga::server::extensions::${name}":; }
}

