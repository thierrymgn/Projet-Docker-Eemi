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
