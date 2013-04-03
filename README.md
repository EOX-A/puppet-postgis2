PostGIS 2 Puppet module
=======================

forked from https://github.com/camptocamp/puppet-postgis. Needs postgresql 9.0/9.1/9.2. Debian only.
Make sure to install the postgres module from puppetlabs/postgresql.

To create a database named "gis" with the user "gis_user" do:

		include postgis2

		postgis2::database{ "gis":
			owner => "gis_user"
		}
