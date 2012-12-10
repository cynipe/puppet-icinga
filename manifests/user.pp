# == Define: icinga::user
#
# This class provides the ability to manage Icinga users.
#
define icinga::user (
  $ensure                        = present,
  $can_submit_commands           = '0',
  $contact_name                  = $name,
  $contactgroup                  = undef,
  $email                         = undef,
  $pager                         = undef,
  $password_hash                 = undef,
  $host_notification_commands    = $::icinga::notification_cmd_host,
  $host_notification_period      = $::icinga::notification_period,
  $host_notifications_enabled    = $::icinga::notification_host_enable,
  $service_notification_commands = $::icinga::notification_cmd_service,
  $service_notification_period   = $::icinga::notification_period,
  $service_notifications_enabled = $::icinga::notification_service_enable,
  $target                        = $::icinga::targetdir_contacts
) {
  $htpasswd = $::icinga::htpasswd_file
  $owner    = $::icinga::server_user
  $group    = $::icinga::server_group
  $service  = $::icinga::service_server

  if $::icinga::server {
    Exec {
      require => File[$htpasswd],
      notify  => Service[$service],
    }

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
          cwd     => $::icinga::confdir_server,
        }
      }

      default: {
        fail "Invalid value for \$icinga::user::ensure: ${ensure}."
      }
    }

    Nagios_contact {
      ensure                        => $ensure,
      can_submit_commands           => $can_submit_commands,
      contact_name                  => $contact_name,
      email                         => $email,
      pager                         => $pager,
      target                        => "${target}/contacts.cfg",
      host_notification_commands    => $host_notification_commands,
      host_notification_period      => $host_notification_period,
      host_notifications_enabled    => $host_notifications_enabled,
      service_notification_commands => $service_notification_commands,
      service_notification_period   => $service_notification_period,
      service_notifications_enabled => $service_notifications_enabled,
    }

    if $::icinga::use_storedconfigs {
      @@nagios_contact { $name: }
    } else {
      @nagios_contact { $name: }
    }
  }
}
