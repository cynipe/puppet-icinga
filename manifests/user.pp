# == Define: icinga::user
#
# This class provides the ability to manage Icinga users.
#
define icinga::user (
  $ensure                        = present,
  $master_id                     = $::icinga::server::master_id,
  $can_submit_commands           = '1',
  $contact_name                  = $name,
  $contactgroup                  = undef,
  $email                         = undef,
  $pager                         = undef,
  $password_hash                 = undef,
  $host_notification_commands    = $::icinga::server::notification_cmd_host,
  $host_notification_period      = $::icinga::server::notification_period,
  $host_notification_options     = 'd,r',
  $service_notification_commands = $::icinga::server::notification_cmd_service,
  $service_notification_period   = $::icinga::server::notification_period,
  $service_notification_options  = 'w,u,c,r',
  $target                        = "${::icinga::server::targetdir}/contacts.cfg"
) {

  $htpasswd = $::icinga::server::htpasswd_file
  $owner    = $::icinga::server::server_user
  $group    = $::icinga::server::server_group
  $service  = $::icinga::server::server_service

  Exec {
    require => File[$htpasswd],
    notify  => Service[$service],
  }

  if $password_hash {
    case $ensure {
      present: {
        exec { "Add Icinga user hash ${name}":
          command => "echo \"${name}:${password_hash}\" >> ${htpasswd}",
          unless  => "grep -iE '^${name}:${password_hash}' ${htpasswd}",
        }
      }

      absent: {
        exec { "Remove Icinga user ${name}":
          command => "htpasswd -D ${htpasswd} ${name}",
          onlyif  => "grep -iE '^${name}:' ${htpasswd}",
          cwd     => '/etc/icinga',
        }
      }

      default: {
        fail "Invalid value for \$icinga::user::ensure: ${ensure}."
      }
    }
  }

  @nagios_contact { $name:
    ensure                        => $ensure,
    can_submit_commands           => $can_submit_commands,
    contact_name                  => $contact_name,
    email                         => $email,
    pager                         => $pager,
    target                        => $target,
    host_notification_commands    => $host_notification_commands,
    host_notification_period      => $host_notification_period,
    host_notification_options     => $host_notification_options,
    service_notification_commands => $service_notification_commands,
    service_notification_period   => $service_notification_period,
    service_notification_options  => $service_notification_options,
    require                       => Exec['purge_icinga_configs'],
    notify                        => Exec['fix_permissions_objects'],
    tag                           => $master_id,
  }
}
