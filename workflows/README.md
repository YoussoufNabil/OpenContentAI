# Workflows n8n

Ce répertoire contient des exports d'exemple nettoyés. Ils sont tous **désactivés** dans l'archive publique.

| Fichier | Objet | État / niveau de maturité |
|---|---|---|
| `TEST-000-smoke.json` | Vérifier un déclenchement manuel et la création de données de test | Exemple à importer et tester dans l'instance cible |
| `PIPELINE-000-skeleton.json` | Montrer les étapes logiques du pipeline | Squelette, non opérationnel de bout en bout |
| `PIPELINE-001-ollama-script.json` | Appeler l'API locale Ollama pour proposer un script | Prototype à tester avec Ollama démarré ; facultatif sur une machine à faible RAM |
| `TEST-001-telegram-echo.json` | Répondre au message Telegram reçu | La liaison Telegram et le test d'écho ont déjà réussi sur l'instance de travail le 28/09/2026 ; cet export assaini doit être reconnecté puis retesté après import |

## Test Telegram historique

Le 28 septembre 2026 à 17:33, le test réalisé sur l'instance n8n de travail a produit cet échange :

```text
[28/09/2026 17:33] Nabil: test n8n
[28/09/2026 17:33] OpenContentAI: Reçu : test n8n
```

Ce résultat confirme le chemin de base **Telegram Trigger → nœud d'envoi Telegram** sur cette instance. Il ne valide pas encore les boutons d'approbation, la génération vidéo ou la publication sur les plateformes.

## Avant l'import

1. Vérifier que n8n fonctionne.
2. Ouvrir **Workflows → Import from file** dans l'interface n8n.
3. Importer un seul fichier à la fois.
4. Reconnecter manuellement le credential Telegram local dans les nœuds concernés.
5. Garder le workflow désactivé jusqu'à la fin des tests.
6. Envoyer un message de test et vérifier la réponse dans Telegram.

Les fichiers ne contiennent volontairement aucun jeton, credential ni identifiant de conversation personnel. Le workflow Telegram utilise l'identifiant du chat qui a envoyé le message reçu.

## Export avant contribution

Avant de publier un export, retirer les credentials, identifiants d'instance, valeurs de chat privées, chemins locaux et données d'exécution. Vérifier le JSON et le tester après import.
