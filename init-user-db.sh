#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER metabase with password '1234567890';
	CREATE DATABASE metabase;
	GRANT ALL PRIVILEGES ON DATABASE metabase TO metabase;
EOSQL