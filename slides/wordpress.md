# WordPress 101

---

# Sécurité et performances

--

## Sécurisation

via le .htaccess

```
# Désactiver l'affichage du contenu des répertoires
Options All -Indexes

# Masquer les informations du serveur
ServerSignature Off

# Bloquer le chargement des fichiers includes
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^wp-admin/includes/ - [F,L]
RewriteRule !^wp-includes/ - [S=3]
RewriteRule ^wp-includes/[^/]+\.php$ - [F,L]
RewriteRule ^wp-includes/js/tinymce/langs/.+\.php - [F,L]
RewriteRule ^wp-includes/theme-compat/ - [F,L]
</IfModule>

# Protéger le wp-config.php
<files wp-config.php>
order allow,deny
deny from all
</files>

# Protéger les fichiers .htaccess et .htpasswds
<Files ~ "^.*\.([Hh][Tt][AaPp])">
order allow,deny
deny from all
satisfy all
</Files>

# Éviter le spam de commentaires
<IfModule mod_rewrite.c>
RewriteCond %{REQUEST_METHOD} POST
RewriteCond %{REQUEST_URI} .wp-comments-post\.php*
RewriteCond %{HTTP_REFERER} !.iamprobiker.probikeshop.com.* [OR]
RewriteCond %{HTTP_USER_AGENT} ^$
RewriteRule (.*) ^http://%{REMOTE_ADDR}/$ [R=301,L]
</IfModule>

# Éviter que l'on découvre l'identifiant d'un auteur
<IfModule mod_rewrite.c>
RewriteCond %{QUERY_STRING} ^author=([0-9]*)
RewriteRule .* - [F]
</IfModule>

# Désactiver le hotlinking des images
# RewriteEngine On
# RewriteCond %{HTTP_REFERER} !^$
# RewriteCond %{HTTP_REFERER} !^http(s)?://(www\.)?iamprobiker.probikeshop.com [NC]
# RewriteRule \.(jpg|jpeg|png|gif)$ http://fakeimg.pl/400x200/?text=Pas_touche_aux_images [NC,R,L]

# Page de maintenance
# RewriteEngine on
# RewriteCond %{REQUEST_URI} !/maintenance.html$
# RewriteCond %{REMOTE_ADDR} !^xxx\.xxx\.xxx\.xxx
# RewriteRule $ /maintenance.html [R=302,L]

# Prevent some browsers from MIME-sniffing the response.
<IfModule mod_headers.c>
    Header set X-Content-Type-Options "nosniff"
</IfModule>

# Remove the `X-Powered-By` response header that:
<IfModule mod_headers.c>
    Header unset X-Powered-By
</IfModule>

# BEGIN WordPress
```

Note:

