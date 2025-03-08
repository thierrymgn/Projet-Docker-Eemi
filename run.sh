#!/bin/bash

echo "=== Démarrage du projet Todo List avec Docker ==="

if ! command -v docker &> /dev/null; then
    echo "Docker n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

echo "Création du réseau Docker..."
docker network create db_network 2>/dev/null || true

echo "Démarrage des services de base de données..."
cd db
docker-compose up -d
if [ $? -ne 0 ]; then
    echo "Erreur lors du démarrage des services de base de données."
    exit 1
fi
echo "Services de base de données démarrés avec succès."

echo "Attente du démarrage de PostgreSQL..."
RETRIES=10
until docker exec -it todos_postgres pg_isready -U ${POSTGRES_USER:-todo_user} || [ $RETRIES -eq 0 ]; do
  echo "En attente de PostgreSQL... $(( 10 - RETRIES )) secondes écoulées"
  RETRIES=$((RETRIES-1))
  sleep 1
done

if [ $RETRIES -eq 0 ]; then
  echo "PostgreSQL n'a pas démarré à temps, mais on continue..."
else
  echo "PostgreSQL est prêt!"
fi

echo "Démarrage des services d'application..."
cd ../app
docker-compose up -d
if [ $? -ne 0 ]; then
    echo "Erreur lors du démarrage des services d'application."
    exit 1
fi
echo "Services d'application démarrés avec succès."

echo "=== Projet Todo List démarré avec succès ==="
echo "Application accessible à : http://localhost:${APP_PORT:-8000}"
echo "API accessible à : http://localhost:${APP_PORT:-8000}/api/todos"
echo "Adminer accessible à : http://localhost:${ADMINER_PORT:-8081}"
