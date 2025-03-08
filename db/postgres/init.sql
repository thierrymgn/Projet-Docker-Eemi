CREATE
USER IF NOT EXISTS todo_user WITH PASSWORD 'secret_password';
CREATE
DATABASE IF NOT EXISTS todo_db OWNER todo_user;

\c
todo_db;

CREATE TABLE IF NOT EXISTS todos
(
    id
    SERIAL
    PRIMARY
    KEY,
    title
    VARCHAR
(
    255
) NOT NULL,
    done BOOLEAN NOT NULL DEFAULT FALSE
    );

INSERT INTO todos (title, done)
SELECT 'Apprendre Docker',
       true WHERE NOT EXISTS (SELECT 1 FROM todos LIMIT 1);

INSERT INTO todos (title, done)
SELECT 'Créer un Dockerfile',
       true WHERE NOT EXISTS (SELECT 1 FROM todos LIMIT 1);

CREATE TABLE todos
(
    id    SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    done  BOOLEAN      NOT NULL DEFAULT FALSE
);

INSERT INTO todos (title, done)
VALUES ('Apprendre Docker', true),
       ('Créer un Dockerfile', true),
       ('Comprendre docker-compose', false),
       ('Maîtriser les volumes Docker', false),
       ('Configurer des réseaux Docker', false),
       ('Optimiser les images Docker', false),
       ('Déployer avec Docker Swarm', false),
       ('Étudier Kubernetes', false),
       ('Implémenter CI/CD avec Docker', false),
       ('Documenter mon projet Docker', false);
