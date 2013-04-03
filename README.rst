=======================
PostGIS 2 Puppet module
=======================

forked from https://github.com/camptocamp/puppet-postgis. Needs postgresql 9.0/9.1/9.2. Debian only.

Usage Example
---------------

include postgis2

postgis2::database{ "gis":
	owner => "gis_user"
}
