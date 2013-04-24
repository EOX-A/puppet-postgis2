#!/bin/sh

TMPL_NAME="template_postgis"

# TODO: add support for multiple/non-default clusters
PG_VERSION=$(psql -c 'select version();' | grep -E -o "PostgreSQL ([0-9]*\.[0-9]*)" | grep  -o "[0-9.]*")

case "$PG_VERSION" in
'8.4')
PG_POSTGIS="/usr/share/pgsql/contrib/postgis.sql"
PG_SPATIAL_REF="/usr/share/pgsql/contrib/spatial_ref_sys.sql"
;;
*)
echo "No support for $PG_VERSION in $0"
exit 1
;;
esac

test -e $PG_POSTGIS || exit 1
test -e $PG_SPATIAL_REF || exit 1

cat << EOF | psql -q
CREATE DATABASE $TMPL_NAME WITH template = template1;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = '$TMPL_NAME';
EOF

createlang plpgsql $TMPL_NAME
psql -q -d $TMPL_NAME -f $PG_POSTGIS || exit 1
psql -q -d $TMPL_NAME -f $PG_SPATIAL_REF || exit 1

cat << EOF | psql -d $TMPL_NAME
GRANT ALL ON geometry_columns TO PUBLIC;
GRANT ALL ON geography_columns TO PUBLIC;
GRANT SELECT ON spatial_ref_sys TO PUBLIC;
VACUUM FREEZE;
EOF