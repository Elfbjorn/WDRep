#!/bin/bash
set -e

psql -U wdrep -d wdrep_db -f /docker-entrypoint-initdb.d/DDL-tables.sql
psql -U wdrep -d wdrep_db -f /docker-entrypoint-initdb.d/DDL-fk.sql
psql -U wdrep -d wdrep_db -f /docker-entrypoint-initdb.d/DML-inserts.sql
