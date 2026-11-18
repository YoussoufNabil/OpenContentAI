# 10 — Préparer et publier le dépôt sur GitHub

## Contenu à publier

Le dépôt public doit contenir le code, les workflows d'exemple nettoyés, la documentation et les modèles de configuration sans secrets.

L'archive de partage est volontairement fournie sans dossier `.git` et sans fichier `.env`. Cela évite de distribuer l'historique local ou une configuration privée.

## Mise à jour du dossier de travail existant

Si le dépôt Git existe déjà sur la machine :

1. Faire une copie de sauvegarde du dossier du projet.
2. Extraire l'archive `OpenContentAI_GitHub_FR.zip` dans un dossier temporaire.
3. Copier le contenu du dossier `OpenContentAI` extrait dans le dossier du dépôt local existant.
4. **Conserver le dossier `.git` local** afin de ne pas perdre l'historique.
5. Conserver le `.env` local hors de Git ; ne jamais le copier dans l'archive publique.
6. Examiner les modifications avant de les ajouter.

## Contrôles avant commit

Dans PowerShell, à la racine du dépôt :

```powershell
git status --short
git check-ignore -v .env
git ls-files .env
```

La commande `git ls-files .env` ne doit rien retourner. Si elle retourne un chemin, le fichier a déjà été suivi par Git : ne pas pousser avant d'avoir traité ce cas.

Vérifier aussi qu'aucun jeton, identifiant personnel, URL de tunnel ou capture sensible n'a été ajouté.

## Commit de la réorganisation

```powershell
git add -A
git status --short
git commit -m "docs: réorganisation et documentation française"
```

Avant `git push`, vérifier le dépôt distant :

```powershell
git remote -v
git branch --show-current
```

Pousser uniquement vers le dépôt GitHub que tu contrôles et après revue du diff.

## Informations de présentation suggérées

**Nom :** `OpenContentAI`  
**Description :** `Plateforme locale et modulaire de production de contenu assistée par IA, avec validation humaine avant publication YouTube et TikTok.`  
**Sujets GitHub :** `n8n`, `docker`, `automation`, `ollama`, `ai-content`, `youtube-api`, `tiktok-api`, `human-in-the-loop`, `self-hosted`.

## Avant d'ouvrir le dépôt au public

- [ ] README principal en français relu.
- [ ] Aucun `.env` ni secret.
- [ ] Aucun identifiant privé dans les workflows.
- [ ] Tous les workflows d'exemple sont désactivés.
- [ ] URL ngrok/tunnel retirée.
- [ ] Captures contrôlées et anonymisées.
- [ ] Licence et licences des ressources tierces vérifiées.
- [ ] Les éléments non testés sont explicitement présentés comme tels.
