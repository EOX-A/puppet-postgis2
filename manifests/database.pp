/*

==Definition: postgis::database

Create a new PostgreSQL PostGIS database and a corresponding user. Manually done because the puppetforge postgres module
does not support templates when creating new databases

*/

# Class: name
#
#


define postgis2::database(
  $owner = postgres,
  ) {

  exec { "create user":
    command => "createuser ${owner} -R -D -S",
    user => postgres,
    unless  => "psql -c 'select * from pg_roles;' | grep '\\b\\${owner}\\b'",
    require => [
      Exec["create template_postgis"],
      Package["postgis"], 
      Service["postgresql"]
    ],
  }

  exec {"create postgis database":
    command => "createdb ${name} --username postgres --owner ${owner} --template template_postgis",
    unless  => "psql -l | grep '\\b\\${name}\\b'",
    user => postgres,

    require => [
      Exec["create user"], 
      Package["postgis"], 
      Service["postgresql"]
    ] ,
    }
  }



