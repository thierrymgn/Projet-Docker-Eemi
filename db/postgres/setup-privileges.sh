#!/bin/bash
set -e

until pg_isready -h localhost; do
  echo "En attente de PostgreSQL..."
  sleep 1
done

psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
    DO
    \$\$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'todo_user') THEN
            CREATE USER todo_user WITH PASSWORD 'secret_password';
        END IF;
    END
    \$\$;

    SELECT 'CREATE DATABASE todo_db OWNER todo_user'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'todo_db');

    GRANT ALL PRIVILEGES ON DATABASE todo_db TO todo_user;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres --dbname todo_db <<-EOSQL
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO todo_user;

    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO todo_user;

    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO todo_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO todo_user;

    DO
    \$\$
    BEGIN
        IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'todos') THEN
            EXECUTE 'ALTER TABLE todos OWNER TO todo_user';
        END IF;
    END
    \$\$;
EOSQL

echo "Privilèges PostgreSQL configurés avec succès!"
