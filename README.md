PostGIS 2 Puppet module
=======================


forked from https://github.com/camptocamp/puppet-postgis. Needs postgresql 9.0/9.1/9.2 (on Debian), 
uses postgresql 8.4 on CentOS (& RedHat, but I didn't test that).

Make sure to install the postgres module from puppetlabs/postgresql. Also, on CentOS, install the 
epel module from stahnma/epel.

P.S.: Uses the default postgis from EPEL on CentOS, which, as of the time of this writing was 1.5.3

To create a database named "gis" with the user "gis_user" do:

	include postgis2
	postgis2::database{ "gis":
		owner => "gis_user"
	}
