# 09 — État d'avancement du projet

**Dernière mise à jour : 18 novembre 2026**  
**Phase actuelle : préparation et stabilisation de l'environnement local avant redéploiement propre de n8n.**

Cette page sépare les opérations déjà réalisées, les tests observés et les tâches encore à exécuter. Les dates des essais sont conservées pour documenter le parcours.

## 1. Résumé de l'avancement

| Domaine | État | Preuve / commentaire |
|---|---|---|
| Cadrage du projet | Réalisé | Trois profils éditoriaux, deux plateformes, objectif zéro budget |
| Audit matériel Windows | Réalisé | Résultats de l'audit initial ci-dessous |
| WSL2 / Docker Desktop | Vérifié | WSL2 version par défaut 2 ; Docker Engine répond |
| Test de conteneur Docker | Réussi | `docker run --rm hello-world` |
| n8n | Déjà utilisé | Instance utilisée pour le test Telegram du 28/09/2026 ; redéploiement V1 depuis ce dépôt à faire |
| Bot Telegram | **Test fonctionnel réussi** | Message reçu puis réponse d'écho le 28/09/2026 à 17:33 |
| Configuration mémoire WSL2 | En cours | Contrôle et application de `.wslconfig` à terminer |
| Architecture documentaire | Réalisée | Schéma cible SVG + source Mermaid ajoutés au dépôt |
| Génération médias IA | À construire | Aucun moteur vidéo local validé sur le portable actuel |
| Publication YouTube / TikTok | À construire | API et validation de publication non intégrées |

## 2. Environnement matériel relevé

| Élément | Mesure communiquée |
|---|---|
| Windows | Windows 11 Professionnel, version 10.0.22631, build 22631 |
| CPU | Intel Core i5-8350U, 4 cœurs, 8 processeurs logiques |
| RAM | 8 Go détectés (7,85 Go rapportés par Windows) |
| Mémoire vive | Une barrette Micron de 8 Go détectée à 2133 MHz |
| GPU | Intel UHD Graphics 620 |
| NVIDIA/CUDA | `nvidia-smi` indisponible ; aucun GPU NVIDIA détecté |
| Volume C: | 237,45 Go au total ; 66,05 Go libres au moment de l'audit |
| Virtualisation | Hyperviseur détecté |

Ces résultats sont un instantané. L'espace libre et l'utilisation mémoire devront être remesurés avant toute installation de modèle ou de service volumineux.

## 3. Socle logiciel vérifié

| Composant | Résultat | État |
|---|---|---|
| WSL | `wsl --status` : distribution par défaut `docker-desktop`, version par défaut 2 | Vérifié |
| WSL en fonctionnement | `docker-desktop` apparaît dans `wsl --list --running` | Vérifié lors du contrôle |
| Docker Desktop | 4.90.0 | Vérifié |
| Docker Client | 29.7.2 | Vérifié |
| Docker Engine | 29.7.2, serveur `linux/amd64` visible | Vérifié |
| `docker ps` | Aucune application en cours d'exécution lors du contrôle | Normal à ce stade |
| `hello-world` | Le message de confirmation Docker a été exécuté/observé | Test réussi |

La sortie `wsl --version` communiquée affichait les versions MSRDC, Direct3D, DXCore et Windows, mais ne montrait pas explicitement une version du noyau WSL. Cette valeur n'est donc pas renseignée.

## 4. Test Telegram déjà réalisé — 28 septembre 2026

La connexion entre n8n et le bot Telegram a déjà été testée sur l'instance de travail. Le journal partagé montre le message suivant :

```text
[28/09/2026 17:33] Nabil: test n8n
[28/09/2026 17:33] OpenContentAI: Reçu : test n8n
```

**Interprétation :** le test confirme que, sur cette instance de travail, le déclencheur Telegram a reçu un message et que le workflow a renvoyé une réponse au chat. Il s'agit d'un test d'écho simple ; il ne valide pas encore le système complet de boutons `APPROUVER / REJETER / MODIFIER`, ni le pipeline de génération, ni la publication.

