# Projet Todo List avec Docker

Application Todo List avec une API Symfony connectée à une base de données PostgreSQL, entièrement conteneurisée avec Docker.

## Prérequis

- Docker
- Docker Compose

## Démarrage rapide

```bash
# Méthode 1 : Lancement avec le script automatisé
./run.sh

# Méthode 2 : Lancement manuel
# Démarrer la base de données
cd db
docker-compose up -d

# Démarrer l'application
cd ../app
docker-compose up -d
```

## Accès à l'application

- **Application Todo List**: http://localhost:8000
- **API**: http://localhost:8000/api/todos
- **Adminer** (gestion de BDD): http://localhost:8081

## Connexion à Adminer

- **Système**: PostgreSQL
- **Serveur**: postgres
- **Utilisateur**: postgres
- **Mot de passe**: postgres (ou celui défini dans .env)
- **Base de données**: todo_db

## Structure du projet

```
todo-app/
├── run.sh                    # Script de lancement
├── db/                       # Services de base de données
│   ├── docker-compose.yml    # PostgreSQL et Adminer
│   └── ...
└── app/                      # Services d'application
    ├── docker-compose.yml    # Symfony et Composer
    └── ...
```

## Caractéristiques

- Images Docker personnalisées basées sur Alpine Linux
- Base de données PostgreSQL avec 10 todos pré-enregistrés
- Interface Adminer pour gérer la base de données
- API Symfony pour accéder aux todos
- Interface utilisateur pour visualiser les todos
- Séparation des services (base de données et application)

## Configuration

Les fichiers `.env` dans les dossiers `db/` et `app/` permettent de configurer les variables d'environnement pour chaque service.
