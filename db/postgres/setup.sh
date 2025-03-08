#!/bin/sh
set -e

until pg_isready -h localhost; do
  echo "En attente de PostgreSQL..."
  sleep 1
done

psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
    CREATE USER todo_user WITH PASSWORD 'secret_password';
    CREATE DATABASE todo_db OWNER todo_user;
    GRANT ALL PRIVILEGES ON DATABASE todo_db TO todo_user;
EOSQL

psql -v ON_ERROR_STOP=1 --username postgres --dbname todo_db <<-EOSQL
    CREATE TABLE IF NOT EXISTS todos
    (
        id    SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        done  BOOLEAN      NOT NULL DEFAULT FALSE
    );

    -- Insérer des données uniquement si la table est vide
    DO \$\$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM todos LIMIT 1) THEN
            INSERT INTO todos (title, done) VALUES
                ('Apprendre Docker', true),
                ('Créer un Dockerfile', true),
                ('Comprendre docker-compose', false),
                ('Maîtriser les volumes Docker', false),
                ('Configurer des réseaux Docker', false),
                ('Optimiser les images Docker', false),
                ('Déployer avec Docker Swarm', false),
                ('Étudier Kubernetes', false),
                ('Implémenter CI/CD avec Docker', false),
                ('Documenter mon projet Docker', false);
        END IF;
    END
    \$\$;

    -- Configurer les privilèges
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO todo_user;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO todo_user;
    ALTER TABLE todos OWNER TO todo_user;
EOSQL

echo "Initialisation de PostgreSQL terminée."