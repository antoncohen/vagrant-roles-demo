# == Class: role
#
# Full description of class role here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { role:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Anton Cohen <anton@antoncohen.com>
#
# === Copyright
#
# Copyright 2013 Anton Cohen, unless otherwise noted.
#
class role {
  include stdlib

  $roles = hiera_array('roles')

  # Require base first in case is does required setup
  if member($roles, 'role::base') {
    require role::base
  }

  include $roles
}
