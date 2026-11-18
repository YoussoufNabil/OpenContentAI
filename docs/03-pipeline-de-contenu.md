# 03 — Pipeline de contenu

## Chaîne cible

```text
IDÉE
  -> SÉLECTION
  -> RECHERCHE
  -> SCRIPT
  -> VÉRIFICATION
  -> SCÈNES
  -> VOIX
  -> VISUELS
  -> RENDU
  -> SOUS-TITRES
  -> CONTRÔLE QUALITÉ
  -> VALIDATION HUMAINE
  -> PUBLICATION
  -> ANALYSE
```

## États de contenu

| État | Signification |
|---|---|
| `IDEA` | Sujet proposé |
| `SELECTED` | Sujet choisi par l'éditeur |
| `RESEARCH` | Recherche et collecte des sources |
| `SCRIPTING` | Rédaction du script |
| `FACT_CHECK` | Vérification des affirmations |
| `SCENES` | Découpage narratif et visuel |
| `VOICE` | Génération ou enregistrement de la voix |
| `VISUALS` | Préparation des images et plans |
| `RENDERING` | Montage et export |
| `QA` | Contrôles automatiques |
| `WAITING_REVIEW` | En attente de validation humaine |
| `APPROVED` | Approbation explicite enregistrée |
| `REWORK` | Correction demandée |
| `REJECTED` | Contenu rejeté |
| `PUBLISHED` | Publication confirmée par la plateforme |
| `FAILED` | Étape en échec ; aucune publication autorisée |
| `ANALYZED` | Statistiques enregistrées |

## Règle de validation

Aucune branche ne doit publier par défaut. Seul un événement d'approbation explicite, rattaché au bon identifiant de contenu et à la bonne version, peut déclencher la publication.

Un délai dépassé, un callback inconnu, un fichier manquant, une vérification échouée ou un statut inattendu doit bloquer la suite.

## Reprise après correction

Lorsqu'une modification ne concerne qu'une scène ou la voix, régénérer uniquement l'étape concernée si ses dépendances n'ont pas changé. Le système doit conserver les versions précédentes et les raisons de correction.

## Profil STORIES : cohérence narrative

Chaque scène doit être définie avec au minimum :

- identifiant et ordre de la scène ;
- passage du script et durée estimée ;
- personnages présents et caractéristiques constantes ;
- lieu, période et ambiance ;
- action visible ;
- cadrage et mouvement de caméra ;
- prompt visuel ;
- source si l'histoire est réelle ou adaptée.

Le visuel doit illustrer précisément la narration correspondante. Les plans génériques sans rapport avec l'histoire sont à rejeter.
