# Docker
<img style="background: transparent;" class="plain" src="images/docker/vertical.png">

--

## Environnement actuel

![/images/Env-dev.png](/images/docker/Env-dev.png)

--

## Environnement Docker

![/images/Env-docker.png](/images/docker/Env-docker.png)

--

## Environnement 
## Docker Compose

![/images/Env-docker-compose.png](/images/Env-docker/docker-compose.png)

---

## Installer Docker (Windows)

1. Activer Hyper-V dans Microsoft Windows 10 Professional ou Enterprise 64-bit
    ```bash
    $ C:\>bcdedit /copy {current} /d "No Hyper-V" 
    The entry was successfully copied to {ff-23-113-824e-5c5144ea}. 

    $ C:\>bcdedit /set {ff-23-113-824e-5c5144ea} hypervisorlaunchtype off 
    The operation completed successfully.
    ```
2. Télécharger et Installer Docker : <span style="text-transform: none;">[https://goo.gl/RPll9A](https://goo.gl/RPll9A)</span>

--

## Installer Docker (Windows)

<img style="background: transparent;" class="plain" src="https://docs.docker.com/docker-for-windows/images/installer-finishes.png">
<img style="background: transparent;" class="plain" src="https://docs.docker.com/docker-for-windows/images/win-install-success-popup.png">

--

## Installer Docker (Windows) <span style="text-transform: none;">[https://goo.gl/JyFvE1](https://goo.gl/JyFvE1)</span>

<iframe width="800" height="600" src="https://docs.docker.com/engine/installation/windows/"></iframe>

---

## Installer Docker (Ubuntu) <span style="text-transform: none;">[https://goo.gl/NtWxSJ](https://goo.gl/NtWxSJ)</span>

- Prérequis : 
    + Ubuntu Xenial 16.04 (LTS),  Wily 15.10,  Trusty 14.04 (LTS),  Precise 12.04 (LTS)
    + 64bits
    + Linux kernel > 3.10 (vérification avec `uname -r`)

--

## Installer Docker (Ubuntu) 1/2

- 1 . Mise à jour APT
    ```bash
    $ sudo apt-get update
    $ sudo apt-get install apt-transport-https ca-certificates
    ```
- 2 . Ajout GPG
    ```bash
    $ sudo apt-key adv \
               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    ```
- 3 . Ajout souces.list
    ```bash
    $ echo "<REPO>" | sudo tee /etc/apt/sources.list.d/docker.list
    ```
    __&#9888; Attention `<REPO>` dépendant de la version d'Ubuntu__

- 4 . Mise à jour APT
    ```bash
    $ sudo apt-get update
    $ apt-cache policy docker-engine
    ```

--

## Installer Docker (Ubuntu) 2/2

- 5 . Installation prérequis
    ```bash
    $ sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
    ```
- 6 . Installation de Docker
    ```bash
    $ sudo apt-get install docker-engine
    $ sudo service docker start
    ```

--

## Installer Docker (Ubuntu) <span style="text-transform: none;">[https://goo.gl/NtWxSJ](https://goo.gl/NtWxSJ)</span>

<iframe width="800" height="600" src="https://docs.docker.com/engine/installation/linux/ubuntulinux/"></iframe>

---

## Installer Docker (Debian) <span style="text-transform: none;">[https://goo.gl/gdmvrr](https://goo.gl/gdmvrr)</span>

<iframe width="800" height="600" src="https://docs.docker.com/engine/installation/linux/debian/"></iframe>

---

## Cloner le repo
```bash
$ git clone git@github.com:devProbikeshop/docker.git
$ cd docker
$ git checkout v1.5.0
```

<img width="800" height="495" src="/images/docker-github.png">

--

## Modifier le Dockerfile
Changer la ligne
```Ini
ENV MY_IP 192.168.25.73
```

--

## Modifier le fichier hosts

- `/etc/hosts`

- `C:\Windows\System32\drivers\etc\hosts`

Ajouter les lignes
```Ini
127.0.0.1 backend.probikeshop.local
127.0.0.1 frontend.probikeshop.fr
127.0.0.1 frontend.probikeshop.com
127.0.0.1 frontend.probikeshop.net
127.0.0.1 frontend.probikeshop.ch
127.0.0.1 frontend.probikeshop.it
127.0.0.1 frontend.probikeshop.pt
127.0.0.1 frontend.probikeshop.es
127.0.0.1 frontend.probikeshop.de
127.0.0.1 frontend.bike-connect.fr
127.0.0.1 frontend.bike-connect.com
127.0.0.1 www.backend.probikeshop.local
127.0.0.1 www.frontend.probikeshop.fr
127.0.0.1 www.frontend.probikeshop.com
127.0.0.1 www.frontend.probikeshop.ch
127.0.0.1 www.frontend.probikeshop.it
127.0.0.1 www.frontend.probikeshop.pt
127.0.0.1 www.frontend.probikeshop.es
127.0.0.1 www.frontend.probikeshop.de
127.0.0.1 www.frontend.probikeshop.net
127.0.0.1 www.frontend.bike-connect.fr
127.0.0.1 www.frontend.bike-connect.com
```

--

## Note sur les lignes de commandes Docker (Windows)

_Pour utiliser les lignes de commandes Docker utilisez de préférence :_
- PowerShell - https://goo.gl/bO24Fo
- Cygwin - https://goo.gl/8znT9y
- Bash - https://goo.gl/aJyJBZ

--

## Builder l'image
```bash
$ docker build -t probikeshop-lamp .
```

--

## Démarrer le contenur
```bash
$ docker run -d --name probikeshop.local -p 80:80 -p 443:443 -p 3306:3306
 -v C:\Users\jeremy\workspace:/var/www 
 -v C:\Users\jeremy\workspace\mysql:/var/lib/mysql "probikeshop-lamp"
```

--

## Se connecter au contenur
```bash
$ docker exec -ti probikeshop.local /bin/bash
```

---

## L'avenir : Docker Compose

<img style="background: white;" height="450" width="700" src="https://github.com/maxpou/docker-symfony/raw/master/doc/schema.png">

[Une stack Docker pour votre application Symfony - https://goo.gl/kKAB8X](http://www.maxpou.fr/docker-pour-symfony/)

--

## Docker Compose : exemple de composition

```yml
version: '2'

services:
    db:
        image: mysql
        volumes:
            - C:\Users\jeremy\workspace\mysql:/var/lib/mysql
        environment:
            MYSQL_ROOT_PASSWORD: root
    php:
        build: php:7.0-apache
        ports:
            - 9000:9000
            - 80:80
            - 443:443
        links:
            - db:mysqldb
        volumes:
            - C:\Users\jeremy\workspace:/var/www
            - ./logs/symfony:/var/www/symfony/app/logs
    elk:
        image: willdurand/elk
        ports:
            - 81:80
        volumes:
            - ./elk/logstash:/etc/logstash
            - ./elk/logstash/patterns:/opt/logstash/patterns
        volumes_from:
            - php
```
<!-- .element: class="fragment current-visible" -->

```yml
version: '2'

services:
    nodejs:
        image: node:6.9
    db:
        image: mariadb:latest
        volumes:
            - C:\Users\jeremy\workspace\mysql:/var/lib/mysql
        environment:
            MYSQL_ROOT_PASSWORD: root
    php:
        build: php:7.0-apache
        ports:
            - 9000:9000
            - 80:80
            - 443:443
        links:
            - db:mysqldb
            - node:nodejs
        volumes:
            - C:\Users\jeremy\workspace:/var/www
            - ./logs/symfony:/var/www/symfony/app/logs
    elk:
        image: willdurand/elk
        ports:
            - 81:80
        volumes:
            - ./elk/logstash:/etc/logstash
            - ./elk/logstash/patterns:/opt/logstash/patterns
        volumes_from:
            - php
```
<!-- .element: class="fragment" -->
