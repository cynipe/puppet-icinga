class icinga::server::extensions {

  if $::icinga::server::extensions {
    icinga::server::extension { $::icinga::server::extensions:; }
  }

}
