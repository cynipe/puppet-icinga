class icinga::client(

) inherits icinga::params {

  include icinga::server::preinstall
  include icinga::server::install
  include icinga::server::config
  include icinga::server::extensions
  include icinga::server::service

  if $use_storedconfigs {
    include icinga::server::collect

    Class['icinga::server::preinstall'] ->
    Class['icinga::server::install'] ->
    Class['icinga::server::config'] ->
    Class['icinga::server::extensions'] ->
    Class['icinga::server::collect'] ->
    Class['icinga::server::service']
  }
  else {
    include icinga::server::realize

    Class['icinga::server::preinstall'] ->
    Class['icinga::server::install'] ->
    Class['icinga::server::config'] ->
    Class['icinga::server::extensions'] ->
    Class['icinga::server::realize'] ->
    Class['icinga::server::service']
  }


}
