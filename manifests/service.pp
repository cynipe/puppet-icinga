define icinga::service(
  $check_command,
  $service_description = undef,
  $fqdn                = undef,
  $ipaddress           = undef,
  $hostname            = undef,
  $operatingsystem     = $::operatingsystem,
  $use                 = 'generic-service',
  $contact_groups      = 'admins',
  $check_period        = '24x7',
  $notification_period = '24x7',
  $max_check_attempts  = $::icinga::server::max_check_attempts,
  $notification_period = $::icinga::server::notification_period,
  $targetdir           = $::icinga::server::targetdir
) {

  $real_fqdn = $fqdn ? {
    undef   => inline_template("<%= name.split('::').last %>"),
    default => $fqdn
  }
  $real_service_description = $service_description ? {
    undef   => inline_template("<%= name.split('::').first %>"),
    default => $service_description
  }

  @nagios_service { $name:
    check_command       => $check_command,
    use                 => $use,
    service_description => $real_service_description,
    host_name           => $real_fqdn,
    contact_groups      => $contact_groups,
    check_period        => $check_period,
    notification_period => $notification_period,
    max_check_attempts  => $max_check_attempts,
    target              => "${targetdir}/services/${real_fqdn}.cfg",
    action_url          => '/pnp4nagios/graph?host=$HOSTNAME$&srv=$SERVICEDESC$',
    notify              => Exec['fix_permissions_objects'];
  }
}
