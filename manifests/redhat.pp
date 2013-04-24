class postgis2::redhat {
  include postgresql::server

  package {"postgis":
    ensure => latest,
  }

  # import template creation script 
  file {"/usr/local/bin/redhat-make-postgresql-postgis-template.sh":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 755,
    source => "puppet:///modules/postgis2/usr/local/bin/redhat-make-postgresql-postgis-template.sh",
    require => Package["postgis"]
  }

  # create template_postgis
  exec {"create template_postgis":
    command => "/usr/local/bin/redhat-make-postgresql-postgis-template.sh",
    unless  => "psql -l | grep template_postgis",
    path    => [ "/usr/bin", "/bin"],
    user    => postgres,
    require => [ 
        Package["postgis"],
        Service["postgresql"],
        File["/usr/local/bin/redhat-make-postgresql-postgis-template.sh"],
    ]
  }
}
