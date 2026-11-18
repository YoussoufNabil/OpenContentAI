# Scripts utilitaires

Ce répertoire accueille les scripts locaux pour vérifier l'environnement, préparer les dossiers de production, contrôler les médias, lancer FFmpeg et mesurer les ressources.

## Audit de la machine

Le script `Audit-Environnement.ps1` collecte les informations initiales de Windows, CPU, RAM, GPU, stockage, WSL2 et Docker. Il écrit un rapport sur le Bureau sous le nom `OpenContentAI_AUDIT.txt`.

Depuis PowerShell, à la racine du dépôt :

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\Audit-Environnement.ps1
```

Le changement de stratégie ne vaut que pour la session PowerShell actuelle. Le script n'installe rien et ne modifie pas WSL ou Docker. Il ne lance pas de test CUDA ni ne télécharge d'image NVIDIA.

Avant de partager le rapport, relire son contenu et masquer le nom de l'utilisateur, les chemins privés et toute information personnelle.

## Règles pour les futurs scripts

Chaque script devra préciser ses prérequis, paramètres, sorties, effets de bord et méthode de test. Les scripts destructifs devront demander une confirmation explicite.
