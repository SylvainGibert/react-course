# &nbsp;
# &nbsp;
# &nbsp;
# +
# Git-Flow

<!-- .slide: data-background-size="cover" data-background-image="images/gitflow/git-3840x2160.png" -->

---

# Installation

--

## CLI FTW!
### OSX (Homebrew / Macports)
```bash
  $ brew install git-flow-avh
  $ port install git-flow-avh
```
### Linux
```bash
  $ apt-get install git-flow
```
### Windows (Cygwin)
```bash
  $ wget -q -O - --no-check-certificate https://goo.gl/n7Wdwa install stable | bash
```
 <!-- .element: style="width: 101%;" -->

---

<!-- .slide: data-background="#b0e0e6" data-background-repeat="no-repeat" data-background-position="90% 0" data-background-size="contain" data-background-image="images/gitflow/1.png" -->
```bash
git flow init
```
 <!-- .element: style="max-width: 60%;" -->

- **master** : La production
- **develop** : La _pré_-production
- **feature/** : Ajout de fonctionnalité (support, projet)
- **release/** : Préparation de mise en ligne
- **hotfix/** : Correction de bug en production
- **support/** : Intérvenants externes

Note:

Pour initialiser un repo git existant :

`git flow init`

Conservez le nommage des branches par défaut

--

<!-- .slide: data-background="#b0e0e6" data-background-repeat="no-repeat" data-background-position="90% 0" data-background-size="contain" data-background-image="images/gitflow/1.png" -->
```bash
git flow feature start MYFEATURE
```
 <!-- .element: style="max-width: 60%;" -->
Note:

Ajouter une branche de fonctinnalité à partir de la branche 'develop'

`git flow feature start MYFEATURE`

--

<!-- .slide: data-background="#b0e0e6" data-background-repeat="no-repeat" data-background-position="90% 0" data-background-size="contain" data-background-image="images/gitflow/2-bis.png" -->

```bash
git flow feature publish MYFEATURE
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git flow feature pull origin MYFEATURE
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git flow feature finish MYFEATURE
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->


Note:

Publiez une fonctionnalité sur le serveur distant pour qu'elle puisse être utilisée par d'autres utilisateurs.

`git flow feature publish MYFEATURE`

Récupérez une fonctionnalité publiée par un autre utilisateur

`git flow feature pull origin MYFEATURE`

Vous pouvez suivre une fonctionnalité sur le serveur distant en utilisant

`git flow feature track MYFEATURE`


La commande `git flow feature finish MYFEATURE` termine le développement d'une fonctionnalité. 
Cette action effectue les opérations suivantes :
- Fusionne MYFEATURE dans 'develop'
- Supprime la branche de fonctionnalité
- Passe sur la branche 'develop'

**Mais nous n'utiliserons pas ceci, en effet nous ferons toujours une PR pour merger une feature dans `develop`**

--

<!-- .slide: data-background="#b0e0e6" data-background-repeat="no-repeat" data-background-position="90% 0" data-background-size="contain" data-background-image="images/gitflow/2.png" -->
```bash
git flow feature start MYFEATURE
```
 <!-- .element: style="max-width: 60%;" -->
```bash
git flow feature publish MYFEATURE
```
 <!-- .element: style="max-width: 60%;" -->
>Merge pull request 
>>`git flow feature finish MYFEATURE`<!-- .element: style="font-size: 45%;" -->

 <!-- .element: style="max-width: 60%;" -->

Note:

Le développement de fonctionnalité se fera donc ainsi :
- Initialisation de la branche de fonctionnalité
  + `git flow feature start MYFEATURE`
- Publication de la branche de fonctionnalité
  + `git flow feature publish MYFEATURE`
- Création de la PR
- Merge de la PR, et suppression de la branche, pour terminer la fonctionnalité

--

<!-- .slide: data-background="#b0e0e6" data-background-repeat="no-repeat" data-background-position="90% 0" data-background-size="contain" data-background-image="images/gitflow/3.png" -->

```bash
git flow release start vX.Y.Z [BASE]
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git flow release publish vX.Y.Z
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git flow release finish vX.Y.Z
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git push --tags
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->

Note:

Commencez une mise en production (release) avec la commande

`git flow release start RELEASE [BASE]`

cela créer une branche de release basée sur la branche de développement.

Il est possible d'ajouter le paramètre [BASE], le hash d'un commit à partir duquel commencera la release. 
Ce commit doit faire partie de la branche de développement.

Il est préférable de publier la branche de release après l'avoir créée pour permettre aux autres développeurs de commiter dessus.

`git flow release publish RELEASE`

La commande

`git flow release finish RELEASE`

termine une release en effectuant les actions suivantes :

- Fusionne la branche de release dans la branche 'master'
- Tag la release par son nom
- Fusionne la release dans la branche 'develop'
- Supprime la branche de release

__Ne pas oublier de pousser les tags avec `git push --tags`__

__Puis mise en ligne de la branche `master` avec Capistrano/Capifony__

--

<!-- .slide: data-background="#b0e0e6" data-background-repeat="no-repeat" data-background-position="90% 0" data-background-size="contain" data-background-image="images/gitflow/4.png" -->

```bash
git flow hotfix start vX.Y.Z+1 [BASENAME]
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git flow hotfix finish vX.Y.Z+1
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->
```bash
git push --tags
```
 <!-- .element: style="max-width: 60%;" class="fragment current-visible" -->

Note:

S'il y a détection d'un bug en production on peut le corriger à partir de la branche `master` en créant un `hotfix`.
Le workflow suit la même procédure qu'une release à savoir :

- Création de la branche hotfix avec `git flow hotfix start vX.Y.Z+1 [BASENAME]` ([BASENAME] pouvant être remplacé par un tag de release comme point de départ) par défaut la branche se créer depuis le master
- Publication du hotfix avec `git flow hotfix finish vX.Y.Z+1`

__Ne pas oublier de pousser les tags avec `git push --tags`__

__Puis mise en ligne de la branche `master` avec Capistrano/Capifony__

---

# Règles sur les branches

--

## Feature 

- Doivent être crées à partir de :
  + develop
- Doivent être mergées dans :
  + develop
- Convention de nommage :
  + feature/RÉFÉRENCE_JIRA

--

## Release

- Doivent être crées à partir de :
  + develop
- Doivent être mergées dans :
  + develop & master
- Convention de nommage :
  + release/vX.Y.Z

--

## Hotfix

- Doivent être crées à partir de :
  + master
- Doivent être mergées dans :
  + develop & master
- Convention de nommage :
  + hotfix/vX.Y.Z+1

---

# Utilisation de Git-Flow

--

## En ligne de commande
![](images/gitflow/git-flow-commands.png) <!-- .element: class="plain" -->

--

## Avec PhpStorm

--

## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-size="contain" data-background-image="images/gitflow/phpstorm1.JPG" -->

--

## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-size="contain" data-background-image="images/gitflow/phpstorm2.JPG" -->

--

## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-size="contain" data-background-image="images/gitflow/phpstorm3.JPG" -->

--

## Avec GitKraken

--

## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-size="contain" data-background-image="images/gitflow/git-kraken.JPG" -->

--

## Avec SourceTree

--

## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-size="contain" data-background-image="images/gitflow/sourcetree.png" -->

## &nbsp;
![](images/gitflow/gitflowsupport1.jpg)  <!-- .element: class="plain" -->

---

## Gestion sémantique de version

>Étant donné un numéro de version MAJEUR.MINEUR.CORRECTIF (X.Y.Z), il faut incrémenter :
>
> - le numéro de version MAJEUR (x) quand il y a des changements non rétrocompatibles,
> - le numéro de version MINEUR (y) quand il y a des changements rétrocompatibles,
> - le numéro de version de CORRECTIF (z) quand il y a des corrections d’anomalies rétrocompatibles

 <!-- .element: style="width: 100%; text-align: left;" -->

---

# Tips and Tricks

--

Supprimer les branches locales qui sont mergées
```bash
git branch --merged | grep -v "\*" | grep -v "master" | grep -v "master-bis" | grep -v "develop" | grep -v "staging" | xargs -n 1 git branch -d
```

--

## Hooks Git post-merge
Mise à jour auto des paquets NPM et Composer

```bash
#!/bin/sh
# MIT © Sindre Sorhus - sindresorhus.com https://gist.github.com/sindresorhus/7996717

# git hook to run a command after `git pull` if a specified file was changed
# Run `chmod +x post-merge` to make it executable then put it into `.git/hooks/`.

changed_files="$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)"

check_run() {
  echo "$changed_files" | grep --quiet "$1" && eval "$2"
}

# Example usage
# In this example it's used to run `npm install` if package.json changed
if [ check_run package.json ]; then
  echo "package.json has changed. Installing"
  npm install && npm prune
fi
if [ check_run composer.json ]; then
  echo "composer.json has changed. Installing"
  docker exec pbs sh -c 'cd /var/www/frontend && composer install --verbose --prefer-dist --optimize-autoloader --no-progress --quiet'
fi
```

--

## Hooks Git post-checkout 
(à discuter)

Migrations auto du schema de BDD

```bash
#!/bin/sh
oldBranch=`git name-rev --name-only $1`
newBranch=`git name-rev --name-only $2`

if [[ $oldBranch == $newBranch ]]; then
  exit 0
fi

# Si new = feature/*
if [[ $newBranch =~ "feature" ]]; then
  docker exec pbs sh -c 'cd /var/www/frontend/dbsv/final && liquibase tag pre-'$newBranch
fi
# Si old = feature/*
if [[ $oldBranch =~ "feature" ]]; then
  docker exec pbs sh -c 'cd /var/www/frontend/dbsv/final && liquibase rollback pre-'$oldBranch''
fi

docker exec pbs sh -c 'cd /var/www/frontend/dbsv/final && liquibase update'
```

---

# Aide mémoire

- git-flow cheatsheet
  + [`https://goo.gl/WoblfK`](https://danielkummer.github.io/git-flow-cheatsheet/index.fr_FR.html)
- Gestion sémantique de version 2.0.0
  + [`http://semver.org/lang/fr/`](http://semver.org/lang/fr/)
