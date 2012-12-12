class icinga::client::install {
  package { $::icinga::client::client_package:
    ensure => installed;
  }
}
