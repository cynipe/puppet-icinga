# == Class: icinga::extensions::pnp4nagios::install
#
# This class provides the pnp4nagios plugin's installation.
#
class icinga::extensions::pnp4nagios::install {
  case $::operatingsystem {
    /Debian|Ubuntu/: {
      $package = $::lsbdistcodename ? {
        'squeeze' => 'pnp4nagios/squeeze-backports',
        default   => 'pnp4nagios',
      }
    }

    /CentOS|RedHat|Scientific|OEL|Amazon/: {
      $package = 'pnp4nagios'
    }

    default: {}
  }

  package { $package:
    ensure => present;
  }

}

