# == Class: icinga::server::collect
#
# This class provides resource collection.
#
class icinga::server::collect {
  $notify_targets = [Service[$::icinga::server::server_service], Exec['fix_permissions_objects'] ]

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

