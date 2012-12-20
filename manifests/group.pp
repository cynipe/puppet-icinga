# == Define: icinga::group
#
# This class provides the ability to manage Icinga groups.
#
define icinga::group (
  $ensure               = present,
  $members              = undef,
  $contactgroup_name    = $name,
  $target               = "${::icinga::server::targetdir}/contactgroups.cfg"
) {

  Nagios_contactgroup {
    ensure            => $ensure,
    contactgroup_name => $contactgroup_name,
    members           => $members,
    target            => $target,
  }

  if $::icinga::server::use_storedconfigs  {
    @@nagios_contactgroup { $name: }
  } else {
    @nagios_contactgroup { $name: }
  }
}

