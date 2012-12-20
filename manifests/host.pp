define icinga::host(
  $fqdn                = $name,
  $alias               = $name,
  $ipaddress           = undef,
  $operatingsystem     = $::operatingsystem,
  $max_check_attempts  = $::icinga::server::max_check_attempts,
  $notification_period = $::icinga::server::notification_period,
  $targetdir           = $::icinga::server::targetdir
) {

  @nagios_host { $fqdn:
    ensure             => present,
    alias              => $alias,
    address            => $ipaddress,
    max_check_attempts => $max_check_attempts,
    check_command      => 'check-host-alive',
    use                => 'linux-server',
    hostgroups         => 'linux-servers',
    action_url         => '/pnp4nagios/graph?host=$HOSTNAME$',
    target             => "${targetdir}/hosts/host-${fqdn}.cfg",
    notify              => Exec['fix_permissions_objects'];
  }

  @nagios_hostextinfo { $fqdn:
    ensure          => present,
    icon_image_alt  => $operatingsystem,
    icon_image      => "os/${operatingsystem}.png",
    statusmap_image => "os/${operatingsystem}.png",
    target          => "${targetdir}/hosts/hostextinfo-${fqdn}.cfg",
    notify              => Exec['fix_permissions_objects'];
  }

  @nagios_service { "check_ping_${fqdn}":
    service_description => 'Ping',
    check_command       => 'check_ping!100.0,20%!500.0,60%',
    host_name           => $fqdn,
    use                 => 'generic-service',
    max_check_attempts  => $max_check_attempts,
    notification_period => $notification_period,
    target              => "${targetdir}/services/${fqdn}.cfg",
    action_url          => '/pnp4nagios/graph?host=$HOSTNAME$&srv=$SERVICEDESC$',
    notify              => Exec['fix_permissions_objects'];
  }
}
