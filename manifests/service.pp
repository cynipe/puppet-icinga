define icinga::service(
  $check_command,
  $service_description,
  $fqdn                = undef,
  $ipaddress           = undef,
  $hostname            = undef,
  $operatingsystem     = $::operatingsystem,
  $use                 = 'generic-service',
  $max_check_attempts  = $::icinga::server::max_check_attempts,
  $notification_period = $::icinga::server::notification_period,
  $targetdir           = $::icinga::server::targetdir
) {

  $real_fqdn = $fqdn ? {
    undef   => inline_template("<%= name.split('::').last %>"),
    default => $fqdn
  }

  @nagios_service { $name:
    check_command       => $check_command,
    use                 => $use,
    service_description => $service_description,
    host_name           => $real_fqdn,
    max_check_attempts  => $max_check_attempts,
    target              => "${targetdir}/services/${real_fqdn}.cfg",
    action_url          => '/pnp4nagios/graph?host=$HOSTNAME$&srv=$SERVICEDESC$',
    notify              => Exec['fix_permissions_objects'];
  }
}
