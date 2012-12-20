# == Class: icinga::server::collect
#
# This class provides resource collection.
#
class icinga::server::collect {
  $notify_targets = [Service[$::icinga::server::server_service], Exec['fix_permissions_objects'] ]

  # Set defaults for collected resources.
  if $::icinga::server::use_storedconfigs {
    Nagios_host <<| |>>              { notify => $notify_targets, require => File["${::icinga::server::targetdir}/hosts"]    }
    Nagios_hostextinfo <<| |>>       { notify => $notify_targets, require => File["${::icinga::server::targetdir}/hosts"]    }
    Nagios_service <<| |>>           { notify => $notify_targets, require => File["${::icinga::server::targetdir}/services"] }
    Nagios_command <<| |>>           { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_contact <<| |>>           { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_contactgroup <<| |>>      { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_hostdependency <<| |>>    { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_hostescalation <<| |>>    { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_hostgroup <<| |>>         { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_servicedependency <<| |>> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_serviceescalation <<| |>> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_serviceextinfo <<| |>>    { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_servicegroup <<| |>>      { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_timeperiod <<| |>>        { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
  }
  else {
    Nagios_host              <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File["${::icinga::server::targetdir}/hosts"]    }
    Nagios_hostextinfo       <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File["${::icinga::server::targetdir}/hosts"]    }
    Nagios_service           <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File["${::icinga::server::targetdir}/services"] }
    Nagios_command           <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_contact           <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_contactgroup      <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_hostdependency    <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_hostescalation    <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_hostgroup         <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_servicedependency <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_serviceescalation <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_serviceextinfo    <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_servicegroup      <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
    Nagios_timeperiod        <| tag == '' or tag == $::icinga::server::master_id |> { notify => $notify_targets, require => File[$::icinga::server::targetdir]              }
  }
}

