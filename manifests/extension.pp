# == Define: icinga::extension
#
# This class provides extension support.
#
define icinga::extension {
  class { "icinga::extensions::${name}":; }
}

