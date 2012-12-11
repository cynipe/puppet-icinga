# == Class: icinga::server::service
#
# This class provides the daemon configuration.
#
class icinga::server::service {

  exec { 'fix_permissions_objects':
    command     => "chown -R icinga:icinga .",
    cwd         => $::icinga::server::targetdir,
    require     => File[$::icinga::server::targetdir],
    refreshonly => true,
  }

  service {
    $::icinga::params::server_service:
      ensure     => $::icinga::server::ensure,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require => Exec['fix_permissions_objects'];
  }
}

