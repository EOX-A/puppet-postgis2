# Class: postgis
#
# Install postgis >= 2.0.0 with postgresql 9.1 using debian packages
#
# Sample usage:
#   include postgis
#

class postgis2 {

  # Define variables
  case $::osfamily {
    'Debian': {
       $ostype = 'debian'
    }
    'RedHat': {
       $ostype = 'redhat'
    }
    default: { fail "Unsupported OS family ${::osfamily}" }
  }

  # Include base
  include "postgis2::${ostype}"
}
