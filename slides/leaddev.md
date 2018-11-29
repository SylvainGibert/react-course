Compétences développeurs frontend
=================================

## HTML - CSS - JS

### HTML5

- La sémantique HTML : titres, paragraphes, liens, formulaires…
- Les nouvelles balises, champs de formulaire et attributs HTML5
- Les normes W3C, WHATWG
- L'accessibilité numérique (AccessiWeb, WCAG)
- RDFa, Micro-data et JSON-LD cf. 

> ###### [HTML 5.2 - W3C Recommendation](https://www.w3.org/TR/html5/)
> ###### [HTML5 - HTML Standard - WhatWG](https://html.spec.whatwg.org/multipage/)
> ###### [HTML5 PLEASE](http://html5please.com/)
> ###### [Schema.org](https://schema.org/)

### CSS3

- Sélecteurs, pseudo-sélecteurs, poids des sélecteurs (classes vs ids)
- Les nouveaux sélecteurs CSS: nth-child(even), nth-child(odd), :not, first-child ...
- Nouveau support des polices: @font-face ...
- Text wrapping: text-overflow: ellipsis;
- Gestion de colonnes : -webkit-column-count, -webkit-column-rule, -webkit-column-gap
- Bordures sur texte : -webkit-text-fill-color, -webkit-text-stroke-color, -webkit-text-stroke-width
- Opacité : rgba(255, 0, 0, 0.75)
- Saturation, luminosité en CSS : hsla(95, 98%, 68%, 0, 19)
- Bordures arrondies : border-radius
- Fond dégradés en CSS : -webkit-gradient
- Ombres sur texte et sur box : text-shadow et box-shadow
- Backgrounds améliorés : Ajustement de la taille en fonction de la div, backgrounds multiples ..
- Transitions en CSS : -webkit-transition
- Transformation et rotations d'éléments HTML : -webkit-transform
- Animations en CSS
- Utiliser CSScomb pour organiser les propriétés
- Conception CSS : Atomic Design, BEM (OOCSS, SMACSS en bonus)

> ###### [CSS3, please!](http://css3please.com/)
> ###### [Les bases des CSS](https://developer.mozilla.org/fr/docs/Apprendre/Commencer_avec_le_web/Les_bases_CSS)
> ###### [Composer le HTML avec les CSS](https://developer.mozilla.org/fr/docs/Apprendre/CSS)
> ###### [Référence CSS](https://developer.mozilla.org/fr/docs/Web/CSS/Reference)

### Sass

- Preprocessing
- Variables
- Nesting
- Partials
- Import
- Mixins
- Inheritance
- Operators

> ###### [Sass Basics](https://sass-lang.com/guide)

### Foundation for Sites 6

- Grilles (float, XY, Flex)
- General (Typography, Forms, Prototyping Helpers, Float Classes, Visibility Classes)
- Controls (Buttons, Close Button, Button Group , Slider, Switch)
- Navigation (Menu, Drilldown Menu, Accordion Menu, Dropdown Menu, Title Bar, Magellan, Responsive Menu, Top Bar, Breadcrumbs, Pagination)
- Containers (Accordion, Dropdown, Off Canvas, Tabs, Callout, Card, Media Object, Reveal, Table, Responsive Accordion Tabs)
- Media (Badge, Label, Progress Bar, Tooltip, Responsive Embed, Orbit, Thumbnail)
- Plugins (Sticky, Interchange, Responsive Toggle, Toggler, Abide, Equalizer, Smooth Scroll)

> ###### [Foundation for Sites 6](https://foundation.zurb.com/sites/docs/kitchen-sink.html#accordion)

### JS (ES6, ES7, ES8, ES2017, ECMAScript…)

- Constantes et variables de bloc, assignation destructurée
- Chaînes de caractères : multiligne, template, formatage
- Fonction, paramètres par défaut, opérateurs "rest/spread"
- "Arrow Function" : portée lexicale
- Fonction génératrice : "yield" et "generator object"
- Fonction itératrice : "iterator"
- Modèles de classe et héritage, méthodes statiques
- Promise, async/await : gestion des traitements asynchrones
- API HTML5
	+ Les nouveaux sélecteurs: getElemetnsByClassName, querySelectorAll…
	+ Le stockage web ou local: localStorage…
	+ Les BDD Web SQL
	+ Les API de cache pour les apps
	+ Les sockets web
	+ Les notifications
	+ Drag and drop depuis le bureau…
	+ Geolocalisation
	+ Service Worker & Progressive Web App
- Utiliser ESLint et Prettier pour respecter les conventions de code
- Outils développeurs des navigateurs (Chrome, Firefox, Safari, IE, Edge…)