Source : [wpmarmite.com/htaccess-wordpress](https://wpmarmite.com/htaccess-wordpress/)

--

.htaccess dans wp-admin

```
# Autoriser les accès à wp-admin à une liste d'IPs
<Limit GET POST PUT>
order deny,allow
deny from all
# IP 1
allow from xxx.xxx.xxx.xxx
# IP 2
allow from xxx.xxx.xxx.xxx
# IP 3
allow from xxx.xxx.xxx.xxx
</Limit>

# Autoriser les accès à wp-admin/admin-ajax.php
<Files admin-ajax.php> 
    Order allow,deny
    Allow from all
    Satisfy any
</Files>
```

--

## Optimisations

```
<IfModule mod_headers.c>

    Header set X-UA-Compatible "IE=edge"

    # `mod_headers` cannot match based on the content-type, however,
    # the `X-UA-Compatible` response header should be send only for
    # HTML documents and not for the other resources.

    <FilesMatch "\.(appcache|atom|bbaw|bmp|crx|css|cur|eot|f4[abpv]|flv|geojson|gif|htc|ico|jpe?g|js|json(ld)?|m4[av]|manifest|map|mp4|oex|og[agv]|opus|otf|pdf|png|rdf|rss|safariextz|svgz?|swf|topojson|tt[cf]|txt|vcard|vcf|vtt|webapp|web[mp]|webmanifest|woff2?|xloc|xml|xpi)$">
        Header unset X-UA-Compatible
    </FilesMatch>

</IfModule>

# ######################################################################
# # MEDIA TYPES AND CHARACTER ENCODINGS                                #
# ######################################################################

# ----------------------------------------------------------------------
# | Media types                                                        |
# ----------------------------------------------------------------------

# Serve resources with the proper media types (f.k.a. MIME types).
#
# https://www.iana.org/assignments/media-types/media-types.xhtml
# https://httpd.apache.org/docs/current/mod/mod_mime.html#addtype

<IfModule mod_mime.c>

  # Data interchange

    AddType application/atom+xml                        atom
    AddType application/json                            json map topojson
    AddType application/ld+json                         jsonld
    AddType application/rss+xml                         rss
    AddType application/vnd.geo+json                    geojson
    AddType application/xml                             rdf xml


  # JavaScript

    # Normalize to standard type.
    # https://tools.ietf.org/html/rfc4329#section-7.2

    AddType application/javascript                      js


  # Manifest files

    AddType application/manifest+json                   webmanifest
    AddType application/x-web-app-manifest+json         webapp
    AddType text/cache-manifest                         appcache


  # Media files

    AddType audio/mp4                                   f4a f4b m4a
    AddType audio/ogg                                   oga ogg opus
    AddType image/bmp                                   bmp
    AddType image/svg+xml                               svg svgz
    AddType image/webp                                  webp
    AddType video/mp4                                   f4v f4p m4v mp4
    AddType video/ogg                                   ogv
    AddType video/webm                                  webm
    AddType video/x-flv                                 flv

    # Serving `.ico` image files with a different media type
    # prevents Internet Explorer from displaying then as images:
    # https://github.com/h5bp/html5-boilerplate/commit/37b5fec090d00f38de64b591bcddcb205aadf8ee

    AddType image/x-icon                                cur ico


  # Web fonts

    AddType application/font-woff                       woff
    AddType application/font-woff2                      woff2
    AddType application/vnd.ms-fontobject               eot

    # Browsers usually ignore the font media types and simply sniff
    # the bytes to figure out the font type.
    # https://mimesniff.spec.whatwg.org/#matching-a-font-type-pattern
    #
    # However, Blink and WebKit based browsers will show a warning
    # in the console if the following font types are served with any
    # other media types.

    AddType application/x-font-ttf                      ttc ttf
    AddType font/opentype                               otf


  # Other

    AddType application/octet-stream                    safariextz
    AddType application/x-bb-appworld                   bbaw
    AddType application/x-chrome-extension              crx
    AddType application/x-opera-extension               oex
    AddType application/x-xpinstall                     xpi
    AddType text/vcard                                  vcard vcf
    AddType text/vnd.rim.location.xloc                  xloc
    AddType text/vtt                                    vtt
    AddType text/x-component                            htc

</IfModule>

# ----------------------------------------------------------------------
# | Character encodings                                                |
# ----------------------------------------------------------------------

# Serve all resources labeled as `text/html` or `text/plain`
# with the media type `charset` parameter set to `UTF-8`.
#
# https://httpd.apache.org/docs/current/mod/core.html#adddefaultcharset

AddDefaultCharset utf-8

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Serve the following file types with the media type `charset`
# parameter set to `UTF-8`.
#
# https://httpd.apache.org/docs/current/mod/mod_mime.html#addcharset

<IfModule mod_mime.c>
    AddCharset utf-8 .atom \
                     .bbaw \
                     .css \
                     .geojson \
                     .js \
                     .json \
                     .jsonld \
                     .manifest \
                     .rdf \
                     .rss \
                     .topojson \
                     .vtt \
                     .webapp \
                     .webmanifest \
                     .xloc \
                     .xml
</IfModule>

# ######################################################################
# # WEB PERFORMANCE                                                    #
# ######################################################################

# ----------------------------------------------------------------------
# | Compression                                                        |
# ----------------------------------------------------------------------

<IfModule mod_deflate.c>

    # Force compression for mangled `Accept-Encoding` request headers
    # https://developer.yahoo.com/blogs/ydn/pushing-beyond-gzipping-25601.html

    <IfModule mod_setenvif.c>
        <IfModule mod_headers.c>
            SetEnvIfNoCase ^(Accept-EncodXng|X-cept-Encoding|X{15}|~{15}|-{15})$ ^((gzip|deflate)\s*,?\s*)+|[X~-]{4,13}$ HAVE_Accept-Encoding
            RequestHeader append Accept-Encoding "gzip,deflate" env=HAVE_Accept-Encoding
        </IfModule>
    </IfModule>

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Compress all output labeled with one of the following media types.
    #
    # (!) For Apache versions below version 2.3.7 you don't need to
    # enable `mod_filter` and can remove the `<IfModule mod_filter.c>`
    # and `</IfModule>` lines as `AddOutputFilterByType` is still in
    # the core directives.
    #
    # https://httpd.apache.org/docs/current/mod/mod_filter.html#addoutputfilterbytype

    <IfModule mod_filter.c>
        AddOutputFilterByType DEFLATE "application/atom+xml" \
                                      "application/javascript" \
                                      "application/json" \
                                      "application/ld+json" \
                                      "application/manifest+json" \
                                      "application/rdf+xml" \
                                      "application/rss+xml" \
                                      "application/schema+json" \
                                      "application/vnd.geo+json" \
                                      "application/vnd.ms-fontobject" \
                                      "application/x-font-ttf" \
                                      "application/x-javascript" \
                                      "application/x-web-app-manifest+json" \
                                      "application/xhtml+xml" \
                                      "application/xml" \
                                      "font/eot" \
                                      "font/opentype" \
                                      "image/bmp" \
                                      "image/svg+xml" \
                                      "image/vnd.microsoft.icon" \
                                      "image/x-icon" \
                                      "text/cache-manifest" \
                                      "text/css" \
                                      "text/html" \
                                      "text/javascript" \
                                      "text/plain" \
                                      "text/vcard" \
                                      "text/vnd.rim.location.xloc" \
                                      "text/vtt" \
                                      "text/x-component" \
                                      "text/x-cross-domain-policy" \
                                      "text/xml"

    </IfModule>

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Map the following filename extensions to the specified
    # encoding type in order to make Apache serve the file types
    # with the appropriate `Content-Encoding` response header
    # (do note that this will NOT make Apache compress them!).
    #
    # If these files types would be served without an appropriate
    # `Content-Enable` response header, client applications (e.g.:
    # browsers) wouldn't know that they first need to uncompress
    # the response, and thus, wouldn't be able to understand the
    # content.
    #
    # https://httpd.apache.org/docs/current/mod/mod_mime.html#addencoding

    <IfModule mod_mime.c>
        AddEncoding gzip              svgz
    </IfModule>

</IfModule>

# ----------------------------------------------------------------------
# | Content transformation                                             |
# ----------------------------------------------------------------------

# Prevent intermediate caches or proxies (e.g.: such as the ones
# used by mobile network providers) from modifying the website's
# content.
#
# https://tools.ietf.org/html/rfc2616#section-14.9.5
#
# (!) If you are using `mod_pagespeed`, please note that setting
# the `Cache-Control: no-transform` response header will prevent
# `PageSpeed` from rewriting `HTML` files, and, if the
# `ModPagespeedDisableRewriteOnNoTransform` directive isn't set
# to `off`, also from rewriting other resources.
#
# https://developers.google.com/speed/pagespeed/module/configuration#notransform

# <IfModule mod_headers.c>
#     Header merge Cache-Control "no-transform"
# </IfModule>

# ----------------------------------------------------------------------
# | ETags                                                              |
# ----------------------------------------------------------------------

# Remove `ETags` as resources are sent with far-future expires headers.
#
# https://developer.yahoo.com/performance/rules.html#etags
# https://tools.ietf.org/html/rfc7232#section-2.3

# `FileETag None` doesn't work in all cases.
<IfModule mod_headers.c>
    Header unset ETag
</IfModule>

FileETag None

# ----------------------------------------------------------------------
# | Expires headers                                                    |
# ----------------------------------------------------------------------

# Serve resources with far-future expires headers.
#
# (!) If you don't control versioning with filename-based
# cache busting, you should consider lowering the cache times
# to something like one week.
#
# https://httpd.apache.org/docs/current/mod/mod_expires.html

<IfModule mod_expires.c>

    ExpiresActive on
    ExpiresDefault                                      "access plus 1 month"

  # CSS

    ExpiresByType text/css                              "access plus 1 year"


  # Data interchange

    ExpiresByType application/atom+xml                  "access plus 1 hour"
    ExpiresByType application/rdf+xml                   "access plus 1 hour"
    ExpiresByType application/rss+xml                   "access plus 1 hour"

    ExpiresByType application/json                      "access plus 0 seconds"
    ExpiresByType application/ld+json                   "access plus 0 seconds"
    ExpiresByType application/schema+json               "access plus 0 seconds"
    ExpiresByType application/vnd.geo+json              "access plus 0 seconds"
    ExpiresByType application/xml                       "access plus 0 seconds"
    ExpiresByType text/xml                              "access plus 0 seconds"


  # Favicon (cannot be renamed!) and cursor images

    ExpiresByType image/vnd.microsoft.icon              "access plus 1 week"
    ExpiresByType image/x-icon                          "access plus 1 week"

  # HTML

    ExpiresByType text/html                             "access plus 0 seconds"


  # JavaScript

    ExpiresByType application/javascript                "access plus 1 year"
    ExpiresByType application/x-javascript              "access plus 1 year"
    ExpiresByType text/javascript                       "access plus 1 year"


  # Manifest files

    ExpiresByType application/manifest+json             "access plus 1 week"
    ExpiresByType application/x-web-app-manifest+json   "access plus 0 seconds"
    ExpiresByType text/cache-manifest                   "access plus 0 seconds"


  # Media files

    ExpiresByType audio/ogg                             "access plus 1 month"
    ExpiresByType image/bmp                             "access plus 1 month"
    ExpiresByType image/gif                             "access plus 1 month"
    ExpiresByType image/jpeg                            "access plus 1 month"
    ExpiresByType image/png                             "access plus 1 month"
    ExpiresByType image/svg+xml                         "access plus 1 month"
    ExpiresByType image/webp                            "access plus 1 month"
    ExpiresByType video/mp4                             "access plus 1 month"
    ExpiresByType video/ogg                             "access plus 1 month"
    ExpiresByType video/webm                            "access plus 1 month"


  # Web fonts

    # Embedded OpenType (EOT)
    ExpiresByType application/vnd.ms-fontobject         "access plus 1 month"
    ExpiresByType font/eot                              "access plus 1 month"

    # OpenType
    ExpiresByType font/opentype                         "access plus 1 month"

    # TrueType
    ExpiresByType application/x-font-ttf                "access plus 1 month"

    # Web Open Font Format (WOFF) 1.0
    ExpiresByType application/font-woff                 "access plus 1 month"
    ExpiresByType application/x-font-woff               "access plus 1 month"
    ExpiresByType font/woff                             "access plus 1 month"

    # Web Open Font Format (WOFF) 2.0
    ExpiresByType application/font-woff2                "access plus 1 month"


  # Other

    ExpiresByType text/x-cross-domain-policy            "access plus 1 week"

</IfModule>
```

Note:

Source : [html5-boilerplate](https://github.com/h5bp/html5-boilerplate/blob/master/dist/.htaccess)

--

## Sécurisation
via le wp-config.php

```php
// Désactiver l'éditeur de code dans l'admin
define('DISALLOW_FILE_EDIT', true);

// Changer le préfixe des tables
$table_prefix  = 'pbk_';

// Forcer le HTTPS dans l'administration
define('FORCE_SSL_ADMIN', true);
define('FORCE_SSL_LOGIN', true);
```

--

## Sécurisation
via HTTPS

1. Obtenir un certificat gratuit avec [![Let’s Encrypt](https://letsencrypt.org/images/letsencrypt-logo-horizontal.svg) <!-- .element: class="plain" style="background: white;" -->](https://letsencrypt.org/)
2. Installer et activer [![Really Simple SSL](https://really-simple-ssl.com/wp-content/uploads/2015/12/Logo_en_naam1.png) <!-- .element: class="plain" style="background: white;" -->](https://wordpress.org/plugins/really-simple-ssl/)
3. Rediriger vers HTTPS et activer le mode HSTS via le .htacces

```
  RewriteCond %{SERVER_PORT} ^80$
  RewriteRule ^(.*)$ https://%{SERVER_NAME}%{REQUEST_URI} [R=301,L]
  # OWASP HSTS Cheat Sheet https://www.owasp.org/index.php/HTTP_Strict_Transport_Security
  <IfModule mod_headers.c>
       Header set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload" env=HTTPS
  </IfModule> 
```

Note:

Penser à renouveler le certificat tous les 90 jours, [OVH le fait pour nous](https://www.ovh.com/fr/hebergement-web/ssl_mutualise.xml)

--

## Sécurisation
via [Jetpack](https://wordpress.org/plugins/jetpack/)

![Jetpack](https://ps.w.org/jetpack/assets/banner-772x250.png?rev=1594422) <!-- .element: style="height: 125px;" -->

- Bloque les attaques "brute force"
- Propose un système de surveillance
- Sécurise l'authentification
- Maintien à jour les plugins

(Requiert un compte [WordPress.com](https://fr.wordpress.com/))

--

## Sécurisation
via [Akismet](https://wordpress.org/plugins/akismet/)

![Akismet](https://ps.w.org/akismet/assets/banner-772x250.jpg?rev=969272) 

(Requiert un compte [WordPress.com](https://fr.wordpress.com/) et une [clé d'API](https://akismet.com/get/))

--

### Sécurisation / Optimisations
via les mu-plugins

- [Bcrypt Password](https://roots.io/plugins/bcrypt-password/)
    + PHP >= 5.5.0, WordPress >= 4.4
- [Soil](https://github.com/roots/soil)
    + Nettoyage du code HTML
    + Google Analytics (plus performant)
    + jQuery depuis jQuery CDN
    + Chargement des JS dans le footer
    + DOM des menus simplifiés
    + Véritables URLs de recherche
- [yannkozon/mu-plugins](https://github.com/yannkozon/mu-plugins)

Note:

Source : [Lille WordPress Meetup #9 | Les mu-plugins dans Wordpress](https://fr.slideshare.net/yannkozon/muplugins-dans-wordpress)

--

Activation des fonctionnalités de Soil dans le `functions.php`

```php
add_theme_support('soil-clean-up');
add_theme_support('soil-google-analytics', 'UA-XXXXX-Y');
add_theme_support('soil-jquery-cdn');
add_theme_support('soil-js-to-footer');
add_theme_support('soil-nav-walker');
add_theme_support('soil-nice-search');
```

--

## Sécurisation
via des sauvegardes régulières

- [WordPress Duplicator](https://fr.wordpress.org/plugins/duplicator/)
    + Sauvegardes manuelles
    + Déploiements facilités
- [BackWPup](https://fr.wordpress.org/plugins/backwpup/)
    + Sauvegardes automatiques
    + Export dans Google Drive

---

# Thème enfant

--

## [Création d'un thème enfant](https://codex.wordpress.org/fr:Th%C3%A8mes_Enfant)

    twentyseventeen-child/
    |-- functions.php
    |-- screenshot.png
    `-- style.css

--

Contenu minimal du fichier `functions.php`

```php
add_action( 'wp_enqueue_scripts', 'theme_enqueue_styles' );
function theme_enqueue_styles() {
    wp_enqueue_style( 'parent-style', get_template_directory_uri() . '/style.css' );

}
```

--

Contenu minimal du fichier `style.css`

```css
/*
 Theme Name:   Twenty Fifteen Child
 Theme URI:    http://example.com/twentyseventeen-child/
 Description:  Twenty Seventeen Child Theme
 Author:       John Doe
 Author URI:   http://example.com
 Template:     twentyseventeen
 Version:      1.0.0
 License:      GNU General Public License v2 or later
 License URI:  http://www.gnu.org/licenses/gpl-2.0.html
 Tags:         light, dark, two-columns, right-sidebar, responsive-layout, accessibility-ready
 Text Domain:  twentyseventeen-child
*/
```

--

Surcharger un template du thème parent

    |-- 404.php        // Page non trouvée
    |-- archive.php    // Liste des articles
    |-- comments.php   // Affihage des commentaires
    |-- footer.php     // Footer du site (si page spécifique définie)
    |-- front-page.php // Page d'accueil
    |-- header.php     // Header du site
    |-- index.php      // Page d'accueil (liste des articles)
    |-- page.php       // Template générique des pages
    |-- search.php     // Page recherche
    |-- searchform.php // Formulaire de recherche
    |-- sidebar.php    // Zone d'affichage des widgets
    |-- single.php     // Template des articles

--

Créer un template de page personnalisé

Fichier mon-super-template.php
```php
<?php
/*
Template Name: Mon Super Template
*/
?>
```

[Documentation création de templates](https://codex.wordpress.org/Theme_Development)

---

# SEO : Yoast & cie

--

## [Yoast SEO](https://fr.wordpress.org/plugins/wordpress-seo/)

- Analyse mots clés et contenus
- Édition des balises meta titre et descriptions
- Configuration pour les Robots
- Vérification de lisibilité
- Liens canonical
- Fil d’Ariane
- Catégorie principale
- Nettoyage des permaliens
- Sitemaps XML
- Amélioration des RSS

--

## [Jetpack Publicize](https://jetpack.com/support/publicize/)

Publier automatiquement sur les réseaux sociaux
![Publicize](https://jetpackme.files.wordpress.com/2013/11/publicize-options.png?w=788)

--

## [Jetpack Sharing](https://jetpack.com/support/sharing/)

Partage sur les réseaux sociaux
![Sharing](https://jetpackme.files.wordpress.com/2013/11/jetpack-sharing-buttons.png?w=788&h=113) 

---

# Internationalisation <!-- .element: style="white-space: nowrap;" -->

--

## Multisite
[Créer un réseau](https://codex.wordpress.org/fr:Cr%C3%A9er_un_r%C3%A9seau)

1. Autoriser le Multisite (dans le fichier `wp-config.php`)
```php
/* Multisite */
define('WP_ALLOW_MULTISITE', true);
```
2. Installer le Réseau
<br> Sous-domaines, Adresse du Serveur, Nom du réseau, e-mail SuperAdmin
3. Activer le Réseau
<br> Édition `wp-config.php` et `.htaccess`

Note:

[Suivre le guide pour une installation multi-site ET multi-domaine](https://blog.manooweb.fr/installation-multi-site-multi-domaine-avec-wordpress/)

--

### Multisite
Installer le Réseau

![Installer le Réseau](https://codex.wordpress.org/images/7/75/network-create.png) 

--

### Multisite
Activer le Réseau

![Activer le Réseau](https://codex.wordpress.org/images/5/5c/tools-network-created.png) 

--

### [Multisite Language Switcher](https://wordpress.org/plugins/multisite-language-switcher/)

Configuration du plugin

![Plugin configuration](https://ps.w.org/multisite-language-switcher/assets/screenshot-1.png?rev=996794) 

--

Édition d'article

![Edit post](https://ps.w.org/multisite-language-switcher/assets/screenshot-3.png?rev=996794) 

--

Résultat sur le site

![Widget](https://ps.w.org/multisite-language-switcher/assets/screenshot-4.png?rev=996794) 

--

### Traduction de thèmes

Utilisation des méthodes pour la traductions de textes

```php
__()
_e()
_x()
_ex()
_n()
_nx()
_n_noop()
_nx_noop()
translate_nooped_plural()

esc_html__()
esc_html_e()
esc_html_x()
esc_attr__()
esc_attr_e()
esc_attr_x()

number_format_i18n()
date_i18n()
```

[cf. Doc Internationalization](https://developer.wordpress.org/themes/functionality/internationalization/)

--

### Utilisation de [Loco Translate](https://wordpress.org/plugins/loco-translate/)

![](https://ps.w.org/loco-translate/assets/screenshot-1.png?rev=1478713) <!-- .element: class="fragment current-visible" -->

![](https://ps.w.org/loco-translate/assets/screenshot-2.png?rev=1478713) <!-- .element: class="fragment" -->

---

### Environnement local/préprod

1. Export à l'aide de [WordPress Duplicator](https://www.youtube.com/watch?v=yZ7pHmR9JC8)
2. Installation serveur local (WampServer, XAMPP)
<br> Utiliser si possible la même version de PHP, MySQL, Apache
3. Installation de l'export sur le serveur local
4. Modification du fichier `C:\Windows\System32\drivers\etc\hosts`
```
    127.0.0.1 blog.probikeshop.local
    127.0.0.1 blog.bikeshop.local
```

---

# Des questions ?

---

# Merci