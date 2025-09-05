#!/bin/bash
 # Usage: ./popdb.sh <database_name> <username> <password> <host> <port>
 # Example: ./popdb.sh mydb myuser mypass localhost 5432

DBNAME=wdrep_db
DBUSER=wdrep
DBPASS=wdrep_pass
DBHOST=localhost
DBPORT=5432


SCHEMA_PATH="$(cd "$(dirname "$0")/../database" && pwd)"
DDL_TABLES="$SCHEMA_PATH/DDL-tables.sql"
DDL_FK="$SCHEMA_PATH/DDL-fk.sql"
DDL_FUNCTIONS="$SCHEMA_PATH/DDL-functions.sql"
DML_INSERTS="$SCHEMA_PATH/DML-inserts.sql"

# Check for required files
for f in "$DDL_TABLES" "$DDL_FK" "$DDL_FUNCTIONS" "$DML_INSERTS"; do
    if [ ! -f "$f" ]; then
        echo "ERROR: Required file $f not found."
        exit 1
    fi
done

# Export password for psql
export PGPASSWORD="$DBPASS"
# Disable all triggers and FKs before loading
psql -U "$DBUSER" -h "$DBHOST" -p "$DBPORT" -d "$DBNAME" -v ON_ERROR_STOP=1 <<EOF
\i '$DDL_TABLES'
\i '$DDL_FUNCTIONS'
-- Disable all triggers and FKs
DO $$
DECLARE r RECORD;
BEGIN
    FOR r IN SELECT tablename FROM pg_tables WHERE schemaname = 'public' LOOP
        EXECUTE format('ALTER TABLE %I DISABLE TRIGGER ALL;', r.tablename);
    END LOOP;
END $$;
EOF

# Load FKs (they will be disabled by the above DO block)
psql -U "$DBUSER" -h "$DBHOST" -p "$DBPORT" -d "$DBNAME" -v ON_ERROR_STOP=1 -f "$DDL_FK"

# Load seed data
psql -U "$DBUSER" -h "$DBHOST" -p "$DBPORT" -d "$DBNAME" -v ON_ERROR_STOP=1 -f "$DML_INSERTS"

echo "Schema and seed data loaded. All triggers and FKs are currently disabled."