> ###### [JavaScript](https://developer.mozilla.org/fr/docs/Web/JavaScript)
> ###### [Référence Web API](https://developer.mozilla.org/fr/docs/Web/API)

### jQuery

- jQuery 3
	+ Sélecteurs
	+ Ajax
	+ Manipulation du DOM
	+ Gestion des événements
- Utilisation de plugins jQuery (Unveil)

> ###### [jQuery API](https://api.jquery.com/)
> ###### [jQuery Unveil](http://luis-almeida.github.io/unveil/)

### ReactJS

- Concepts de base
	+ JSX, rendre des éléments
	+ Créer des composants et utiliser des props
	+ État et cycle de vie des composants
	+ Gestion des événements
	+ Conditionner le rendu
	+ Afficher des listes et utiliser la propriété key
	+ Gérer des formulaires (contrôlés, ou pas)
	+ Gérer l'état des composants depuis leur ancêtre commun
	+ Composition vs Héritage
	+ Concevoir (penser) une application React
- Concepts avancé
	+ Accessibilité
	+ Code-Splitting
	+ Context
	+ Gestion des erreurs
	+ Utiliser des Refs pour manipuler le DOM
	+ Fragments
	+ Higher-Order Components
	+ Utiliser d'autres librairies au sein de React (jQuery)
	+ Optimiser les performances
	+ Portals
	+ Render Props
	+ Vérifier le typage avec PropTypes
- Redux
	+ Création du store
	+ Décomposition de l'état de l'application à l'aide de Reducers
	+ Créer des actions
	+ Ajout, utilisation, création de Middlewares
	+ Gérer les actions asynchrones avec Redux Thunk
	+ Consommer une API avec Axios, Axios Middleware
- React Router
	+ Définir des routes pour afficher des composants
	+ Utiliser les paramètres des routes
	+ Effectuer des redirections
	+ Synchroniser la navigation avec Redux (connected-react-router)
	+ Utiliser des actions pour changer de route
- Outils développeurs (React Developer Tools, Redux DevTools)

### NodeJS / NPM

- Gestion des dépendances avec npm ou yarn
- Compiler le code JavaScript avec Babel
- Créer des scripts pour compiler et formater le code
- Webpack (3, 4) pour la compilation de code JS et CSS (Sass)
	+ Utilisation, configuration de loaders
	+ Utilisation, configuration de plugins

## PHP

### PHP 5 / 7

- Les bases de PHP
	+ Les variables et la syntaxe
	+ Les références et les valeurs
	+ Les tableaux et les chaines de caractères
	+ Les opérateurs, La précédence
	+ Les session et les cookies
	+ Les formulaires, les entrées et le filtrage
	+ La gestion de erreurs
- Les fonctions
	+ Les arguments et le nommage
	+ Les appels de fonctions
	+ La définition d'une fonction
	+ Les fonctions anonymes
- Programmation Orientée Objet (POO)
	+ UML, modélisation des classes, outils
	+ Les classes et les namespaces (propriétés, méthodes, visibilité et protection)
	+ Constructeur, destructeur, appel implicite versus explicite
	+ Le contexte statique
	+ Les designs patterns (MVC, SOLID, Factory, Singleton…)
	+ Les générateurs
	+ Les Exceptions
	+ Les traits
	+ La SPL et l'autoload
	+ Héritage et agrégation, règles de propagation, polymorphisme et typage
	+ Concepts avancés de la POO : classes abstraites, interfaces, méthodes magiques, surcharge, sauvegarde, clonage
- La sécurité
	+ L'injection SQL
	+ Le CSRF et le XSS
	+ Le chiffrement et les algorithmes relatifs
	+ Le hashage des mots de passe
	+ L’échappement des sorties
- Composer / Packagist
	+ Principe et enjeux
	+ Le gestionnaire de dépendances Composer
	+ Installation/configuration de base
	+ Syntaxe des contraintes
	+ Chargeur universel et PSR
- PHP Standards Recommendations
	+ PSR-1  Basic Coding Standard
	+ PSR-2  Coding Style Guide
	+ PSR-3  Logger Interface
	+ PSR-4  Autoloading Standard
	+ PSR-6  Caching Interface
	+ PSR-7  HTTP Message Interface
	+ PSR-11 Container
	+ PSR-13 Hypermedia Links
	+ PSR-15 HTTP Handlers
	+ PSR-16 Simple Cache
	+ PSR-17 HTTP Factories
- Utiliser EasyCodingStandard et Xdebug

### Symfony

- Les bases
	+ Démarrer un projet Symfony 4 avec Composer et Flex
	+ Organiser les fichiers du projet
	+ Installer des modules complémentaires (bundles, librairies) avec Flex
	+ Comprendre la mécanique de traitement d’une requête HTTP avec Symfony
	+ Maitriser le concept d'environnement (développement, production et test)
	+ Développer en suivant les conventions de codage et de nommage des fichiers
	+ Savoir utiliser l'utilitaire CLI et ses commandes
	+ Maîtriser la Configuration (YAML, annotations, bundles, environnement…)
