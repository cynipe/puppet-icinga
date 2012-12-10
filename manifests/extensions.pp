# == Class: icinga::extensions
#
# Full description of class.
#
class icinga::extensions {
  if $::icinga::extensions {
    icinga::extension { $::icinga::extensions:; }
  }
}

