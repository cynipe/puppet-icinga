class icinga::realize {

  if $::icinga::server {
    # Set defaults for collected resources.
    Nagios_host <| |>              { notify => Service[$::icinga::service_server] }
    Nagios_service <| |>           { notify => Service[$::icinga::service_server] }
    Nagios_hostextinfo <| |>       { notify => Service[$::icinga::service_server] }
    Nagios_command <| |>           { notify => Service[$::icinga::service_server] }
    Nagios_contact <| |>           { notify => Service[$::icinga::service_server] }
    Nagios_contactgroup <| |>      { notify => Service[$::icinga::service_server] }
    Nagios_hostdependency <| |>    { notify => Service[$::icinga::service_server] }
    Nagios_hostescalation <| |>    { notify => Service[$::icinga::service_server] }
    Nagios_hostgroup <| |>         { notify => Service[$::icinga::service_server] }
    Nagios_servicedependency <| |> { notify => Service[$::icinga::service_server] }
    Nagios_serviceescalation <| |> { notify => Service[$::icinga::service_server] }
    Nagios_serviceextinfo <| |>    { notify => Service[$::icinga::service_server] }
    Nagios_servicegroup <| |>      { notify => Service[$::icinga::service_server] }
    Nagios_timeperiod <| |>        { notify => Service[$::icinga::service_server] }
  }

}

