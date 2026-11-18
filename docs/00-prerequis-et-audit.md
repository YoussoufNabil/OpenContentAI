# 00 — Prérequis et audit initial

## Objectif

Établir les capacités réelles de la machine avant d'installer des services ou de télécharger des modèles. Les valeurs ci-dessous proviennent de l'audit PowerShell communiqué pour le projet.

## Résultats de l'audit initial

| Élément | Résultat observé | Conséquence pour OpenContentAI |
|---|---|---|
| Système | Windows 11 Professionnel, build 22631 | Hôte principal retenu |
| Processeur | Intel Core i5-8350U, 4 cœurs / 8 processeurs logiques | Suffisant pour orchestration et traitements légers ; génération lourde limitée |
| Mémoire | 8 Go (une barrette Micron de 8 Go détectée, 2133 MHz) | Ressource critique ; limiter les services simultanés |
| Graphiques | Intel UHD Graphics 620 | Pas de GPU NVIDIA/CUDA détecté ; génération vidéo locale lourde non retenue pour la V1 |
| Stockage C: | 237,45 Go au total, 66,05 Go libres | Éviter les modèles et caches volumineux |
| Virtualisation | Hyperviseur détecté | Virtualisation disponible |
| WSL | Distribution par défaut `docker-desktop`, version WSL 2 | Backend WSL2 déjà utilisé par Docker Desktop |
| Docker | Desktop 4.90.0 ; client et moteur 29.7.2 | Communication client/serveur vérifiée |

**Date de référence de la fiche : 18 novembre 2026.** Les capacités libres évoluent ; refaire les mesures avant toute installation volumineuse.

## Commandes d'audit

À exécuter dans PowerShell :

```powershell
Get-CimInstance Win32_OperatingSystem |
  Select-Object Caption, Version, BuildNumber, OSArchitecture

Get-CimInstance Win32_Processor |
  Select-Object Name, NumberOfCores, NumberOfLogicalProcessors

Get-CimInstance Win32_ComputerSystem |
  Select-Object @{N='RAM_Go';E={[math]::Round($_.TotalPhysicalMemory/1GB,2)}}

Get-CimInstance Win32_VideoController |
  Select-Object Name, DriverVersion

Get-Volume | Where-Object DriveLetter |
  Select-Object DriveLetter, FileSystemLabel,
    @{N='Taille_Go';E={[math]::Round($_.Size/1GB,2)}},
    @{N='Libre_Go';E={[math]::Round($_.SizeRemaining/1GB,2)}}

wsl --status
wsl --list --verbose
docker version
docker info
docker run --rm hello-world
```

## Points non confirmés à ce stade

- La présence et le contenu du fichier `%USERPROFILE%\.wslconfig` n'ont pas encore été confirmés dans le journal de suivi.
- Les limites WSL2 (mémoire, processeurs, swap) ne sont pas considérées comme appliquées tant que les commandes de vérification n'ont pas été partagées.
- L'option Resource Saver de Docker Desktop reste à vérifier.
- Aucun test GPU NVIDIA n'est applicable à la configuration observée ; aucun GPU NVIDIA n'a été détecté.
- Le débit Internet n'a pas été mesuré dans cet audit.

## Décision matérielle pour la V1

1. Garder Windows 11 comme hôte.
2. Utiliser Docker Desktop avec WSL2 pour les services légers.
3. Ne pas créer de VM Linux permanente sans besoin précis.
4. Ne pas installer de génération vidéo lourde locale sur cette machine.
5. Ne pas télécharger de gros modèles avant d'avoir mesuré l'espace et la mémoire réellement disponibles.
6. Privilégier les versions locales légères et les outils gratuits ; toute API payante reste désactivée par défaut.

## Preuves à archiver

Placer les captures dans `docs/captures/` :

- `00-01-audit-windows.png` : résumé Windows, CPU, RAM et GPU ;
- `00-02-stockage.png` : capacités et espace libre des volumes ;
- `00-03-wsl.png` : statut et distributions WSL ;
- `00-04-docker-version.png` : client et serveur Docker ;
- `00-05-hello-world.png` : exécution réussie du conteneur de test.

Masquer les noms d'utilisateur, chemins privés, identifiants et toute donnée sensible avant publication.
