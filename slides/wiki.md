# Wiki GitHub

<svg aria-hidden="true" class="octicon octicon-mark-github" height="200" version="1.1" viewBox="0 0 16 16" width="200"><path fill="white" fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"></path></svg>
<svg aria-hidden="true" class="octicon octicon-book" height="200" version="1.1" viewBox="0 0 16 16" width="200"><path fill="white"  fill-rule="evenodd" d="M3 5h4v1H3V5zm0 3h4V7H3v1zm0 2h4V9H3v1zm11-5h-4v1h4V5zm0 2h-4v1h4V7zm0 2h-4v1h4V9zm2-6v9c0 .55-.45 1-1 1H9.5l-1 1-1-1H2c-.55 0-1-.45-1-1V3c0-.55.45-1 1-1h5.5l1 1 1-1H15c.55 0 1 .45 1 1zm-8 .5L7.5 3H2v9h6V3.5zm7-.5H9.5l-.5.5V12h6V3z"></path></svg>

---
## &nbsp;
<!-- .slide: data-background-size="cover" data-background-position="top" data-background="images/wiki/github.com-devProbikeshop-frontend-wiki.png" -->
[wiki](https://github.com/devProbikeshop/frontend/wiki)
 <!-- .element: style="position: absolute; top: 0; left: 0; height: 100%; width: 100%; opacity: 0;" -->

---
## &nbsp;
<!-- .slide: data-background-size="cover" data-background-position="top" data-background="images/wiki/github.com-devProbikeshop-frontend-wiki-Elasticsearch.png" -->
[Elasticsearch](https://github.com/devProbikeshop/frontend/wiki/Elasticsearch)
 <!-- .element: style="position: absolute; top: 0; left: 0; height: 100%; width: 100%; opacity: 0;" -->

---
## &nbsp;
<!-- .slide: data-background-size="cover" data-background-position="top" data-background="images/wiki/github.com-devProbikeshop-frontend-wiki-Facebook-pixel.png" -->
[Facebook-pixel](https://github.com/devProbikeshop/frontend/wiki/Facebook-pixel)
 <!-- .element: style="position: absolute; top: 0; left: 0; height: 100%; width: 100%; opacity: 0;" -->


---
## &nbsp;
<!-- .slide: data-background-size="cover" data-background-position="top" data-background="images/wiki/github.com-devProbikeshop-backend-wiki.png" -->
[wiki](https://github.com/devProbikeshop/backend/wiki)
 <!-- .element: style="position: absolute; top: 0; left: 0; height: 100%; width: 100%; opacity: 0;" -->

---
## &nbsp;
<!-- .slide: data-background-size="cover" data-background-position="top" data-background="images/wiki/github.com-devProbikeshop-backend-wiki-Ogone.png" -->
[Ogone](https://github.com/devProbikeshop/backend/wiki/Ogone)
 <!-- .element: style="position: absolute; top: 0; left: 0; height: 100%; width: 100%; opacity: 0;" -->

---
## &nbsp;
<!-- .slide: data-background-size="cover" data-background-position="top" data-background="images/wiki/github.com-devProbikeshop-backend-wiki-Optimisation-des-images.png" -->
[Optimisation-des-images](https://github.com/devProbikeshop/backend/wiki/Optimisation-des-images)
 <!-- .element: style="position: absolute; top: 0; left: 0; height: 100%; width: 100%; opacity: 0;" -->

---
#### https://help.github.com/articles/adding-wiki-pages-via-the-online-interface/
<!-- .slide: data-background-iframe="https://help.github.com/articles/adding-wiki-pages-via-the-online-interface/" -->

---
#### https://help.github.com/articles/editing-wiki-pages-via-the-online-interface/
<!-- .slide: data-background-iframe="https://help.github.com/articles/editing-wiki-pages-via-the-online-interface/" -->

---
#### https://guides.github.com/features/mastering-markdown/#examples
<!-- .slide: data-background-iframe="https://guides.github.com/features/mastering-markdown/#examples" -->

---

# Demo or die

---

```md
# FO : Configuration/Docker

Avec Docker l'application Symfony requiert quelques adaptation de la configuration.

- apps/frontend/config/app.yml
    + modifier la connexion MemCache et SMTP
- apps/frontend/config/factories.yml
    + modifier la connexion MemCache
- apps/frontend_btob/config/factories.yml
    + modifier la connexion SMTP
- apps/webservices/config/app.yml
    + modifier le chemin du dossier images
- apps/webservices/config/factories.yml
    + modifier la connexion SMTP
- apps/webservices/modules/menu/config/module.yml
    + modifier la liste d'IPs autorisée
- apps/webservices/modules/shoppingcart/config/module.yml
    + modifier la liste d'IPs autorisée
- config/databases.yml
    + modifier la connexion MySQL
- web/frontend_dev.php
    + modifier la liste d'IPs autorisée
- web/webservices_dev.php
    + modifier la liste d'IPs autorisée

Pour vous simplifier la vie voici un diff entre la configuration de base et celle pour fonctionner dans un env dockerisé
```

---

```diff
===================================================================
--- apps/frontend/config/factories.yml  (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/frontend/config/factories.yml  (revision )
@@ -64,7 +64,7 @@
   view_cache:
     class: sfMemcacheCache
     param:
-      prefix:  probike
+      prefix: probike
       storeCacheInfo: true
     servers:
         server_01:
@@ -110,18 +110,26 @@
 
 dev:
   view_cache:
-    servers:
-        server_01:
-          host: 127.0.0.1
-          port: 11211
-          persistent: true
+    class: sfMemcacheCache
+    param:
+      prefix: probike
+      storeCacheInfo: true
+      host: memcached
+      port: 11211
+      persistent: true
+
   mailer:
     param:
-      delivery_strategy: realtime
+      delivery_strategy: single_address
+      delivery_address:  votre_email@probikeshop.fr
       transport:
        class:  Swift_SmtpTransport
        param:
-         host:  h5.cienum.fr
+         host:       smtp.gmail.com
+         port:       465
+         encryption: ssl
+         username:   votre_email@probikeshop.fr
+         password:   mot_de_passe
 
 preprod1:
   view_cache:
===================================================================
--- config/databases.yml    (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ config/databases.yml    (revision )
@@ -19,15 +19,15 @@
   doctrine:
     class: sfDoctrineDatabase
     param:
-      dsn:      mysql:host=localhost;dbname=probikeshop_final
+      dsn:      mysql:host=db;dbname=probikeshop_final
       username:   root
-      password:   tgkv42aqwX69;
+      password:   root
   doctrine_crm:
     class: sfDoctrineDatabase
     param:
-      dsn:      mysql:host=localhost;dbname=probikeshop_crm
+      dsn:      mysql:host=db;dbname=probikeshop_crm
       username:   root
-      password:   tgkv42aqwX69;
+      password:   root
 
 preprod1:
   doctrine:
===================================================================
--- apps/webservices/modules/shoppingcart/config/module.yml (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/webservices/modules/shoppingcart/config/module.yml (revision )
@@ -45,7 +45,7 @@
     
 dev:
   authorized:
-    ip: ['62.102.228.142', '10.0.96.222', '10.0.96.223', '31.15.25.167', '10.0.96.11', '10.0.96.12', '10.0.96.13', '10.0.96.14', '10.0.96.15', '10.0.96.16', '10.0.96.31', '10.0.96.32', '173.0.82.126', '127.0.0.1', '192.168.98.1', '192.168.98.2', '192.168.98.3', '192.168.98.4', '192.168.98.5', '192.168.98.6', '192.168.98.7', '192.168.98.8', '192.168.98.9', '192.168.98.10', '94.127.13.23', '80.14.144.209', '94.127.12.145', '94.127.14.145', '195.101.99.76', '194.2.122.158', '193.108.197.98', '192.168.1.106', '10.10.100.181-10.10.100.190', '84.233.249.112-84.233.249.127', '212.23.45.96-212.23.45.111', '212.35.124.160-212.35.124.175', '212.35.124.176-212.35.124.191', '213.254.248.96-213.254.248.111', '213.254.248.112-213.254.248.127', '72.52.4.0-72.52.4.255', '72.52.5.0-72.52.5.255', '209.200.154.0-209.200.154.255', '193.108.197.230' ]
+    ip: ['172.16.238.1', '62.102.228.142', '10.0.96.222', '10.0.96.223', '31.15.25.167', '10.0.96.11', '10.0.96.12', '10.0.96.13', '10.0.96.14', '10.0.96.15', '10.0.96.16', '10.0.96.31', '10.0.96.32', '173.0.82.126', '127.0.0.1', '192.168.98.1', '192.168.98.2', '192.168.98.3', '192.168.98.4', '192.168.98.5', '192.168.98.6', '192.168.98.7', '192.168.98.8', '192.168.98.9', '192.168.98.10', '94.127.13.23', '80.14.144.209', '94.127.12.145', '94.127.14.145', '195.101.99.76', '194.2.122.158', '193.108.197.98', '192.168.1.106', '10.10.100.181-10.10.100.190', '84.233.249.112-84.233.249.127', '212.23.45.96-212.23.45.111', '212.35.124.160-212.35.124.175', '212.35.124.176-212.35.124.191', '213.254.248.96-213.254.248.111', '213.254.248.112-213.254.248.127', '72.52.4.0-72.52.4.255', '72.52.5.0-72.52.5.255', '209.200.154.0-209.200.154.255', '193.108.197.230' ]
   paypal:
     ipn_url: www.sandbox.paypal.com
     
===================================================================
--- apps/webservices/modules/menu/config/module.yml (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/webservices/modules/menu/config/module.yml (revision )
@@ -1,5 +1,5 @@
 all:
   authorized:
-    ip: ['62.102.228.142', '127.0.0.1', '10.0.96.222', '10.0.96.223', '31.15.25.167', '10.0.96.11-10.0.96.18', '10.0.96.31', '10.0.96.32', '192.168.1.1', '94.127.13.23', '80.14.144.209', '94.127.12.145', '94.127.14.145', '195.101.99.76', '194.2.122.158', '193.108.197.98', '192.168.1.106', '10.10.100.181-10.10.100.190', '84.233.249.112-84.233.249.127', '212.23.45.96-212.23.45.111', '212.35.124.160-212.35.124.175', '212.35.124.176-212.35.124.191', '213.254.248.96-213.254.248.111', '213.254.248.112-213.254.248.127', '72.52.4.0-72.52.4.255', '72.52.5.0-72.52.5.255', '209.200.154.0-209.200.154.255', '64.4.241.16', '64.4.241.32-64.4.241.39', '216.113.188.32-216.113.188.35', '216.113.188.64-216.113.188.67', '66.211.169.2', '66.211.169.65', '216.113.188.39', '216.113.188.71', '66.211.168.91', '66.211.168.123', '216.113.188.52', '216.113.188.84', '66.211.168.92', '66.211.168.124', '216.113.188.10', '66.211.168.126', '216.113.188.11', '66.211.168.125', '216.113.188.202', '216.113.188.203', '216.113.188.204', '66.211.170.66', '194.50.38.6', '193.56.46.18', '64.4.241.30', '173.0.81.1', '193.108.197.230', '10.18.86.12-10.18.86.16', '10.26.92.12-10.26.92.16', '10.26.155.8', '192.168.79.1-192.168.79.11', '185.8.52.0-185.8.55.255' ]
+    ip: ['172.16.238.1', '62.102.228.142', '127.0.0.1', '10.0.96.222', '10.0.96.223', '31.15.25.167', '10.0.96.11-10.0.96.18', '10.0.96.31', '10.0.96.32', '192.168.1.1', '94.127.13.23', '80.14.144.209', '94.127.12.145', '94.127.14.145', '195.101.99.76', '194.2.122.158', '193.108.197.98', '192.168.1.106', '10.10.100.181-10.10.100.190', '84.233.249.112-84.233.249.127', '212.23.45.96-212.23.45.111', '212.35.124.160-212.35.124.175', '212.35.124.176-212.35.124.191', '213.254.248.96-213.254.248.111', '213.254.248.112-213.254.248.127', '72.52.4.0-72.52.4.255', '72.52.5.0-72.52.5.255', '209.200.154.0-209.200.154.255', '64.4.241.16', '64.4.241.32-64.4.241.39', '216.113.188.32-216.113.188.35', '216.113.188.64-216.113.188.67', '66.211.169.2', '66.211.169.65', '216.113.188.39', '216.113.188.71', '66.211.168.91', '66.211.168.123', '216.113.188.52', '216.113.188.84', '66.211.168.92', '66.211.168.124', '216.113.188.10', '66.211.168.126', '216.113.188.11', '66.211.168.125', '216.113.188.202', '216.113.188.203', '216.113.188.204', '66.211.170.66', '194.50.38.6', '193.56.46.18', '64.4.241.30', '173.0.81.1', '193.108.197.230', '10.18.86.12-10.18.86.16', '10.26.92.12-10.26.92.16', '10.26.155.8', '192.168.79.1-192.168.79.11', '185.8.52.0-185.8.55.255' ]
 
 
===================================================================
--- apps/webservices/config/factories.yml   (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/webservices/config/factories.yml   (revision )
@@ -79,11 +79,16 @@
 dev:
   mailer:
     param:
-      delivery_strategy: realtime
+      delivery_strategy: single_address
+      delivery_address:  votre_email@probikeshop.fr
       transport:
        class:  Swift_SmtpTransport
        param:
-         host:  h5.cienum.fr
+         host:       smtp.gmail.com
+         port:       465
+         encryption: ssl
+         username:   votre_email@probikeshop.fr
+         password:   mot_de_passe
 
 preprod1:
   response:
===================================================================
--- apps/frontend_btob/config/factories.yml (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/frontend_btob/config/factories.yml (revision )
@@ -99,11 +99,16 @@
 dev:
   mailer:
     param:
-      delivery_strategy: realtime
+      delivery_strategy: single_address
+      delivery_address:  votre_email@probikeshop.fr
       transport:
        class:  Swift_SmtpTransport
        param:
-         host:  h5.cienum.fr
+         host:       smtp.gmail.com
+         port:       465
+         encryption: ssl
+         username:   votre_email@probikeshop.fr
+         password:   mot_de_passe
 
 preprod1:
   response:
===================================================================
--- apps/webservices/config/app.yml (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/webservices/config/app.yml (revision )
@@ -143,7 +143,7 @@
 
 dev:
   path:
-    images: /home/jerome/public_html/frontend/web/images/
+    images: /var/www/frontend/web/images/
 
   email:
     banner_header: https://assets.probikeshop.fr/images/Probikeshop/ui/logo7.png  #mettre l'url absolue !
===================================================================
--- web/frontend_dev.php    (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ web/frontend_dev.php    (revision )
@@ -1,8 +1,9 @@
 <?php
 
 // this check prevents access to debug front controllers that are deployed by accident to production servers.
+
 // feel free to remove this, extend it or make something more sophisticated.
-if (!in_array(@$_SERVER['REMOTE_ADDR'], array('172.16.238.1', '127.0.0.1', '::1')))
+if (!in_array(@$_SERVER['REMOTE_ADDR'], array('172.16.238.7', '127.0.0.1', '::1')))
 {
   die('You are not allowed to access this file. Check '.basename(__FILE__).' for more information.');
 }
===================================================================
--- web/webservices_dev.php (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ web/webservices_dev.php (revision )
@@ -2,7 +2,7 @@
 
 // this check prevents access to debug front controllers that are deployed by accident to production servers.
 // feel free to remove this, extend it or make something more sophisticated.
-if (!in_array(@$_SERVER['REMOTE_ADDR'], array('172.16.238.1', '127.0.0.1', '::1')))
+if (!in_array(@$_SERVER['REMOTE_ADDR'], array('172.16.238.7', '127.0.0.1', '::1')))
 {
   die('You are not allowed to access this file. Check '.basename(__FILE__).' for more information.');
 }
===================================================================
--- apps/frontend/config/app.yml    (revision 4af400c50e14c1d9c3f033a41588a1eb8532c605)
+++ apps/frontend/config/app.yml    (revision )
@@ -818,11 +818,11 @@
   memcache:
     servers:
       server_01:
-        host: 127.0.0.1
+        host: memcached
         port: 11211
         persistent: true
       server_02:
-        host: 127.0.0.1
+        host: memcached
         port: 11211
         persistent: true
```

--
## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-position="top" data-background-size="cover" data-background-image="/images/wiki/demo-fo.png" -->

--
## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-position="bottom" data-background-size="cover" data-background-image="/images/wiki/demo-fo.png" -->

---

```md
# BO : Configuration/Docker

Avec Docker l'application Symfony requiert quelques adaptation de la configuration.

- apps/backofficepc/config/app.yml
    + modifier la connexion SMTP
- config/databases.yml
    + modifier la connexion MySQL

Pour vous simplifier la vie voici un diff entre la configuration de base et celle pour fonctionner dans un env dockerisé
```

---

```diff
===================================================================
--- config/databases.yml    (revision fc86bbf64f387682d610fc0bb2d1569b566f1b6f)
+++ config/databases.yml    (revision )
@@ -45,7 +45,7 @@
     class:       sfPropelDatabase
     param:
       classname: DebugPDO
-      dsn:        mysql:dbname=probikeshop_final;host=localhost
+      dsn:        mysql:dbname=probikeshop_final;host=db
       username:   root
       password:   root
       encoding:   utf8
@@ -55,7 +55,7 @@
     class:       sfPropelDatabase
     param:
       classname: DebugPDO
-      dsn:        mysql:dbname=probikeshop_crm;host=localhost
+      dsn:        mysql:dbname=probikeshop_crm;host=db
       username:   root
       password:   root
       encoding:   utf8
@@ -65,7 +65,7 @@
     class:        sfPropelDatabase
     param:
       classname:  PropelPDO
-      dsn:        mysql:dbname=probikeshop_data;host=localhost
+      dsn:        mysql:dbname=probikeshop_data;host=db
       username:   root
       password:   root
       encoding:   utf8
===================================================================
--- apps/backofficepc/config/app.yml    (revision fc86bbf64f387682d610fc0bb2d1569b566f1b6f)
+++ apps/backofficepc/config/app.yml    (revision )
@@ -1083,13 +1084,14 @@
     upload_avoir: /var/www/shared_backend/frontend/web/uploads/avoirs/
 
   email:
-    host: 127.0.0.1
-    user:
-    passwd:
-    port: 25
-    ssl: off # on|off
-    banner_header: frontend.probikeshop.fr/images/{{site}}/ui/logo7.png
-    background: frontend.probikeshop.fr/images/design/motif_page.jpg
+    host: smtp.gmail.com
+    user: votre_email@probikeshop.fr
+    single_address: votre_email@probikeshop.fr
+    passwd: mot_de_passe
+    port: 465
+    ssl: on # on|off
+    banner_header: https://assets.probikeshop.fr/images/{{site}}/ui/logo7.png  #mettre l'url absolue !
+    background: https://assets.probikeshop.fr/images/design/motif_page.jpg
     notif_mouvement_stock: [ dev-sandbox@probikeshop.fr ]
     notif_contre_remboursement: [ dev-sandbox@probikeshop.fr ]
     notification_translation: [ dev-sandbox@probikeshop.fr ]
```

--
## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-position="top" data-background-size="cover" data-background-image="/images/wiki/demo-bo.png" -->

--
## &nbsp;
<!-- .slide: data-background-repeat="no-repeat" data-background-position="bottom" data-background-size="cover" data-background-image="/images/wiki/demo-bo.png" -->