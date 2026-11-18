# 02 — Installation séquentielle

Ce document décrit l'ordre prévu. Une étape n'est considérée comme terminée qu'après exécution et vérification des commandes correspondantes.

## Phase 0 — Audit

- [x] Audit initial Windows, CPU, RAM, GPU et stockage réalisé.
- [x] Version du client et du moteur Docker relevée.
- [x] WSL2 identifié comme backend de Docker.
- [ ] Configuration `.wslconfig` vérifiée et documentée.
- [ ] Resource Saver vérifié.

Voir `00-prerequis-et-audit.md` et `09-etat-avancement.md`.

## Phase 1 — Valider WSL2 et Docker

Dans PowerShell :

```powershell
wsl --status
wsl --list --verbose
docker version
docker info
docker run --rm hello-world
```

Le test `hello-world` doit s'exécuter sans erreur. Un `docker ps` vide est normal lorsqu'aucun service n'est lancé.

## Phase 2 — Dimensionner les ressources

Avant de créer `.wslconfig` ou de changer les limites, vérifier l'état actuel du fichier et documenter les modifications. Ne jamais écraser une configuration existante sans la lire.

La configuration proposée pendant le laboratoire est une limite WSL2 de 4 Go, 4 processeurs logiques et 2 Go de swap. Elle reste **à confirmer par les résultats de vérification** ; ce dépôt ne prétend pas qu'elle est déjà appliquée.

## Phase 3 — Préparer l'espace de travail

Créer le répertoire du projet et séparer :

- le code et la documentation versionnés ;
- les données n8n ;
- les modèles ;
- les projets vidéo temporaires ;
- les exports publiés et les archives.

Ne pas placer les vidéos ou poids de modèles dans Git.

## Phase 4 — Lancer n8n seul

Après validation des ressources :

```powershell
Copy-Item .env.example .env
docker compose --env-file .env -f docker/docker-compose.yml up -d n8n
docker compose --env-file .env -f docker/docker-compose.yml ps
docker compose --env-file .env -f docker/docker-compose.yml logs --tail 80 n8n
```

L'interface locale sera disponible à `http://localhost:5678` si le démarrage est réussi. La publication du port est limitée à `127.0.0.1`.

## Phase 5 — Ajouter Ollama seulement si la mémoire le permet

Ollama est placé dans le profil facultatif `ia-locale` :

```powershell
docker compose --env-file .env -f docker/docker-compose.yml --profile ia-locale up -d n8n ollama
docker compose --env-file .env -f docker/docker-compose.yml ps
```

Ne télécharger un modèle qu'après contrôle de la mémoire et de l'espace disque. Le modèle `llama3.2:3b` présent dans le workflow est une proposition d'essai, pas une recommandation garantie pour tout matériel.

## Phases suivantes

1. Valider l'appel n8n vers Ollama.
2. Valider un modèle de script et conserver les résultats.
3. Ajouter un moteur TTS compatible avec les ressources disponibles.
4. Définir un rendu vidéo léger et vérifier les licences des médias.
5. Ajouter la validation humaine par Telegram.
6. Construire l'adaptateur YouTube.
7. Construire l'adaptateur TikTok après vérification de l'accès API.
8. Ajouter les profils SPORT et STORIES.
9. Ajouter les mesures d'audience et l'analyse.

Ne pas installer toutes les briques d'un coup. Chaque phase doit se terminer par un test et une mise à jour du journal de bord.
