# == Define: icinga::group
#
# This class provides the ability to manage Icinga groups.
#
define icinga::group (
  $ensure               = present,
  $master_id            = $::icinga::server::master_id,
  $members              = undef,
  $contactgroup_name    = $name,
  $target               = "${::icinga::server::targetdir}/contactgroups.cfg"
) {

  @nagios_contactgroup { $name:
    ensure            => $ensure,
    contactgroup_name => $contactgroup_name,
    members           => $members,
    target            => $target,
    require           => Exec['purge_icinga_configs'],
    notify            => Exec['fix_permissions_objects'],
    tag               => $master_id,
  }
}

