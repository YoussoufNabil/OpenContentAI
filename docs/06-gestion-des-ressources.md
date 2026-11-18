# 06 — Gestion des ressources

## Mesurer avant d'installer

Pour chaque composant, relever :

- taille de l'image Docker ou du modèle ;
- espace disque avant/après installation ;
- RAM au repos et en charge ;
- VRAM, si un GPU compatible existe ;
- CPU utilisé ;
- durée de génération ;
- taille des fichiers produits.

## Contraintes de la machine actuelle

La machine auditée dispose de 8 Go de RAM et d'une Intel UHD 620, sans GPU NVIDIA détecté. Elle doit être considérée comme une machine d'orchestration et de prototypage léger, pas comme une station de génération vidéo IA lourde.

## Démarrage progressif

- n8n seul au démarrage ;
- Ollama en service facultatif, lancé uniquement pour les tests de génération ;
- un seul modèle chargé à la fois ;
- une seule génération lourde à la fois ;
- aucun cache vidéo ou modèle volumineux téléchargé sans estimation de taille.

## Organisation du stockage

Répertoire de données suggéré sur la machine actuelle :

```text
C:\OpenContentAI-Data\
├── models\
├── projects\
├── temp\
├── published\
└── archive\
```

Ce répertoire est un emplacement de travail local, pas une partie du dépôt Git. Adapter le chemin si un autre disque devient disponible.

## Nettoyage et diagnostic

```powershell
docker system df
docker ps -a
docker volume ls
Get-Volume | Where-Object DriveLetter |
  Select-Object DriveLetter,
    @{N='Libre_Go';E={[math]::Round($_.SizeRemaining/1GB,2)}}
```

Ne pas exécuter `docker system prune --volumes` sans vérifier les volumes : cette commande peut supprimer des données persistantes utiles.

## Seuil d'arrêt

Si Windows devient instable, si la mémoire disponible devient trop faible ou si le disque passe sous le seuil de sécurité fixé pour la machine, arrêter le service facultatif et reporter l'essai. Ne pas augmenter les limites WSL sans réévaluer les ressources de Windows.
