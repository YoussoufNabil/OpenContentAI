# 05 — Sécurité et gestion des secrets

## Informations à ne jamais versionner

- fichier `.env` ;
- clés API et secrets OAuth ;
- jetons et identifiants de bots Telegram ;
- cookies, sessions et données de navigateur ;
- credentials n8n exportés ou identifiants d'instances privées ;
- identifiants personnels de comptes et de conversations ;
- URL de tunnel temporaire ;
- médias privés ou fichiers non redistribuables.

## Configuration locale

Le dépôt contient uniquement `.env.example`. Pour une utilisation locale, le copier vers `.env`, renseigner les valeurs nécessaires et vérifier que `.env` est ignoré par Git :

```powershell
git check-ignore -v .env
git status --short
```

Ne jamais coller un secret dans un ticket, un commit, une capture d'écran ou une demande d'assistance.

## n8n

- Conserver le volume `n8n_data` : il contient la configuration et les credentials chiffrés.
- Ne pas publier ce volume ni son export.
- Configurer les credentials Telegram et plateformes dans l'interface n8n.
- Garder l'interface accessible uniquement sur `localhost` durant le développement.
- Ne pas exposer directement le port n8n sur Internet.

## Webhooks

Un webhook Telegram nécessite une URL HTTPS accessible depuis Internet. Configurer le tunnel uniquement dans le `.env` local, pour la durée nécessaire. Ne jamais publier son domaine ni son URL de callback.

## Publication

Privilégier les API officielles et les flux OAuth documentés. Ne jamais stocker des mots de passe de compte dans un workflow n8n.
