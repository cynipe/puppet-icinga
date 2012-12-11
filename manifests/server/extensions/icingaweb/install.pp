class icinga::server::extensions::icingaweb::install {
  package {
    $::icinga::server::icingaweb_pkg_dep:
      ensure => present;

    $::icinga::server::icingaweb_pkg:
      ensure => present,
      require => Package[$icinga::server::icingaweb_pkg_dep];
  }
}
