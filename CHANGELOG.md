# Journal des modifications

## 2026-11-18 — Réorganisation documentaire et assainissement du dépôt

- Traduction en français du README principal, des guides et des README de sous-répertoires.
- Ajout d'un état d'avancement fondé sur les résultats d'audit communiqués.
- Ajout d'un journal de laboratoire, d'un guide de préparation à GitHub et d'un script PowerShell d'audit réutilisable.
- Suppression du fichier `.env` local et du dossier `.git` de l'archive partageable.
- Suppression de l'ancienne URL ngrok intégrée au fichier Docker Compose.
- Remplacement de l'identifiant de chat Telegram personnel par l'identifiant du chat expéditeur.
- Suppression des credentials et métadonnées d'instance des workflows exportés.
- Désactivation de tous les workflows d'exemple.
- Passage d'Ollama à un profil Docker facultatif afin de ne pas le démarrer par défaut.
- Liaison du port n8n à l'interface locale `127.0.0.1`.
- Correction de l'expression du prompt dans le prototype Ollama pour injecter le sujet dynamique.

Les workflows restent à importer et tester dans l'environnement n8n local. Cette réorganisation ne constitue pas une validation de bout en bout.

## 2026-11-18 — Architecture visuelle et mise à jour de l'avancement

- Ajout d'un schéma d'architecture cible au format SVG, visible directement dans GitHub, ainsi que de sa source Mermaid modifiable.
- Ajout au README d'un résumé explicite de l'étape actuelle du projet.
- Mise à jour de l'état d'avancement avec le test Telegram d'écho réussi le 28 septembre 2026 à 17:33.
- Ajout de l'échange de test exact dans la documentation et dans le guide des workflows n8n.
- Distinction entre le test Telegram réussi sur l'instance de travail et le nouvel export public assaini, qui doit être reconnecté et retesté après import.
- Clarification des éléments encore non réalisés : limites WSL2, redéploiement n8n depuis le dépôt, pipeline média et publication YouTube/TikTok.
