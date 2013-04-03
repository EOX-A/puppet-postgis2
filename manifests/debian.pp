class postgis2::debian {

  include postgresql::server

  # connect with ubuntugis repo to get postgis >= 2.0.0
  exec {"add_ubuntugis_repo":
    command => "sudo /usr/bin/apt-add-repository ppa:ubuntugis/ubuntugis-unstable",
    notify => Exec["update_sources"]
  }

  # use postgis >= 2.0.0 automatically due to updating the sources
  # also include gdal for raster support
  package {"postgis":
    ensure => latest,
    require => [Exec["add_ubuntugis_repo"], Exec["update_sources"]]
  }

  # import template creation script 
  file {"/usr/local/bin/make-postgresql-postgis-template.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/postgis2/usr/local/bin/make-postgresql-postgis-template.sh",
    require => Package["postgis"]
  }

  # create template_postgis
  exec {"create template_postgis":
    command => "/usr/local/bin/make-postgresql-postgis-template.sh",
    unless  => "psql -l |grep template_postgis",
    user    => postgres,
    require => [ 
        Package["postgis"],
        Service["postgresql"],
        File["/usr/local/bin/make-postgresql-postgis-template.sh"],
    ]
  }
}
