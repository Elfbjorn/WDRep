#!/bin/bash
set -e

psql -p  55432 -h localhost -U wdrep -d wdrep -f ./DDL-tables.sql
psql -p  55432 -h localhost -U wdrep -d wdrep -f ./DDL-fk.sql
psql -p  55432 -h localhost -U wdrep -d wdrep -f ./DDL-functions.sql
psql -p  55432 -h localhost -U wdrep -d wdrep -f ./DML-inserts.sql
