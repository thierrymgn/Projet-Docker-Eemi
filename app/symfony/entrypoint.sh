#!/bin/sh
set -e

echo "Attente de la disponibilité de PostgreSQL..."
timeout=60
counter=0
until pg_isready -h ${DB_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_USER} || [ $counter -eq $timeout ]
do
    echo "En attente de PostgreSQL... ${counter}s"
    sleep 1
    counter=$((counter+1))
done

if [ $counter -eq $timeout ]; then
    echo "Timeout atteint: PostgreSQL n'est pas disponible. Sortie."
    exit 1
fi

echo "PostgreSQL est disponible."

echo "Mise à jour du schéma de la base de données..."
php bin/console doctrine:schema:update --force --no-interaction || true

echo "Vidage du cache..."
php bin/console cache:clear --no-interaction || true

echo "Installation des assets..."
php bin/console assets:install --no-interaction || true

echo "Démarrage des services..."
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
