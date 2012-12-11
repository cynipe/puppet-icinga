class icinga::server::install {
  package { $::icinga::server::server_package:
    ensure => installed;
  }
}


