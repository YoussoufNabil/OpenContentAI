# Docker et environnement local

Ce répertoire contient la configuration minimale de conteneurisation.

## Services

| Service | Démarrage | Rôle |
|---|---|---|
| `n8n` | Par défaut | Orchestration des workflows |
| `ollama` | Profil facultatif `ia-locale` | Génération de texte avec un modèle local |

Ollama n'est pas lancé par défaut afin de préserver les ressources de la machine.

## Préparer la configuration locale

Depuis la racine du dépôt :

```powershell
Copy-Item .env.example .env
```

Le fichier `.env` est local et ignoré par Git. Ne jamais le joindre à un ticket ou à un commit.

## Démarrer n8n seul

```powershell
docker compose --env-file .env -f docker/docker-compose.yml up -d n8n
docker compose --env-file .env -f docker/docker-compose.yml ps
docker compose --env-file .env -f docker/docker-compose.yml logs --tail 80 n8n
```

Ouvrir ensuite `http://localhost:5678`.

## Démarrer Ollama en option

Uniquement après vérification de la mémoire disponible :

```powershell
docker compose --env-file .env -f docker/docker-compose.yml --profile ia-locale up -d n8n ollama
docker compose --env-file .env -f docker/docker-compose.yml logs --tail 80 ollama
```

Depuis le conteneur n8n, l'adresse d'Ollama est `http://ollama:11434`. Ne pas utiliser `localhost` pour joindre un autre conteneur.

## Arrêter les services

```powershell
docker compose --env-file .env -f docker/docker-compose.yml down
```

Les volumes sont conservés. Ne pas utiliser `docker compose down -v` si les données n8n ou Ollama doivent être gardées.

## Précautions propres à la machine actuelle

Le poste de développement dispose de 8 Go de RAM et d'environ 66 Go libres au moment de l'audit. Commencer par n8n seul. Ollama et tout modèle doivent être activés et téléchargés séparément, après mesure de l'espace disque. Aucune génération vidéo lourde n'est prévue sur ce poste dans la V1.
