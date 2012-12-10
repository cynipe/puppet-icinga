# == Define: icinga::group
#
# This class provides the ability to manage Icinga groups.
#
define icinga::group (
  $ensure               = present,
  $contactgroup_members = undef,
  $contactgroup_name    = $name,
  $target               = $::icinga::targetdir_contacts
) {

  if $::icinga::server {
    Nagios_contactgroup {
      ensure               => $ensure,
      contactgroup_name    => $contactgroup_name,
      contactgroup_members => $contactgroup_members,
      target               => $target,
    }

    if $::icinga::use_storedconfigs  {
      @@nagios_contactgroup { $name: }
    } else {
      @nagios_contactgroup { $name: }
    }
  }
}