**Pour la version publique :** le workflow `TEST-001-telegram-echo.json` est un export assaini. Il ne contient pas le jeton du bot ni les credentials n8n. Il faudra connecter un credential Telegram local et refaire un test après import sur une nouvelle instance. Le test historique reste néanmoins une réalisation déjà accomplie et doit être mentionné dans le parcours du projet.

## 5. Fichiers et prototypes présents dans le dépôt

- `docker/docker-compose.yml` : configuration de n8n ; Ollama est optionnel et protégé par le profil `ia-locale`.
- `workflows/PIPELINE-000-skeleton.json` : squelette logique du futur pipeline.
- `workflows/PIPELINE-001-ollama-script.json` : prototype d'appel HTTP à Ollama pour proposer un script ; à tester lorsque le service est disponible.
- `workflows/TEST-000-smoke.json` : test manuel simple.
- `workflows/TEST-001-telegram-echo.json` : export assaini du test Telegram d'écho déjà réalisé historiquement ; à reconnecter et retester après import.

La présence d'un fichier dans le dépôt ne garantit pas à elle seule que ce fichier fonctionne dans une instance n8n fraîche. Les tests d'import restent à réaliser.

## 6. Assainissement effectué pour la publication publique

- Retrait du fichier `.env` local de l'archive publique ; seul `.env.example` est conservé.
- Exclusion du dossier `.git` de l'archive partageable ; l'historique Git reste dans le dossier local d'origine.
- Suppression de l'ancienne URL de tunnel ngrok du fichier Compose.
- Remplacement de l'identifiant de chat Telegram personnel par l'identifiant du chat expéditeur dans le workflow exporté.
- Suppression des credentials et métadonnées propres à l'instance n8n dans les exports.
- Désactivation de tous les workflows d'exemple dans la version publique.
- Passage d'Ollama en service Docker facultatif afin qu'il ne démarre pas par défaut.
- Liaison du port n8n à `127.0.0.1` pour limiter l'accès à la machine locale.

## 7. Étape actuelle et prochaines tâches

| Ordre | Tâche | État |
|---:|---|---|
| 1 | Audit matériel initial | Terminé |
| 2 | Vérification Docker Desktop / Engine | Terminé |
| 3 | Test `hello-world` | Terminé |
| 4 | Vérification de WSL2 (version par défaut 2) | Terminé |
| 5 | Vérifier si `%UserProfile%\.wslconfig` existe et lire son contenu avant modification | Terminé |
| 6 | Appliquer les limites WSL2 si le fichier et l'environnement le permettent | À faire |
| 7 | Vérifier Resource Saver dans Docker Desktop | À faire |
| 8 | Préparer l'arborescence locale des données | À faire |
| 9 | Faire un premier démarrage contrôlé de n8n avec le Compose public | À faire |
| 10 | Importer et retester le workflow Telegram assaini | À faire |
| 11 | Tester les workflows smoke et Ollama (ce dernier seulement si les ressources le permettent) | À faire |
| 12 | Construire les validations Telegram avec boutons et états | À faire |
| 13 | Intégrer la publication YouTube puis TikTok | À faire |
| 14 | Ajouter les profils TECH, SPORT et STORIES au moteur | À faire |
| 15 | Ajouter analytics et tableau de suivi | À faire |

## 8. Décision pour la suite

Continuer en local sans budget. Finaliser d'abord la gestion des ressources WSL2, préparer les répertoires et redéployer n8n seul. Le test Telegram historique est acquis ; la prochaine validation consiste à réimporter l'export assaini dans l'instance propre et à vérifier que le credential peut être reconnecté.

Ne pas installer de modèle vidéo lourd et ne pas louer de serveur à ce stade. Tout ajout de modèle doit être précédé d'une estimation de stockage et d'un test de consommation RAM/CPU.