- Répondre aux requêtes HTTP
	+ Controller / Routes
	+ Templates Twig
	+ Traiter les données des formulaires (validation)
	+ Internationaliser (i18n) et localiser (l10n) l'application
	+ Sécuriser l'accès à certaines pages de l'application
- Interagir avec une base de données relationnelle SQL
	+ Installer et configurer l'ORM Doctrine
	+ Établir un « mapping » objet-relationnel avec les classes d'entités
	+ Lier les entités entre elles grâce aux relations
	+ Persister des entités objet dans la base de données SQL
	+ Construire des requêtes SQL dynamiques grâce au « Query Builder »
	+ Extraire les entités de la base de données
	+ Héberger des requêtes SQL personnalisées dans les entrepôts (« Repositories »)
	+ Encapsuler de la logique métier propre à chaque entité
- Mode expert
	+ Pérenniser l'application avec les tests automatisés (PHPUnit, Behat, Gherkin)
	+ Externaliser le métier dans les services
	+ Injection de dépendance et registre de services
	+ Découpler le code avec l'approche événementielle
	+ Étendre le framework Doctrine
	+ Auditer son application avec le profiler

### Api Platform

- Installer / Configurer Api Platform
	+ Créer, charger, mettre à jour et supprimer des ressources (CRUD)
		+ Configurer les ressources, les sous-ressources, et opérations
	+ Paginer, filtrer, trier les collection
	+ Exploiter les données Hypermedia/HATEOAS, JSON-LD, HAL, JSON API, GraphQL
	+ Valider les données
	+ Documenter l'API (Swagger/OpenAPI, Hydra)
	+ Authentifier le client (Basic HTTP, cookies, JWT, OAuth)
	+ Gestion des requêtes cross-domain CORS headers
	+ Sécuriser les accès
- Étendre les API
	+ Créer des ressources / opérations spéciales (utilisation de DTO)
	+ Maitriser le processus de sérialisation
	+ Gérer les erreurs
	+ Exploiter les événements d'API Platform
	+ Créer ses propres Data Providers / Data Persisters
	+ Utiliser les Micro-data [Schema.org](https://schema.org/)
	+ Créer des extensions
	+ Intégration avec d'autres bundles (FOSUser, JWT, Nelmio, Swagger, GraphQL)

## Fonctionnalités du site

### Domaines

- B2C : Probikeshop, Bikeshop
- B2B : Bike-Connect

### Produits, catégories, marques

- Activation par pays, sources
- Prix psychologique, surcoût par pays
- Distinction produits PBS / IS
- Blacklist des marques
- SIS / Fonds de site
- Elasticsearch

### Livraisons

- Activation par pays, sources
- Filtres en fonction du client, des commandes précédentes
- Coût, surcoût, prix psychologique

### Paiements

- Activation par pays, sources, devises
- Filtres en fonction du client, des commandes précédentes
- Coût, prix psychologique

#### PayPal

- [PayPal-PHP-SDK](https://github.com/paypal/PayPal-PHP-SDK)
- [PayPal Login](https://developer.paypal.com/docs/integration/direct/identity/button-js-builder/)
- [PayPal Checkout](https://developer.paypal.com/docs/checkout/integrate/#1-get-the-code)
- [Braintree PHP](https://developer.paypal.com/docs/accept-payments/express-checkout/ec-braintree-sdk/server-side/php/)
- [Braintree JS](https://developer.paypal.com/docs/accept-payments/express-checkout/ec-braintree-sdk/client-side/javascript/v3/)

#### Ogone

- Construction / chiffrage du formulaire
- Gestion des alias de cartes
- WS feedback

#### Cetelem

- Presto
- Full CB
- WS feedback

## Niveaux

### Novice / Padawan

- HTML5
- CSS3
- Sass
- Foundation for Sites 6
- JS (ES6, ES7, ES8, ES2017, ECMAScript…)
- jQuery
- PHP 5 / 7
- Symfony (bases, HTTP, Doctrine)

### Chevalier Jedi

- ReactJS (bases, Redux, React-Router)
- PHP 5 / 7 (sécurité, Composer, PSR)
- Symfony (tests, services, étendre Doctrine)
- Api Platform
- Conception technique
- Documenter son code

### Maître Jedi

- NodeJS / NPM
- Symfony (Mode expert)
- Étendre API Platform
- Estimation des temps de dév
- Transmettre ses compétences

### Esprit Jedi

- Ne fait qu'un avec le code