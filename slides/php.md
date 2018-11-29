# PHP7 + Symfony

---

<ol style="font-size: 0.85em">
<li>Nouveautés PHP7.X</li>
<li>Migrer une Application Symfony ~~2.x~~ 1.x vers Symfony&nbsp;~~3.x~~ 4.x</li>
<li>Découvrir le framework Symfony 3 / 4</li>
<li>Savoir déboguer son code</li>
<li>Configurer une application Symfony</li>
<li>Concevoir des actions et analyser la requête de l'utilisateur</li>
<li>Internationaliser et localiser l'interface utilisateur</li>
<li>Injection de dépendance et registre de services</li>
<li>Sécuriser l'accès à certaines pages de l'application</li>
<li>Améliorer les performances avec le cache HTTP et ESI</li>
<li>Interagir avec une base de données relationnelle</li>
<li>Authentification et contrôle de droits d'accès</li>
<li>Découpler le code avec l'approche événementielle</li>
<li>Créer des APIs RESTful avec API Platform</li>
<li>Bonus : introduction à Symfony 4 et Symfony Flex</li>
</ol>

---

## 1. Nouveautés PHP7.X

- [Nouveautés PHP7.0](http://php.net/manual/fr/migration70.php)
- [Nouveautés PHP7.1](http://php.net/manual/fr/migration71.php)
- Audit du code existant

--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Scalar type declarations : `string`, `int`, `float`, `bool`

```php
<?php
// Typage faible (par défaut)
function sumOfInts(int ...$ints)
{
    return array_sum($ints);
}

var_dump(sumOfInts(2, '3', 4.1)); // int(9)
```
```php
<?php
// Typage strict
declare(strict_types=1);

function sum(int $a, int $b) {
    return $a + $b;
}

var_dump(sum(1, 2)); // int(3)
var_dump(sum(1.5, 2.5)); /*
Fatal error: Uncaught TypeError: Argument 1 passed to sum() must be of the type integer, float given, called in - on line 9 and defined in -:4
Stack trace:
#0 -(9): sum(1.5, 2.5)
#1 {main}
  thrown in - on line 4
*/
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Return type declarations

```php
// Typage faible (par défaut)
<?php
function sum($a, $b): float {
    return $a + $b;
}
var_dump(sum(1, 2)); // float(3)
```
```php
<?php
// Typage strict
declare(strict_types=1);

function sum($a, $b): int {
    return $a + $b;
}

var_dump(sum(1, 2)); // int(3)
var_dump(sum(1, 2.5)); /*
Fatal error: Uncaught TypeError: Return value of sum() must be of the type integer, float returned in - on line 5 in -:5
Stack trace:
#0 -(9): sum(1, 2.5)
#1 {main}
  thrown in - on line 5
*/
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Null coalescing operator : `??`

```php
// Avant PHP7.0
$username = isset($_GET['user']) ? $_GET['user'] : 'nobody';

// Après PHP7.0
$username = $_GET['user'] ?? 'nobody';

// On peut chaîner tout ça :
$username = $_GET['user'] ?? $_POST['user'] ?? 'nobody';
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" data-transition-speed="fast" data-transition="slide-in fade-out" -->
###### Spaceship operator : `<=>`

![](images/php/tie-bomber.jpg)


--

<!-- .slide:  data-title="Nouveautés PHP7.0" data-transition-speed="fast" data-transition="fade-in slide-out" -->
###### Spaceship operator : `<=>`
```php
// Integers
echo 1 <=> 1; // 0
echo 1 <=> 2; // -1
echo 2 <=> 1; // 1

// Floats
echo 1.5 <=> 1.5; // 0
echo 1.5 <=> 2.5; // -1
echo 2.5 <=> 1.5; // 1
 
// Strings
echo "a" <=> "a"; // 0
echo "a" <=> "b"; // -1
echo "b" <=> "a"; // 1
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Constant arrays

```php
define('ANIMALS', [
    'dog',
    'cat',
    'bird'
]);

echo ANIMALS[1]; // outputs "cat"
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Anonymous classes
```php
interface Logger {
    public function log(string $msg);
}

class Application {
    private $logger;

    public function getLogger(): Logger {
         return $this->logger;
    }

    public function setLogger(Logger $logger) {
         $this->logger = $logger;
    }
}

$app = new Application;
$app->setLogger(new class implements Logger {
    public function log(string $msg) {
        echo $msg;
    }
});

var_dump($app->getLogger()); // object(class@anonymous)#2 (0) {}
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Unicode codepoint escape syntax
```php
echo "\u{aa}"; // ª
echo "\u{0000aa}"; // ª (same as before but with optional leading 0's)
echo "\u{9999}"; // 香
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Closure::call()
```php
class A {private $x = 1;}

// Avant PHP 7
$getX = function() {return $this->x;};
$getXCB = $getX->bindTo(new A, 'A'); // intermediate closure
echo $getXCB(); // 1

// Après PHP 7
$getX = function() {return $this->x;};
echo $getX->call(new A); // 1
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Filtered unserialize()
```php
// converts all objects into __PHP_Incomplete_Class object
$data = unserialize($foo, ["allowed_classes" => false]);

// converts all objects into __PHP_Incomplete_Class object except those of MyClass and MyClass2
$data = unserialize($foo, ["allowed_classes" => ["MyClass", "MyClass2"]]);

// default behaviour (same as omitting the second argument) that accepts all classes
$data = unserialize($foo, ["allowed_classes" => true]);
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### IntlChar
```php
printf('%x', IntlChar::CODEPOINT_MAX); // 10ffff
echo IntlChar::charName('@'); // COMMERCIAL AT
var_dump(IntlChar::ispunct('!')); // bool(true)
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Expectations
```php
ini_set('assert.exception', 1);

class CustomError extends AssertionError {}

assert(false, new CustomError('Some error message'));
// Fatal error: Uncaught CustomError: Some error message
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Group use declarations
```php
// Avant PHP 7
use some\namespace\ClassA;
use some\namespace\ClassB;
use some\namespace\ClassC as C;

use function some\namespace\fn_a;
use function some\namespace\fn_b;
use function some\namespace\fn_c;

use const some\namespace\ConstA;
use const some\namespace\ConstB;
use const some\namespace\ConstC;

// Après 7
use some\namespace\{ClassA, ClassB, ClassC as C};
use function some\namespace\{fn_a, fn_b, fn_c};
use const some\namespace\{ConstA, ConstB, ConstC};
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Generator Return Expressions
```php
$gen = (function() {
    yield 1;
    yield 2;

    return 3;
})();

foreach ($gen as $val) {
    echo $val, PHP_EOL;
}

echo $gen->getReturn(), PHP_EOL; // 1, 2, 3
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Generator delegation
```php
function gen()
{
    yield 1;
    yield 2;
    yield from gen2();
}

function gen2()
{
    yield 3;
    yield 4;
}

foreach (gen() as $val)
{
    echo $val, PHP_EOL;
} // 1, 2, 3, 4
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Integer division with intdiv()
```php
var_dump(intdiv(10, 3)); // 3
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Session options
```php
session_start([
    'cache_limiter' => 'private',
    'read_and_close' => true,
]);
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### preg_replace_callback_array()
```php
$subject = 'Aaaaaa Bbb';

preg_replace_callback_array(
    [
        '~[a]+~i' => function ($match) {
            echo strlen($match[0]), ' matches for "a" found', PHP_EOL;
        },
        '~[b]+~i' => function ($match) {
            echo strlen($match[0]), ' matches for "b" found', PHP_EOL;
        }
    ],
    $subject
);
// 6 matches for "a" found
// 3 matches for "b" found
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### CSPRNG Functions
```php
$bytes = random_bytes(5);
var_dump(bin2hex($bytes)); // string(10) "385e33f741"

var_dump(random_int(100, 999)); // int(248)
var_dump(random_int(-1000, 0)); // int(-898)
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### list() can always unpack objects implementing ArrayAccess
```php
$info = array('coffee', 'brown', 'caffeine');

list($a[0], $a[1], $a[2]) = $info;

var_dump($a); /*
array(3) {
  [2]=>
  string(8) "caffeine"
  [1]=>
  string(5) "brown"
  [0]=>
  string(6) "coffee"
}
*/
```


--

<!-- .slide: data-title="Nouveautés PHP7.0" -->
###### Class member access on cloning
```php
(clone $foo)->bar();
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Nullable types
```php
function testReturn(): ?string
{
    return 'elePHPant';
}

var_dump(testReturn()); // string(10) "elePHPant"

function testReturn(): ?string
{
    return null;
}

var_dump(testReturn()); // NULL

function test(?string $name)
{
    var_dump($name);
}

test('elePHPant'); // string(10) "elePHPant"
test(null); // NULL
test(); // Uncaught Error: Too few arguments to function test(), 0 passed in...

```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Void functions
```php
function swap(&$left, &$right): void
{
    if ($left === $right) {
        return;
    }

    $tmp = $left;
    $left = $right;
    $right = $tmp;
}

$a = 1;
$b = 2;
var_dump(swap($a, $b), $a, $b); /*
null
int(2)
int(1)
*/
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Symmetric array destructuring
```php
$data = [
    [1, 'Tom'],
    [2, 'Fred'],
];

// list() style
list($id1, $name1) = $data[0];

// [] style
[$id1, $name1] = $data[0];

// list() style
foreach ($data as list($id, $name)) {
    // logic here with $id and $name
}

// [] style
foreach ($data as [$id, $name]) {
    // logic here with $id and $name
}
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Class constant visibility
```php
class ConstDemo
{
    const PUBLIC_CONST_A = 1;
    public const PUBLIC_CONST_B = 2;
    protected const PROTECTED_CONST = 3;
    private const PRIVATE_CONST = 4;
}
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### iterable pseudo-type
```php
function iterator(iterable $iter)
{
    foreach ($iter as $val) {
        //
    }
}
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Multi catch exception handling
```php
try {
    // some code
} catch (FirstException | SecondException $e) {
    // handle first and second exceptions
}
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Support for keys in list()
```php
$data = [
    ["id" => 1, "name" => 'Tom'],
    ["id" => 2, "name" => 'Fred'],
];

// list() style
list("id" => $id1, "name" => $name1) = $data[0];

// [] style
["id" => $id1, "name" => $name1] = $data[0];

// list() style
foreach ($data as list("id" => $id, "name" => $name)) {
    // logic here with $id and $name
}

// [] style
foreach ($data as ["id" => $id, "name" => $name]) {
    // logic here with $id and $name
}
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Support for negative string offsets
```php
var_dump("abcdef"[-2]); // string (1) "e"
var_dump(strpos("aabbcc", "b", -3)); // int(3)

$string = 'bar';
echo "The last character of '$string' is '$string[-1]'.\n"; // The last character of 'bar' is 'r'.

```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Convert callables to Closures with Closure::fromCallable()
```php
class Test
{
    public function exposeFunction()
    {
        return Closure::fromCallable([$this, 'privateFunction']);
    }

    private function privateFunction($param)
    {
        var_dump($param);
    }
}

$privFunc = (new Test)->exposeFunction();
$privFunc('some value'); // string(10) "some value"
```

--

<!-- .slide: data-title="Nouveautés PHP7.1" -->
###### Asynchronous signal handling
```php
pcntl_async_signals(true); // turn on async signals

pcntl_signal(SIGHUP,  function($sig) {
    echo "SIGHUP\n";
});

posix_kill(posix_getpid(), SIGHUP);
// SIGHUP
```

--

### Audit de code
<!-- .slide: data-title="Nouveautés PHP7.X" -->

- [PHP 7 Compatibility Checker](https://github.com/sstalle/php7cc)

```bash
$ docker exec -ti php7 php7cc /var/www/frontend --extensions=php --except=lib/composer
```
- [PHP 7 Migration Assistant Report](https://github.com/Alexia/php7mar)

```bash
$ docker exec -ti php7 php "/home/.composer/vendor/alexia/php7mar/mar.php" -f="/var/www/frontend" -r="/var/www/shared_frontend"
```
- [PHP CodeSniffer + PHP Compatibility](https://github.com/wimg/PHPCompatibility)

```bash
$ docker exec -ti php7 phpcs -p /var/www/frontend --standard=PHPCompatibility --ignore="/var/www/frontend/lib/composer"
```

---

## 2. Migrer une Application Symfony ~~2.x~~ 1.x vers Symfony ~~3.x~~ 4.x

## `¯\_(ツ)_/¯`
<!-- .element: class="fragment" data-fragment-index="1" -->

--

## 2. Migrer une Application Symfony ~~2.x~~ 1.x vers Symfony ~~3.x~~ 4.x

- Demande à Google
<!-- .element: class="fragment" -->
- Contrôleur legacy
<!-- .element: class="fragment" -->
- Kernel legacy
<!-- .element: class="fragment" -->
- Porter les infos en session
<!-- .element: class="fragment" -->
- Ne rien migrer
<!-- .element: class="fragment" -->
- Générer des Entités à partir d'une base de données existante
<!-- .element: class="fragment" -->

--

### Google
#### Symfony1 to Symfony2/3/4/Flex
<!-- .slide: data-title="Migrer une Application Symfony 1.x vers Symfony 3.x" -->

- [The Fallback Controller](https://stovepipe.systems/post/migrating-your-project-to-symfony)
- [Painless (well, less painful) migration to Symfony2](https://www.leaseweb.com/labs/2011/12/painless-well-less-painful-migration-to-symfony2/)
- [Migration to Symfony2 continued](https://www.leaseweb.com/labs/2012/02/migration-to-symfony2-continued)
- [Wrap up your legacy application with Symfony](http://blog.theodo.fr/2015/01/wrap-up-your-legacy-application-with-symfony/)

--

### [Contrôleur legacy](https://stovepipe.systems/post/migrating-your-project-to-symfony)
<!-- .slide: data-title="Migrer une Application Symfony 1.x vers Symfony 3.x" -->

```php
namespace LegacyBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Zend\Mvc\Application;
use Zend\Mvc\MvcEvent;

/**
 * @Route(service="legacy.controller.fallback")
 */
class FallbackController
{
    private $webDir;

    public function __construct($webDir)
    {
        $this->webDir = $webDir;
    }

    public function fallback(Request $request, $path)
    {
        // fallback to Zend Framework
        chdir(dirname($this->webDir));
        $appConfig = require $this->webDir . '/../config/application.config.php';

        // Run the application!
        $app = Application::init($appConfig);
        // Add event listener to prevent outputting the result so we can wrap it later
        $app->getEventManager()->attach('finish', function (MvcEvent $e) {
            $e->stopPropagation();
        });
        $app->run();

        // wrap the content in a Symfony response
        return new Response($app->getResponse()->getContent());
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```yaml
#services.yml
services:
    legacy.controller.fallback:
        class: LegacyBundle\Controller\FallbackController
        arguments:
            - "%kernel.root_dir%/../public"
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```yaml
#routing.yml
fallback:
    path: /{path}
    defaults: { _controller: "legacy.controller.fallback:fallback" }
    requirements:
        path: .*
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### [Contrôleur legacy, IngewikkeldWrapperBundle](https://github.com/Ingewikkeld/IngewikkeldWrapperBundle)
<!-- .slide: data-title="Migrer une Application Symfony 1.x vers Symfony 3.x" -->

```php
namespace Ingewikkeld\WrapperBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;

class WrapperController extends Controller
{
    /**
     * @Route("/")
     * @Route("/{url}", requirements={"url" = ".+?"}, defaults={"url"=""})
     * @Template()
     */
    public function indexAction($url = '')
    {
        return new Response($this->get('ingewikkeld_wrapper.sf1_context_proxy')->getContext()->getController()->dispatch());
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
// IngewikkeldWrapperBundle/Proxy/Sf1ContextProxy.php
<?php

namespace Ingewikkeld\WrapperBundle\Proxy;

class Sf1ContextProxy
{
    private $kernel, $legacyPath, $app, $env, $debug, $version;

    public function __construct($kernel, $legacyPath, $app, $env, $debug, $version)
    {
        $this->kernel     = $kernel;
        $this->legacyPath = $legacyPath;
        $this->app        = $app;
        $this->env        = $env;
        $this->debug      = $debug;
        $this->version    = $version;
    }

    public function getContext()
    {
        if (!class_exists('sfContext') || !\sfContext::getInstance()) {
            $this->initialiseSf1Context();
        }

        return \sfContext::getInstance();
    }

    protected function setConstants()
    {
        define('SF_ROOT_DIR',    $this->kernel->getRootDir().'/'.$this->legacyPath);
        define('SF_APP',         $this->app);
        define('SF_ENVIRONMENT', $this->env);
        define('SF_DEBUG',       $this->debug);
        define('SF_VERSION',     $this->version);
    }

    protected function initialiseSf1Context()
    {
        $this->setConstants();

        if (SF_VERSION === 1.0) {
            require_once(SF_ROOT_DIR.DIRECTORY_SEPARATOR.'apps'.DIRECTORY_SEPARATOR.SF_APP.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'config.php');
        } elseif (SF_VERSION === 1.3 || SF_VERSION === 1.4) {
            require_once(SF_ROOT_DIR.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'ProjectConfiguration.class.php');
            
            $configuration = \ProjectConfiguration::getApplicationConfiguration(SF_APP, $this->kernel->getEnvironment(), false);
            \sfContext::createInstance($configuration);
        } else {
            throw new \RuntimeException("Legacy version of symfony 1 not supported: " . $version);
        }
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```yml
#services.yml
services:
    ingewikkeld_wrapper.sf1_context_proxy:
        class: Ingewikkeld\WrapperBundle\Proxy\Sf1ContextProxy
        arguments:
            - "@kernel"
            - %wrapper_legacypath% #  directory inside app/ where your project is located
            - %wrapper_app% #  app to load
            - %wrapper_env% #  environment to load
            - %wrapper_debug% #  whether debug is on or not
            - %wrapper_version% #  Symfony version of the legacy project you are wrapping in this bundle 
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### [Kernel legacy](https://github.com/theodo/TheodoEvolutionLegacyWrapperBundle/blob/master/Resources/doc/index.rst)
<!-- .slide: data-title="Migrer une Application Symfony 1.x vers Symfony 3.x" -->

Surcharge de RouterListener

```php
namespace Theodo\Evolution\Bundle\LegacyWrapperBundle\EventListener;

class RouterListener implements EventSubscriberInterface
{
    public function onKernelRequest(GetResponseEvent $event)
    {
        try {
            $this->routerListener->onKernelRequest($event);
        } catch (NotFoundHttpException $e) {
            if (null !== $this->logger) {
                $this->logger->info('Request handled by the '.$this->legacyKernel->getName().' kernel.');
            }

            $response = $this->legacyKernel->handle($event->getRequest(), $event->getRequestType(), true);
            if ($response->getStatusCode() !== 404) {
                $event->setResponse($response);

                return $event;
            }
        }
    }
}
```

--

### Porter les infos en session

- [Bridge a legacy Application with Symfony Sessions](https://symfony.com/doc/current/session/php_bridge.html)
- [Integrating with Legacy Sessions](https://symfony.com/doc/current/components/http_foundation/session_php_bridge.html)

--

### Ne rien migrer
#### création d'une API REST
<!-- .slide: data-title="Migrer une Application Symfony 1.x vers Symfony 3.x" -->

Création du nouveau projet Symfony

```bash
$ symfony new my_project_name lts
# ou
$  composer create-project symfony/framework-standard-edition my_project_name "2.8.*"
# ou
$ composer create-project api-platform/api-platform my_project_name
```

Ajout de vhost pointant vers my_project_name
- api.probikeshop.com, bo.probikeshop.com
- api.preprod{1,2,3,4,7}.probikeshop.com, bo.preprod{1,2,3,4,7}.probikeshop.com
- api.dev.probikeshop.com, bo.dev.probikeshop.com

--

### [Générer des Entités à partir d'une base de données existante](https://symfony.com/doc/current/doctrine/reverse_engineering.html)
<!-- .slide: data-title="Migrer une Application Symfony 1.x vers Symfony 3.x" -->

1. Génération des fichiers décrivant les entités
```bash
$ php bin/console doctrine:mapping:import --force App yml
```

2. Génération des entités (classes PHP) avec annotation
```bash
$ php bin/console doctrine:mapping:convert annotation ./src
```
3. Suppression des fichiers yml décrivant les entités
4. Définition des relations `one-to-many` avec `inversedBy` et `mappedBy`

---

### 3. Découvrir le framework Symfony 3 / 4

- Présentation générale du framework et de ses outils
- Installation d’une « Distribution Standard Symfony »
- Architecture d’un projet Symfony (application, bundles, librairies, configuration etc.)
- Traitement d’une requête HTTP avec Symfony
- Comprendre la notion d’environnement (développement, production et test)
- Conventions de codage et de nommage des fichiers
- Introduction au concept de « Bundle »

--

#### Présentation générale du framework et de ses outils
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

![](images/php/Symfony.svg)

--

#### Présentation générale du framework et de ses outils
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

![](images/php/SensioCloud.png) <!-- .element: class="fragment plain" width="400" -->
![](images/php/Blackfire.png) <!-- .element: class="fragment plain" width="400" -->
![](images/php/SensioLabsInsight.png) <!-- .element: class="fragment plain" width="400" -->
![](images/php/box-product-twig.png) <!-- .element: class="fragment plain" width="400" -->
![](images/php/box-product-silex.png) <!-- .element: class="fragment plain" width="400" -->
![](images/php/box-product-swift.png) <!-- .element: class="fragment plain" width="400" -->

--

#### Présentation générale du framework et de ses outils
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

<blockquote class="twitter-tweet" data-lang="en"><p lang="fr" dir="ltr">MFW j&#39;optimise de 10K requêtes SQL un call API avec <a href="https://twitter.com/blackfireio?ref_src=twsrc%5Etfw">@blackfireio</a> <br><br>C&#39;est un exemple un peu extrême où on affiche tout les épisodes de plus belle la vie, mais ça va faire du bien à l&#39;app dans tout les cas. <a href="https://t.co/uBS5K85gTo"><img data-aria-label-part="" src="https://pbs.twimg.com/media/DPtlQIMWsAUSTLN.jpg" alt="" style="width: 100%; top: -0px;"></a></p>&mdash; Gabriel Pillet 🐙 (@tentacode) <a href="https://twitter.com/tentacode/status/935452997680795648?ref_src=twsrc%5Etfw">November 28, 2017</a></blockquote>

--

#### Actions, Controllers, Routing, Templates
<!-- .slide: data-title="Présentation générale du framework et de ses outils" -->

```php
// src/Controller/DefaultController.php
namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="index")
     */
    public function indexAction()
    {
        return $this->render('default/index.html.twig', [
            // ...
        ]);
    }
}
```

```twig
{# app/Resources/views/default/index.html.twig #}
{% extends 'base.html.twig' %}
{% block body %}
    <h1>Welcome to Symfony</h1>
    {# ... #}
{% endblock %}
```

--

#### [Twig](https://twig.symfony.com/doc/2.x/)
<!-- .slide: data-title="Présentation générale du framework et de ses outils" -->

- `{{ ... }}` : Afficher la valeur d'une variable, le résultat d'une instruction
- `{% ... %}` : Instruction logique Twig
- `{# ... #}` : Commentaire Twig

--

#### [Twig](https://twig.symfony.com/doc/2.x/)
<!-- .slide: data-title="Présentation générale du framework et de ses outils" -->

```twig
{# app/Resources/views/base.html.twig #}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>{% block title %}Welcome!{% endblock %}</title>
        {% block stylesheets %}{% endblock %}
        <link rel="icon" type="image/x-icon" href="{{ asset('favicon.ico') }}" />
    </head>
    <body>
        {% block body %}{% endblock %}
        {% block javascripts %}{% endblock %}
    </body>
</html>
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```twig
{# 1. Simple variables #}
{# $this->render('template.html.twig', array(
       'name' => 'Fabien')
   ) #}
{{ name }}

{# 2. Arrays #}
{# $this->render('template.html.twig', array(
       'user' => array('name' => 'Fabien'))
   ) #}
{{ user.name }}

{# alternative syntax for arrays #}
{{ user['name'] }}

{# 3. Objects #}
{# $this->render('template.html.twig', array(
       'user' => new User('Fabien'))
   ) #}
{{ user.name }}
{{ user.getName }}

{# alternative syntax for objects #}
{{ user.name() }}
{{ user.getName() }}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```twig
{# app/Resources/views/default/index.html.twig #}
{% extends 'base.html.twig' %}

{% block body %}
    <h1>Welcome to Symfony!</h1>
{% endblock %}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Twig : Tags, Filters and Functions
<!-- .slide: data-title="Présentation générale du framework et de ses outils" -->
```twig
<h1>{{ article.title|capitalize }}</h1>

<p>{{ article.content|striptags|slice(0, 255) }} ...</p>

<p>Tags: {{ article.tags|sort|join(", ") }}</p>

<p>Activate your account before {{ 'next Monday'|date('M j, Y') }}</p>
```

--

#### Twig : Inclure d'autres templates / controllers
<!-- .slide: data-title="Présentation générale du framework et de ses outils" -->
```twig
{# app/Resources/views/ads/banner.html.twig #}
<div id="ad-banner">
    ...
</div>
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```twig
{# app/Resources/views/default/index.html.twig #}
{% extends 'base.html.twig' %}

{% block body %}
    <h1>Welcome to Symfony!</h1>

    {{ include('ads/banner.html.twig') }}
{% endblock %}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```twig
{# app/Resources/views/index.html.twig #}
{{ render(controller('App:Default:topArticles')) }}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
// src/Controller/DefaultController.php
class DefaultController extends Controller
{
    public function topArticlesAction()
    {
        // look for the most popular articles in the database
        $articles = ...;

        return $this->render('default/top_articles.html.twig', array(
            'articles' => $articles,
        ));
    }

    // ...
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Twig : liens et assets
<!-- .slide: data-title="Présentation générale du framework et de ses outils" -->
```twig
<a href="{{ path('index') }}">Return to homepage</a>

<link href="{{ asset('css/blog.css') }}" rel="stylesheet" type="text/css" />

<img src="{{ asset('images/logo.png') }}" />
```

--

#### Installation de Symfony
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->


```bash
composer create-project symfony/skeleton my_project_lts 3.4
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```bash
Installing symfony/skeleton (v3.4.0)
  - Installing symfony/skeleton (v3.4.0): Downloading (100%)
Created project in my_project_lts
Loading composer repositories with package information
Updating dependencies (including require-dev)
Package operations: 25 installs, 0 updates, 0 removals
  - Installing symfony/flex (v1.0.42): Loading from cache
  - Installing psr/log (1.0.2): Loading from cache
  - Installing symfony/debug (v3.4.0): Loading from cache
  - Installing symfony/polyfill-mbstring (v1.6.0): Loading from cache
  - Installing symfony/console (v3.4.0): Loading from cache
  - Installing symfony/routing (v3.4.0): Loading from cache
  - Installing paragonie/random_compat (v2.0.11): Loading from cache
  - Installing symfony/polyfill-php70 (v1.6.0): Loading from cache
  - Installing symfony/http-foundation (v3.4.0): Loading from cache
  - Installing symfony/event-dispatcher (v3.4.0): Loading from cache
  - Installing symfony/http-kernel (v3.4.0): Loading from cache
  - Installing symfony/finder (v3.4.0): Loading from cache
  - Installing symfony/filesystem (v3.4.0): Loading from cache
  - Installing psr/container (1.0.0): Loading from cache
  - Installing symfony/dependency-injection (v3.4.0): Loading from cache
  - Installing symfony/config (v3.4.0): Loading from cache
  - Installing symfony/class-loader (v3.4.0): Loading from cache
  - Installing psr/simple-cache (1.0.0): Loading from cache
  - Installing psr/cache (1.0.1): Loading from cache
  - Installing symfony/polyfill-apcu (v1.6.0): Loading from cache
  - Installing symfony/cache (v3.4.0): Loading from cache
  - Installing symfony/framework-bundle (v3.4.0): Loading from cache
  - Installing symfony/yaml (v3.4.0): Loading from cache
  - Installing symfony/dotenv (v3.4.0): Loading from cache
Writing lock file
Generating autoload files
Symfony operations: 4 recipes (7c06df2b55c4fccb6067609e5b5bd72c)
  - Configuring symfony/flex (1.0): From github.com/symfony/recipes:master
  - Configuring symfony/console (3.3): From github.com/symfony/recipes:master
  - Configuring symfony/routing (3.3): From github.com/symfony/recipes:master
  - Configuring symfony/framework-bundle (3.3): From github.com/symfony/recipes:master
Executing script cache:clear [OK]
Executing script assets:install --symlink --relative public [OK]

Whats next?

Run your application:
1. Change to the project directory
2. Execute the php -S 127.0.0.1:8000 -t public command;
3. Browse to the http://localhost:8000/ URL.

Quit the server with CTRL-C.
Run composer require server \for a better web server.

Read the documentation at https://symfony.com/doc
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```bash
composer create-project symfony/skeleton my_project
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```bash
Installing symfony/skeleton (v4.0.0)
  - Installing symfony/skeleton (v4.0.0): Downloading (100%)         
Created project in my_project
Loading composer repositories with package information
Updating dependencies (including require-dev)
Package operations: 21 installs, 0 updates, 0 removals
  - Installing symfony/flex (v1.0.42): Loading from cache
  - Installing symfony/polyfill-mbstring (v1.6.0): Loading from cache
  - Installing symfony/console (v4.0.0): Loading from cache
  - Installing symfony/routing (v4.0.0): Loading from cache
  - Installing symfony/http-foundation (v4.0.0): Loading from cache
  - Installing symfony/event-dispatcher (v4.0.0): Loading from cache
  - Installing psr/log (1.0.2): Loading from cache
  - Installing symfony/debug (v4.0.0): Loading from cache
  - Installing symfony/http-kernel (v4.0.0): Loading from cache
  - Installing symfony/finder (v4.0.0): Loading from cache
  - Installing symfony/filesystem (v4.0.0): Loading from cache
  - Installing psr/container (1.0.0): Loading from cache
  - Installing symfony/dependency-injection (v4.0.0): Loading from cache
  - Installing symfony/config (v4.0.0): Loading from cache
  - Installing psr/simple-cache (1.0.0): Loading from cache
  - Installing psr/cache (1.0.1): Loading from cache
  - Installing symfony/cache (v4.0.0): Loading from cache
  - Installing symfony/framework-bundle (v4.0.0): Loading from cache
  - Installing symfony/yaml (v4.0.0): Loading from cache
  - Installing symfony/dotenv (v4.0.0): Loading from cache
Writing lock file
Generating autoload files
Symfony operations: 4 recipes (2575147342f87d9827d38186e2813d28)
  - Configuring symfony/flex (1.0): From github.com/symfony/recipes:master
  - Configuring symfony/console (3.3): From github.com/symfony/recipes:master
  - Configuring symfony/routing (3.3): From github.com/symfony/recipes:master
  - Configuring symfony/framework-bundle (3.3): From github.com/symfony/recipes:master
Executing script cache:clear [OK]
Executing script assets:install --symlink --relative public [OK]

Whats next?

Run your application:
1. Change to the project directory
2. Execute the php -S 127.0.0.1:8000 -t public command;
3. Browse to the http://localhost:8000/ URL.

Quit the server with CTRL-C.
Run composer require server \for a better web server.
Read the documentation at https://symfony.com/doc
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Architecture d’un projet Symfony (application, bundles, librairies, configuration etc.)
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

Structure d'un projet Symfony >= 3.4

```css
my_project_name
|-- .env
|-- .env.dist
|-- .gitignore
|-- bin/
|   `-- console
|-- composer.json
|-- composer.lock
|-- config/
|   |-- bundles.php
|   |-- packages
|   |   |-- dev
|   |   |   `-- routing.yaml
|   |   |-- framework.yaml
|   |   |-- routing.yaml
|   |   `-- test
|   |       `-- framework.yaml
|   |-- routes.yaml
|   `-- services.yaml
|-- public/
|   |-- bundles
|   `-- index.php
|-- src/
|   |-- Controller
|   |-- ...
|   `-- Kernel.php
|-- symfony.lock
|-- templates/
|-- translations/
`-- var
    |-- cache
    `-- log
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
`bin/`: Exécutable (`bin/console`).
```css
my_project_name
|-- bin
|   `-- console
```

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
`config/`: Configuration
```css
my_project_name
|-- config
|   |-- bundles.php
|   |-- packages
|   |   |-- dev
|   |   |   `-- routing.yaml
|   |   |-- framework.yaml
|   |   |-- routing.yaml
|   |   `-- test
|   |       `-- framework.yaml
|   |-- routes.yaml
|   `-- services.yaml
```

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
`public/`: Répertoire web racine.
```css
my_project_name
|-- public
|   `-- index.php
```

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
`src/`: Notre code.
```css
my_project_name
|-- src
|   |-- Controller
|   |   `-- .gitignore
|   `-- Kernel.php
```

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
`var/`: Fichiers générés (cache, logs, etc.).
```css
my_project_name
|-- var
|   |-- cache
|   |-- logs
|   `-- sessions
```

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
`vendor/`: Dépendances tierces (paquets composer).
```css
my_project_name
|-- vendor/
```

--

<!-- .slide: data-title="Structure d'un projet Symfony 3.x" -->
dotfiles & lock
```css
my_project_name
|-- .env
|-- .env.dist
|-- .gitignore
|-- composer.json
|-- composer.lock
|-- symfony.lock
```

--

#### Traitement d’une requête HTTP avec Symfony
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

##### Réponse texte (sans template)
```php
// src/Controller/DefaultController.php
namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        return new Response('Welcome to Symfony!');
    }
}
```

--
<!-- .slide: data-title="Traitement d’une requête HTTP avec Symfony" -->

##### Paramètres d’une URL
```php
// src/Controller/DefaultController.php
namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    // ...

    /**
     * @Route("/hello/{name}", name="hello")
     */
    public function helloAction($name)
    {
        return $this->render('default/hello.html.twig', array(
            'name' => $name
        ));
    }
}
```

```twig
{# app/Resources/views/default/hello.html.twig #}
{% extends 'base.html.twig' %}

{% block body %}
    <h1>Hi {{ name }}! Welcome to Symfony!</h1>
{% endblock %}
```

--
<!-- .slide: data-title="Traitement d’une requête HTTP avec Symfony" -->

##### Utiliser des formats
```php
// src/Controller/DefaultController.php
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;

// ...

/**
 * @Route("/hello/{name}.{_format}",
 *     defaults = {"_format"="html"},
 *     requirements = { "_format" = "html|xml|json" },
 *     name = "hello"
 * )
 */
public function helloAction($name, $_format)
{
    return $this->render('default/hello.'.$_format.'.twig', array(
        'name' => $name
    ));
}
```

```twig
<!-- app/Resources/views/default/hello.xml.twig -->
<hello>
    <name>{{ name }}</name>
</hello>
```

--
<!-- .slide: data-title="Traitement d’une requête HTTP avec Symfony" -->

##### Rediriger
```php
// src/Controller/DefaultController.php
class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        return $this->redirectToRoute('hello', array('name' => 'Fabien'));
    }
}
```

--
<!-- .slide: data-title="Traitement d’une requête HTTP avec Symfony" -->

##### Afficher des pages d'erreurs
```php
// src/Controller/DefaultController.php
// ...

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        // ...
        throw $this->createNotFoundException(); // 404
    }

    /**
     * @Route("/contact", name="contactpage")
     */
    public function indexAction()
    {
        // ...
        throw new \Exception('Something went horribly wrong!'); // 500
    }
}
```

--
<!-- .slide: data-title="Traitement d’une requête HTTP avec Symfony" -->

##### Lire les infos de la requête
```php
// src/Controller/DefaultController.php
namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {
        // is it an Ajax request?
        $isAjax = $request->isXmlHttpRequest();

        // what's the preferred language of the user?
        $language = $request->getPreferredLanguage(array('en', 'fr'));

        // get the value of a $_GET parameter
        $pageName = $request->query->get('page');

        // get the value of a $_POST parameter
        $pageName = $request->request->get('page');
    }
}
```

```twig
{{ app.request.query.get('page') }}

{{ app.request.request.get('page') }}
```

--
<!-- .slide: data-title="Traitement d’une requête HTTP avec Symfony" -->

##### Enregistrer des données en session
```php
use Symfony\Component\HttpFoundation\Request;

public function indexAction(Request $request)
{
    $session = $request->getSession();

    // store an attribute for reuse during a later user request
    $session->set('foo', 'bar');

    // get the value of a session attribute
    $foo = $session->get('foo');

    // use a default value if the attribute doesn't exist
    $foo = $session->get('foo', 'default_value');

    // (Pour les nostalgiques) store a message for the very next request
    $this->addFlash('notice', 'Congratulations, your action succeeded!');
}
```

```twig
{{app.session}}
{% for flashMessage in app.session.flashBag.get('notice') %}
    <div class="flash-notice">
        {{ flashMessage }}
    </div>
{% endfor %}
```

--

#### Comprendre la notion d’environnement (développement, production et test)
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

- index.php = APP_ENV __prod__ / __dev__

- __défaut__ : `config/*.yml`, `packages/*.yml`
- __dev__ : `config/packages/dev/*.yml`
```yml
web_profiler:
    toolbar: true
    intercept_redirects: false
```
- __prod__ : `config/packages/prod/*.yml`
- __test__ : `config/packages/test/*.yml`
```yml
swiftmailer:
    disable_delivery: true
```

--

#### Comprendre la notion d’environnement (développement, production et test)
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

```.env
# This file is a "template" of which env vars need to be defined for your application
# Copy this file to .env file for development, create environment variables when deploying to production
# https://symfony.com/doc/current/best_practices/configuration.html#infrastructure-related-configuration

###> symfony/framework-bundle ###
APP_ENV=dev
APP_SECRET=78a1d22b6cc08b2e023694cc228a5e45
###< symfony/framework-bundle ###
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```yml
# config/packages/framework.yaml
framework:
    secret: '%env(APP_SECRET)%'
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Comprendre la notion d’environnement (développement, production et test)
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

Nous devrons ajouter :
- __preprod_dev__ : config/packages/preprod_dev/*.yml
- __preprod__ : config/packages/preprod/*.yml
- En utilisant `%kernel.environment%` :


```yml
defaults_preprod: &defaults_preprod # environnement preprod
  config:
    frontend_fr: "<?php echo "https://www.".sfConfig::get('sf_environment').".probikeshop.fr"; ?>"
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```yml
defaults_preprod: &defaults_preprod # environnement preprod
  config:
    frontend_fr: 'https://www.%kernel.environment%.probikeshop.fr'
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Conventions de codage et de nommage des fichiers
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

- Respect de :
    + [PSR-0 : Autoloading Standard](http://www.php-fig.org/psr/psr-0/)
    + [PSR-1 : Basic Coding Standard](http://www.php-fig.org/psr/psr-1/)
    + [PSR-2 : Coding Style Guide](http://www.php-fig.org/psr/psr-2/)
    + [PSR-4 : Autoloader](http://www.php-fig.org/psr/psr-4/)

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Exemple de code

```php
<?php

/*
 * This file is part of the Symfony package.
 *
 * (c) Fabien Potencier <fabien@symfony.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Acme;

/**
 * Coding standards demonstration.
 */
class FooBar
{
    const SOME_CONST = 42;

    /**
     * @var string
     */
    private $fooBar;

    /**
     * @param string $dummy Some argument description
     */
    public function __construct($dummy)
    {
        $this->fooBar = $this->transformText($dummy);
    }

    /**
     * @return string
     *
     * @deprecated
     */
    public function someDeprecatedMethod()
    {
        @trigger_error(sprintf('The %s() method is deprecated since version 2.8 and will be removed in 3.0. Use Acme\Baz::someMethod() instead.', __METHOD__), E_USER_DEPRECATED);

        return Baz::someMethod();
    }

    /**
     * Transforms the input given as first argument.
     *
     * @param bool|string $dummy   Some argument description
     * @param array       $options An options collection to be used within the transformation
     *
     * @return string|null The transformed input
     *
     * @throws \RuntimeException When an invalid option is provided
     */
    private function transformText($dummy, array $options = array())
    {
        $defaultOptions = array(
            'some_default' => 'values',
            'another_default' => 'more values',
        );

        foreach ($options as $option) {
            if (!in_array($option, $defaultOptions)) {
                throw new \RuntimeException(sprintf('Unrecognized option "%s"', $option));
            }
        }

        $mergedOptions = array_merge(
            $defaultOptions,
            $options
        );

        if (true === $dummy) {
            return null;
        }

        if ('string' === $dummy) {
            if ('values' === $mergedOptions['some_default']) {
                return substr($dummy, 0, 5);
            }

            return ucwords($dummy);
        }
    }

    /**
     * Performs some basic check for a given value.
     *
     * @param mixed $value     Some value to check against
     * @param bool  $theSwitch Some switch to control the method's flow
     *
     * @return bool|void The resultant check if $theSwitch isn't false, void otherwise
     */
    private function reverseBoolean($value = null, $theSwitch = false)
    {
        if (!$theSwitch) {
            return;
        }

        return !$value;
    }
}
```

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Structure [1/5]

- Add a single space after each comma delimiter;
- Add a single space around binary operators (==, &&, ...), with the exception of the concatenation (.) operator;
- Place unary operators (!, --, ...) adjacent to the affected variable;
- Always use identical comparison unless you need type juggling;
- Use Yoda conditions when checking a variable against an expression to avoid an accidental assignment inside the condition statement (this applies to ==, !=, ===, and !==);

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Structure [2/5]
- Add a comma after each array item in a multi-line array, even after the last one;
- Add a blank line before return statements, unless the return is alone inside a statement-group (like an if statement);
- Use return null; when a function explicitly returns null values and use return; when the function returns void values;
- Use braces to indicate control structure body regardless of the number of statements it contains;

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Structure [3/5]
- Define one class per file - this does not apply to private helper classes that are not intended to be instantiated from the outside and thus are not concerned by the PSR-0 and PSR-4 autoload standards;
- Declare the class inheritance and all the implemented interfaces on the same line as the class name;
- Declare class properties before methods;

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Structure [4/5]
- Declare public methods first, then protected ones and finally private ones. The exceptions to this rule are the class constructor and the setUp() and tearDown() methods of PHPUnit tests, which must always be the first methods to increase readability;
- Declare all the arguments on the same line as the method/function name, no matter how many arguments there are;
- Use parentheses when instantiating classes regardless of the number of arguments the constructor has;

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Structure [5/5]
- Exception and error message strings must be concatenated using sprintf;
- Calls to trigger_error with type E_USER_DEPRECATED must be switched to opt-in via @ operator. Read more at Deprecations;
- Do not use else, elseif, break after if and case conditions which return or throw something;
- Do not use spaces around [ offset accessor and before ] offset accessor.

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Conventions de nommages [1/2]

- Use camelCase, not underscores, for variable, function and method names, arguments;
- Use underscores for configuration options and parameters;
- Use namespaces for all classes;
- Prefix all abstract classes with Abstract except PHPUnit TestCase. *Please note some early Symfony classes do not follow this convention and have not been renamed for backward compatibility reasons. However all new abstract classes must follow this naming convention*;

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Conventions de nommages [2/2]
- Suffix interfaces with Interface;
- Suffix traits with Trait;
- Suffix exceptions with Exception;
- Use alphanumeric characters and underscores for file names;
- For type-hinting in PHPDocs and casting, use bool (instead of boolean or Boolean), int (instead of integer), float (instead of double or real);

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Noms des méthodes [1/2]

When an object has a "main" many relation with related "things" (objects, parameters, ...), the method names are normalized:

- `get()` / `set()`
- `has()` / `all()`
- `replace()` / `remove()`
- `clear()` / `isEmpty()`
- `add()` / `register()`
- `count()` / `keys()`

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Noms des méthodes [2/2]

<table style="font-size: 0.6em">
<colgroup>
<col width="46%">
<col width="54%">
</colgroup>
<thead valign="bottom">
<tr class="row-odd"><th class="head">Main Relation</th>
<th class="head">Other Relations</th>
</tr>
</thead>
<tbody valign="top">
<tr class="row-even"><td><code class="notranslate">get()</code></td>
<td><code class="notranslate">getXXX()</code></td>
</tr>
<tr class="row-odd"><td><code class="notranslate">set()</code></td>
<td><code class="notranslate">setXXX()</code></td>
</tr>
<tr class="row-even"><td>n/a</td>
<td><code class="notranslate">replaceXXX()</code></td>
</tr>
<tr class="row-odd"><td><code class="notranslate">has()</code></td>
<td><code class="notranslate">hasXXX()</code></td>
</tr>
<tr class="row-even"><td><code class="notranslate">all()</code></td>
<td><code class="notranslate">getXXXs()</code></td>
</tr>
<tr class="row-odd"><td><code class="notranslate">replace()</code></td>
<td><code class="notranslate">setXXXs()</code></td>
</tr>
<tr class="row-even"><td><code class="notranslate">remove()</code></td>
<td><code class="notranslate">removeXXX()</code></td>
</tr>
<tr class="row-odd"><td><code class="notranslate">clear()</code></td>
<td><code class="notranslate">clearXXX()</code></td>
</tr>
<tr class="row-even"><td><code class="notranslate">isEmpty()</code></td>
<td><code class="notranslate">isEmptyXXX()</code></td>
</tr>
<tr class="row-odd"><td><code class="notranslate">add()</code></td>
<td><code class="notranslate">addXXX()</code></td>
</tr>
<tr class="row-even"><td><code class="notranslate">register()</code></td>
<td><code class="notranslate">registerXXX()</code></td>
</tr>
<tr class="row-odd"><td><code class="notranslate">count()</code></td>
<td><code class="notranslate">countXXX()</code></td>
</tr>
<tr class="row-even"><td><code class="notranslate">keys()</code></td>
<td>n/a</td>
</tr>
</tbody>
</table>

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Conventions de nommages des services

- A service name contains groups, separated by dots;
- The DI alias of the bundle is the first group (e.g. fos_user);
- Use lowercase letters for service and parameter names (except when referring to environment variables with the %env(VARIABLE_NAME)% syntax);
- A group name uses the underscore notation;
- Add class aliases for public services (e.g. alias Symfony\Component\Something\ClassName to something.service_name).

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Documentation

- Add PHPDoc blocks for all classes, methods, and functions (though you may be asked to remove PHPDoc that do not add value);
- Group annotations together so that annotations of the same type immediately follow each other, and annotations of a different type are separated by a single blank line;
- Omit the @return tag if the method does not return anything;
- The @package and @subpackage annotations are not used.

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Comment respecter tout ça ?
[PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer) + [PHP CS Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) = [Symplify/EasyCodingStandard](https://github.com/Symplify/EasyCodingStandard)

![](images/php/run-and-fix-smaller.gif)

--
<!-- .slide: data-title="Conventions de codage et de nommage des fichiers" -->
##### Respecter les conventions de code avec [Symplify/EasyCodingStandard](https://github.com/Symplify/EasyCodingStandard)
```bash
composer require --dev symplify/easy-coding-standard
```

```yml
# easy-coding-standard.neon
includes:
    - vendor/symplify/easy-coding-standard/config/symfony-checkers.neon
```

```bash
# dry (hook git)
php vendor/bin/ecs check src

# fix (hook git, outil externe PHPStorm)
php vendor/bin/ecs check src --fix
```

--

###### _TP : Installer et prendre en main Symfony_

--

#### Introduction au concept de « Bundle »
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

- __Bundle__ : équivalent des _plugins_ mais en mieux
- __Sf2__ : _tout_ est bundle
- __Bundles sur GitHub__ : [set of reusable PHP components](https://github.com/topics/symfony-bundle)
    + [symfony/symfony](https://github.com/symfony/symfony) The Symfony PHP framework
    + [FriendsOfSymfony/FOSUserBundle](https://github.com/FriendsOfSymfony/FOSUserBundle) User management
    + [api-platform / api-platform](https://github.com/api-platform/api-platform) Build hypermedia and GraphQL APIs in minutes
    + [javiereguiluz/EasyAdminBundle](https://github.com/topics/symfony-bundle)The new (and simple) admin generator for Symfony applications
    + etc.

--

#### Introduction au concept de ~~Bundle~~ Recette
<!-- .slide: data-title="Découvrir le framework Symfony 3 / 4" -->

- __Symfony Flex__ : bundles => recipes
- _Symfony Recipes Server_ : [https://symfony.sh/](https://symfony.sh/)
    + [api-platform/core](https://packagist.org/packages/api-platform/core)
    + [javiereguiluz/easyadmin-bundle](https://packagist.org/packages/javiereguiluz/easyadmin-bundle)

```json
{
    "bundles": {
        "ApiPlatform\\Core\\Bridge\\Symfony\\Bundle\\ApiPlatformBundle": ["all"]
    },
    "copy-from-recipe": {
        "config/": "%CONFIG_DIR%/",
        "src/": "%SRC_DIR%/"
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```json
{
    "bundles": {
        "EasyCorp\\Bundle\\EasyAdminBundle\\EasyAdminBundle": ["all"]
    },
    "copy-from-recipe": {
        "config/": "%CONFIG_DIR%/"
    },
    "aliases": ["admin-gen", "admin-generator", "admin"]
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Création de « Bundle »
<!-- .slide: data-title="Introduction au concept de « Bundle »" -->

```php
// src/Acme/TestBundle/AcmeTestBundle.php
namespace Acme\TestBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class AcmeTestBundle extends Bundle
{
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
// app/AppKernel.php
public function registerBundles()
{
    $bundles = array(
        // ...
        // register your bundle
        new Acme\TestBundle\AcmeTestBundle(),
    );
    // ...

    return $bundles;
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```bash
$ php bin/console generate:bundle --namespace=Acme/TestBundle
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Structure d'un « Bundle »
<!-- .slide: data-title="Introduction au concept de « Bundle »" -->

- `Controller/` : Les contrôleurs (RandomController.php)
- `DependencyInjection/` : Injection de dépendance, définition de configuration, enregistrement de service
- `Resources/config/` : Configuration liée au bundle
- `Resources/views/` : Templates organisés par contrôleurs (e.g. Random/index.html.twig).
- `Resources/public/` : Assets web (images, stylesheets, etc) copiés, ou symlinkés, via la commande `assets:install`
- `Tests/` : Tests du bundle

--

#### Installation de « Bundle »
<!-- .slide: data-title="Introduction au concept de « Bundle »" -->

1. Ajout du bundle via composer
2. Activation dans le `Kernel`
3. Configuration éventuelle

--

#### Installation de « Bundle »
<!-- .slide: data-title="Introduction au concept de « Bundle »" -->

Exemple avec [EasyAdmin](https://github.com/javiereguiluz/EasyAdminBundle)

![](images/php/easyadmin-promo.png) 
<!-- .element: class="plain" style="float: right; width: 280px;" -->

```bash
composer require javiereguiluz/easyadmin-bundle
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
<?php
// app/AppKernel.php

// ...
class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = array(
            // ...
            new EasyCorp\Bundle\EasyAdminBundle\EasyAdminBundle(),
        );
    }

    // ...
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```yml
# app/config/routing.yml
easy_admin_bundle:
    resource: "@EasyAdminBundle/Controller/AdminController.php"
    type:     annotation
    prefix:   /admin

```
<!-- .element: class="fragment current-visible current-visible-only" -->
```bash
php bin/console assets:install --symlink
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Installation de « Recipe »
<!-- .slide: data-title="Introduction au concept de « Bundle »" -->

Exemple avec [EasyAdmin](https://github.com/javiereguiluz/EasyAdminBundle)

```
$ composer req admin
  * Modify your DATABASE_URL config in .env

  * Configure the driver (mysql) and
    server_version (5.7) in config/packages/doctrine.yaml
```
<!-- .element: class="fragment" -->
![](images/php/6483603.jpg)
<!-- .element: class="fragment" -->

---

### 4. Savoir déboguer son code

- La barre de débogage (« Web Debug Toolbar »)
- La journalisation des erreurs (« logs »)
- L’interface de profilage des requêtes (« Web Profiler »)
- Les traces d’exception et d’erreur (« stack traces »)
- Les outils des composants Debug et VarDumper

--

#### La barre de débogage (« Web Debug Toolbar »)
<!-- .slide: data-title="Savoir déboguer son code" -->

![](images/php/sf-toolbar2.png)
<!-- .element: class="fragment plain" -->


![](images/php/sf-toolbar3.png)
<!-- .element: class="fragment plain" -->

- Code HTTP <!-- .element: class="fragment" -->
- Route <!-- .element: class="fragment" -->
- Durée requête <!-- .element: class="fragment" -->
- Consommation mémoire <!-- .element: class="fragment" -->
- Cache <!-- .element: class="fragment" -->
- Authentification <!-- .element: class="fragment" -->
- Durée rendu <!-- .element: class="fragment" -->
- Version de Symfony <!-- .element: class="fragment" -->

--

#### La journalisation des erreurs (« logs »)
<!-- .slide: data-title="Savoir déboguer son code" -->
##### Monolog - Logging for PHP

```php
use Psr\Log\LoggerInterface;

public function indexAction(LoggerInterface $logger)
{
    // alternative way of getting the logger
    // $logger = $this->get('logger');

    $logger->info('I just got the logger');
    $logger->error('An error occurred');

    $logger->critical('I left the oven on!', array(
        // include extra "context" info in your logs
        'cause' => 'in_hurry',
    ));
    // Par défaut dans app/logs/%kernel.environment%.log 
    // ou var/logs/%kernel.environment%.log
    // ...
}
```

--

#### La journalisation des erreurs (« logs »)
<!-- .slide: data-title="Savoir déboguer son code" -->
##### Rotation des logs

[logrotate](https://github.com/logrotate/logrotate) sur Linux

rotating_file

```yaml
# app/config/config_dev.yml
monolog:
    handlers:
        main:
            type:  rotating_file
            path:  '%kernel.logs_dir%/%kernel.environment%.log'
            level: debug
            # max number of log files to keep
            # defaults to zero, which means infinite files
            max_files: 10
```

--

#### L’interface de profilage des requêtes (« Web Profiler »)
<!-- .slide: data-title="Savoir déboguer son code" -->

- Request / Response <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Performance <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Forms <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Exception <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Logs <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Events <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Routing <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Cache <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Security <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Twig <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Doctrine <!-- .element: class="fragment" style="font-size: 0.8em" -->
- E-Mails <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Debug <!-- .element: class="fragment" style="font-size: 0.8em" -->
- Configuration <!-- .element: class="fragment" style="font-size: 0.8em" -->

--
<!-- .slide: data-title="Savoir déboguer son code" data-background-image="images/php/Profiler2.png"-->

--
<!-- .slide: data-title="Savoir déboguer son code" data-background-image="images/php/Profiler3.png"-->

--

#### Les traces d’exception et d’erreur (« stack traces »)
<!-- .slide: data-title="Savoir déboguer son code" -->

![](images/php/exception2.png) <!-- .element: class="plain" -->


![](images/php/exception3.png) <!-- .element: class="plain" -->

--
<!-- .slide: data-title="Savoir déboguer son code" data-background-image="images/php/exception2.1.png"-->

--
<!-- .slide: data-title="Savoir déboguer son code" data-background-image="images/php/exception2.2.png"-->

--
<!-- .slide: data-title="Savoir déboguer son code" data-background-image="images/php/exception3.1.png"-->

--
<!-- .slide: data-title="Savoir déboguer son code" data-background-image="images/php/exception3.2.png"-->

--

#### Les outils des composants Debug et VarDumper
<!-- .slide: data-title="Savoir déboguer son code" -->

- [Debug component](http://symfony.com/doc/current/components/debug.html) : outils pour faciliter le debugging
- [VarDumper Component](http://symfony.com/doc/current/components/var_dumper.html) : `var_dump` est mort, longue vie à `dump()`

```php
// create a variable, which could be anything!
$someVar = ...;
dump($someVar);
```
```twig
{% dump foo.bar %} => web debug toolbar
{{ dump(foo.bar) }} => inline
```

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
$var = array(
    'a simple string' => "in an array of 5 elements",
    'a float' => 1.0,
    'an integer' => 1,
    'a boolean' => true,
    'an empty array' => array(),
);
dump($var);
```
![](images/php/01-simple.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
$var = "This is a multi-line string.\n";
$var .= "Hovering a string shows its length.\n";
$var .= "The length of UTF-8 strings is counted in terms of UTF-8 characters.\n";
$var .= "Non-UTF-8 strings length are counted in octet size.\n";
$var .= "Because of this `\xE9` octet (\\xE9),\n";
$var .= "this string is not UTF-8 valid, thus the `b` prefix.\n";
dump($var);
```
![](images/php/02-multi-line-str.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
class PropertyExample
{
    public $publicProperty = 'The `+` prefix denotes public properties,';
    protected $protectedProperty = '`#` protected ones and `-` private ones.';
    private $privateProperty = 'Hovering a property shows a reminder.';
}

$var = new PropertyExample();
dump($var);
```
![](images/php/03-object.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
class DynamicPropertyExample
{
    public $declaredProperty = 'This property is declared in the class definition';
}

$var = new DynamicPropertyExample();
$var->undeclaredProperty = 'Runtime added dynamic properties have `"` around their name.';
dump($var);
```
![](images/php/04-dynamic-property.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
class ReferenceExample
{
    public $info = "Circular and sibling references are displayed as `#number`.\nHovering them highlights all instances in the same dump.\n";
}
$var = new ReferenceExample();
$var->aCircularReference = $var;
dump($var);
```
![](images/php/05-soft-ref.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
$var = new \ErrorException(
    "For some objects, properties have special values\n"
    ."that are best represented as constants, like\n"
    ."`severity` below. Hovering displays the value (`2`).\n",
    0,
    E_WARNING
);
dump($var);
```
![](images/php/06-constants.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
$var = array();
$var[0] = 1;
$var[1] =& $var[0];
$var[1] += 1;
$var[2] = array("Hard references (circular or sibling)");
$var[3] =& $var[2];
$var[3][] = "are dumped using `&number` prefixes.";
dump($var);
```
![](images/php/07-hard-ref.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
$var = new \ArrayObject();
$var[] = "Some resources and special objects like the current";
$var[] = "one are sometimes best represented using virtual";
$var[] = "properties that describe their internal state.";
dump($var);
```
![](images/php/08-virtual-property.png)

--

#### VarDumper : exemples
<!-- .slide: data-title="Savoir déboguer son code" -->

```php
$var = new AcmeController(
    "When a dump goes over its maximum items limit,\n"
    ."or when some special objects are encountered,\n"
    ."children can be replaced by an ellipsis and\n"
    ."optionally followed by a number that says how\n"
    ."many have been removed; `9` in this case.\n"
);
dump($var);
```
![](images/php/09-cut.png)

--

###### _TP : Utiliser la Web Debug Toolbar et le Profiler_

---

### 5. Configurer une application Symfony

- Comparatif des formats de configuration supportés : XML, YAML et PHP
- Configuration globale de l’application
- Configuration globale des URLs avec des annotations
- Surcharge d’un Bundle

--

#### Comparatif des formats de configuration supportés : XML, YAML et PHP
<!-- .slide: data-title="Configurer une application Symfony" -->

- __`YAML`__ : Simple, clair et lisible;
- __`XML`__ : Plus puissant que le YAML (IDE autocompletion);
- __`PHP`__ : Encore plus puissant mais beaucoup moins lisible;
- __`.env`__ : L'avenir, variables d'environnement en dev.

--

#### Comparatif des formats de configuration supportés : XML, YAML et PHP
<!-- .slide: data-title="Configurer une application Symfony" -->

```yml
# app/config/config.yml
imports:
    - { resource: parameters.yml }
    - { resource: security.yml }
    - { resource: services.yml }

framework:
    secret:          '%secret%'
    router:          { resource: '%kernel.project_dir%/app/config/routing.yml' }
    # ...

# Twig Configuration
twig:
    debug:            '%kernel.debug%'
    strict_variables: '%kernel.debug%'
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```xml
<!-- app/config/config.xml -->
<?xml version="1.0" encoding="UTF-8" ?>
<container xmlns="http://symfony.com/schema/dic/services"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:framework="http://symfony.com/schema/dic/symfony"
    xmlns:twig="http://symfony.com/schema/dic/twig"
    xsi:schemaLocation="http://symfony.com/schema/dic/services
        http://symfony.com/schema/dic/services/services-1.0.xsd
        http://symfony.com/schema/dic/symfony
        http://symfony.com/schema/dic/symfony/symfony-1.0.xsd
        http://symfony.com/schema/dic/twig
        http://symfony.com/schema/dic/twig/twig-1.0.xsd">

    <imports>
        <import resource="parameters.yml" />
        <import resource="security.yml" />
        <import resource="services.yml" />
    </imports>

    <framework:config secret="%secret%">
        <framework:router resource="%kernel.project_dir%/app/config/routing.xml" />
        <!-- ... -->
    </framework:config>

    <!-- Twig Configuration -->
    <twig:config debug="%kernel.debug%" strict-variables="%kernel.debug%" />

    <!-- ... -->
</container>
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
// app/config/config.php
$this->import('parameters.yml');
$this->import('security.yml');
$this->import('services.yml');

$container->loadFromExtension('framework', array(
    'secret' => '%secret%',
    'router' => array(
        'resource' => '%kernel.project_dir%/app/config/routing.php',
    ),
    // ...
));

// Twig Configuration
$container->loadFromExtension('twig', array(
    'debug'            => '%kernel.debug%',
    'strict_variables' => '%kernel.debug%',
));
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Configuration globale de l’application
<!-- .slide: data-title="Configurer une application Symfony" -->

- Référence :

```
php bin/console config:dump-reference twig
```
- [Symfony Reference](http://symfony.com/doc/master/reference/index.html)

--

#### Configuration globale ~~de l’application~~ des différents paquets
<!-- .slide: data-title="Configurer une application Symfony" -->

- `config/packages/`

```yml
# config/packages/framework.yaml
framework:
    secret: '%env(APP_SECRET)%'
    #default_locale: en
    #csrf_protection: ~
    #http_method_override: true
    #trusted_hosts: ~
    # https://symfony.com/doc/current/reference/configuration/framework.html#handler-id
    #session:
    #    # The native PHP session handler will be used
    #    handler_id: ~
    #esi: ~
    #fragments: ~
    php_errors:
        log: true
```

--

#### Configuration globale de l’application
<!-- .slide: data-title="Configurer une application Symfony" -->

- `.env`

```yml
# This file is a "template" of which env vars need to be defined for your application
# Copy this file to .env file for development, create environment variables when deploying to production
# https://symfony.com/doc/current/best_practices/configuration.html#infrastructure-related-configuration

###> symfony/framework-bundle ###
APP_ENV=dev
APP_SECRET=78a1d22b6cc08b2e023694cc228a5e45
###< symfony/framework-bundle ###

###> doctrine/doctrine-bundle ###
# Format described at http://docs.doctrine-project.org/projects/doctrine-dbal/en/latest/reference/configuration.html#connecting-using-a-url
# For an SQLite database, use: "sqlite:///%kernel.project_dir%/var/data.db"
# Configure your db driver and server_version in config/packages/doctrine.yaml
DATABASE_URL=mysql://db_user:db_password@127.0.0.1:3306/db_name
###< doctrine/doctrine-bundle ###
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```yml
#config/packages/doctrine.yaml
parameters:
    # Adds a fallback DATABASE_URL if the env var is not set.
    # This allows you to run cache:warmup even if your
    # environment variables are not available yet.
    # You should not need to change this value.
    env(DATABASE_URL): ''

doctrine:
    dbal:
        # configure these for your database server
        driver: 'pdo_mysql'
        server_version: '5.7'
        charset: utf8mb4

        # With Symfony 3.3, remove the `resolve:` prefix
        url: '%env(resolve:DATABASE_URL)%'
    orm:
        auto_generate_proxy_classes: '%kernel.debug%'
        naming_strategy: doctrine.orm.naming_strategy.underscore
        auto_mapping: true
        mappings:
            App:
                is_bundle: false
                type: annotation
                dir: '%kernel.project_dir%/src/Entity'
                prefix: 'App\Entity'
                alias: App
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Configuration globale des URLs avec des annotations
<!-- .slide: data-title="Configurer une application Symfony" -->

```yml
# config/routes.yaml
blog_list:
    path:     /blog
    controller: App\Controller\BlogController::list

blog_show:
    path:     /blog/{slug}
    controller: App\Controller\BlogController::show
```

```php
// src/Controller/BlogController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Routing\Annotation\Route;

class BlogController extends Controller
{
    /**
     * Matches /blog exactly
     *
     * @Route("/blog", name="blog_list")
     */
    public function list()
    {
        // ...
    }

    /**
     * Matches /blog/*
     *
     * @Route("/blog/{slug}", name="blog_show")
     */
    public function show($slug)
    {
        // $slug will equal the dynamic part of the URL
        // e.g. at /blog/yay-routing, then $slug='yay-routing'

        // ...
    }

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        $posts = $this->getDoctrine()
            ->getRepository(Post::class)
            ->findLatest();

        return $this->render('default/index.html.twig', array(
            'posts' => $posts
        ));
    }

    /**
     * @Route("/{id}", name="admin_post_show")
     */
    public function showAction(Post $post)
    {
        $deleteForm = $this->createDeleteForm($post);

        return $this->render('admin/post/show.html.twig', array(
            'post'        => $post,
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * @Route("/comment/{postSlug}/new", name="comment_new")
     */
    public function newAction(Request $request, $postSlug)
    {
        $post = $this->getDoctrine()
            ->getRepository(Post::class)
            ->findOneBy(array('slug' => $postSlug));

        if (!$post) {
            throw $this->createNotFoundException();
        }

        // ...
    }

    /**
     * @Route("/comment/{postSlug}/new", name="comment_new")
     * @ParamConverter("post", options={"mapping": {"postSlug": "slug"}})
     */
    public function newAction(Request $request, Post $post)
    {
        // ...
    }

    /**
     * @Route(
     *     "/articles/{_locale}/{year}/{slug}.{_format}",
     *     defaults={"_format": "html"},
     *     requirements={
     *         "_locale": "en|fr",
     *         "_format": "html|rss",
     *         "year": "\d+"
     *     }
     * )
     */
    public function showAction($_locale, $year, $slug)
    {
    }

    /**
     * @Route(
     *     "/",
     *     name="homepage",
     *     host="{subdomain}.probikeshop.com",
     *     defaults={"subdomain"="preprod7"},
     *     requirements={"subdomain"="preprod[1-47]"}
     * )
     */
    public function probikeshopHomepageAction()
    {
        // ...
    }
}
```

--

#### Générer des URLs dans les contrôleurs
<!-- .slide: data-title="Configuration globale des URLs avec des annotations" -->

```php
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class MainController extends Controller
{
    /**
     * @Route("/", name="welcome")
     */
    public function indexAction()
    {
        // ...
    }

    /**
     * @Route("/article/{slug}", name="article_show")
     */
    public function showAction($slug)
    {
        // ...

        // /blog/my-blog-post
        $url = $this->generateUrl(
            'blog_show',
            array('slug' => 'my-blog-post')
        );

        // http://www.example.com/blog/my-blog-post
        $url = $this->generateUrl(
            'blog_show',
            array('slug' => 'my-blog-post'),
            UrlGeneratorInterface::ABSOLUTE_URL
        );

        // http://www.example.com/blog/my-blog-post?toto=42
        $url = $this->generateUrl(
            'blog_show',
            array('slug' => 'my-blog-post', 'toto' => 42),
            UrlGeneratorInterface::ABSOLUTE_URL
        );

    }
}
```

--

#### Générer des URLs dans les templates
<!-- .slide: data-title="Configuration globale des URLs avec des annotations" -->

```twig
{# templates/article/recent_list.html.twig #}
{# {{ path(name, parameters = [], relative = false) }} #}
{% for article in articles %}
    <a href="{{ path('article_show', {'slug': article.slug}) }}">
        {{ article.title }}
    </a>
{% endfor %}
{# {{ url(name, parameters = [], schemeRelative = false) }} #}
<a href="{{ url('welcome') }}">Home</a>
```

--

#### Générer des URLs en JS
<!-- .slide: data-title="Configuration globale des URLs avec des annotations" -->
[FOSJsRoutingBundle](https://symfony.com/doc/master/bundles/FOSJsRoutingBundle/index.html)

```twig
<script src="{{ asset('bundles/fosjsrouting/js/router.js') }}"></script>
<script src="{{ path('fos_js_routing_js', { callback: 'fos.Router.setData' }) }}"></script>
{# $ php bin/console fos:js-routing:dump #}
{% javascripts filter='?yui_js'
    'bundles/fosjsrouting/js/router.js'
    'js/fos_js_routes.js'
%}
    <script src="{{ asset_url }}"></script>
{% endjavascripts %}
```

```php
// src/Controller/DefaultController.php

/**
 * @Route("/foo/{id}/bar", options={"expose"=true}, name="my_route_to_expose")
 */
public function indexAction($foo) {
    // ...
}

/**
 * @Route("/blog/{page}",
 *     defaults = { "page" = 1 },
 *     options = { "expose" = true },
 *     name = "my_route_to_expose_with_defaults",
 * )
 */
public function blogAction($page) {
    // ...
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
Routing.generate('route_name', /* your params */);
Routing.generate('route_name', /* your params */, true);

Routing.generate('my_route_to_expose', { id: 10, foo: "bar" });
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Surcharge d’un Bundle
<!-- .slide: data-title="Configurer une application Symfony" -->

- Templates
- Routing
- Controllers
- Services & Configuration
- Entities & Entity Mapping
- Forms
- Validation Metadata
- Translations

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Templates

- AcmeBlogBundle :
    + vendor/acme/blog-bundle/src/Resources/views/Blog/index.html.twig<!-- .element: style="font-size: 0.6em" -->
    + app/Resources/AcmeBlogBundle/views/Blog/index.html.twig<!-- .element: style="font-size: 0.6em" -->
- Core template (TwigBundle) :
    + vendor/symfony/symfony/src/Symfony/Bundle/TwigBundle/Resources/views/Exception/error.html.twig<!-- .element: style="font-size: 0.6em" -->
    + app/Resources/TwigBundle/views/Exception/error.html.twig<!-- .element: style="font-size: 0.6em" -->

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Routing

- Pas d'import auto
- Copier le routing du bundle, importer/surcharger cette copie

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Controllers

```php
// src/UserBundle/UserBundle.php
namespace UserBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class UserBundle extends Bundle
{
    public function getParent()
    {
        return 'FOSUserBundle';
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
// src/UserBundle/Controller/RegistrationController.php
namespace UserBundle\Controller;

use FOS\UserBundle\Controller\RegistrationController as BaseController;

class RegistrationController extends BaseController
{
    public function registerAction()
    {
        $response = parent::registerAction();

        // ... do custom stuff
        return $response;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

Symfony >=4 : override de services
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Services & Configuration

```php
// src/Acme/DemoBundle/DependencyInjection/Compiler/OverrideServiceCompilerPass.php
namespace Acme\DemoBundle\DependencyInjection\Compiler;

use Acme\DemoBundle\YourService;
use Symfony\Component\DependencyInjection\Compiler\CompilerPassInterface;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class OverrideServiceCompilerPass implements CompilerPassInterface
{
    public function process(ContainerBuilder $container)
    {
        $definition = $container->getDefinition('original-service-id');
        $definition->setClass(YourService::class);
    }
}
```
cf. [How to Work with Compiler Passes in Bundles](http://symfony.com/doc/current/service_container/compiler_passes.html)

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Entities & Entity Mapping

- Impossible avec Doctrine
- Utiliser mapped superclass cf. [override attributes and associations](http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/reference/inheritance-mapping.html#overrides)

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Forms

```php
// src/Form/Extension/ImageTypeExtension.php
namespace App\Form\Extension;

use Symfony\Component\Form\AbstractTypeExtension;
use Symfony\Component\Form\Extension\Core\Type\FileType;

class ImageTypeExtension extends AbstractTypeExtension
{
    /**
     * Returns the name of the type being extended.
     *
     * @return string The name of the type being extended
     */
    public function getExtendedType()
    {
        // use FormType::class to modify (nearly) every field in the system
        return FileType::class;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<container xmlns="http://symfony.com/schema/dic/services"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://symfony.com/schema/dic/services
        http://symfony.com/schema/dic/services/services-1.0.xsd">

    <services>
        <service id="App\Form\Extension\ImageTypeExtension">
            <tag name="form.type_extension" extended-type="Symfony\Component\Form\Extension\Core\Type\FileType" />
        </service>
    </services>
</container>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

cf. [How to Create a Form Type Extension](http://symfony.com/doc/master/form/create_form_type_extension.html)

<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Validation Metadata

- Symfony charge et combine toutes les contraintes de validation
- Surcharge via [Validation Groups](http://symfony.com/doc/current/validation/groups.html)

```yml
# src/Acme/UserBundle/Resources/config/validation.yml
FOS\UserBundle\Model\User:
    properties:
        plainPassword:
            - NotBlank:
                groups: [AcmeValidation]
            - Length:
                min: 6
                minMessage: fos_user.password.short
                groups: [AcmeValidation]
```

--
<!-- .slide: data-title="Surcharge d'un Bundle" -->
##### Translations

- Les traductions ne sont pas liées au bundle, mais au domaine
- Attention les traductions sont chargées/surchargées dans l'ordre des bundles du `AppKernel`
- Surcharge avec [le bon domaine](http://symfony.com/doc/current/components/translation.html#using-message-domains)
- Les traductions dans `app/Resources/translations` prennent le dessus sur les autres

--

###### _TP : Configurer une application Symfony_

---

### 6. Concevoir des actions et analyser la requête de l'utilisateur

<ul style="font-size: 0.9em">
<li>Définition d’une classe de contrôleur et des méthodes d’action</li>
<li>Associer une URL à un contrôleur grâce aux annotations</li>
<li>Générer une réponse brute ou à partir d’un gabarit</li>
<li>Accéder à l’objet de requête de l’utilisateur</li>
<li>Gérer des formulaires</li>
<li>Lire et écrire des données dans la session de l’utilisateur</li>
<li>Lire et écrire dans un cookie</li>
<li>Déclencher une page de type 404</li>
<li>Déclencher une redirection interne vers une autre action</li>
</ul>

--

#### Définition d’une classe de contrôleur et des méthodes d’action
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```
composer req maker-bundle
bin/console make:controller

 Choose a name for your controller class (e.g. AgreeableElephantController):
 > DefaultController

 created: src/Controller/DefaultController.php

           
  Success! 
           

 Next: Open your new controller class and add some pages!
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
<?php

namespace App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends AbstractController
{
    /**
     * @Route("/default", name="default")
     */
    public function index()
    {
        // replace this line with your own code!
        return $this->render('@Maker/demoPage.html.twig', [ 'path' => str_replace($this->getParameter('kernel.project_dir').'/', '', __FILE__) ]);
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

![](images/php/The simplest Request-Response Flow.svg)
<!-- .element: class="plain" style="transform: rotate(90deg) translateX(-30%);"-->

--

<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->
![](images/php/The advanced Request-Response Flow.svg)
<!-- .element: class="plain" style="transform: rotate(90deg) translateX(-30%);"-->

--

<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->
![](images/php/The complete Request-Response Flow.svg)
<!-- .element: class="plain" style="transform: rotate(90deg) translateX(-30%);"-->

--

<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->
![](images/php/The complete Request-Response Flow2.svg)
<!-- .element: class="plain" style="transform: rotate(90deg) translateX(-30%);"-->

--

<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->
![](images/php/The complete Request-Response Flow3.svg)
<!-- .element: class="plain" style="transform: rotate(90deg) translateX(-30%);"-->

--

<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->
![](images/php/The complete Request-Response Flow4.svg)
<!-- .element: class="plain" style="transform: rotate(90deg) translateX(-30%);"-->

--

#### Associer une URL à un contrôleur grâce aux annotations
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

##### Exemple de route simple
```php
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
class BlogController extends Controller
{
    /**
    * @Route("/blog", name="blog_list")
    */
    public function listAction()
    {
        // ...
    }
}
```

--
<!-- .slide: data-title="Associer une URL à un contrôleur grâce aux annotations" -->
##### Route avec placeholders (variables)
```php
/**
* @Route("/blog/{page}", name="blog_list")
*/
public function listAction($page)
{
// $page variable is available here
// ...
}
```

--
<!-- .slide: data-title="Associer une URL à un contrôleur grâce aux annotations" -->
##### Route avec valeur par défaut [1/2]
```php
/**
* @Route(
*  "/blog/{page}",
*  defaults = {"page": "1"},
*  name = "blog_list"
* )
*/
public function listAction($page)
{
// ...
}
```

--
<!-- .slide: data-title="Associer une URL à un contrôleur grâce aux annotations" -->
##### Route avec valeur par défaut [2/2]
```php
/**
* @Route("/blog/{page}", name="blog_list")
*/
public function listAction($page = 1)
{
// ...
}
```

--
<!-- .slide: data-title="Associer une URL à un contrôleur grâce aux annotations" -->
##### Route avec contrainte [1/2]
```php
/**
* @Route(
*  "/blog/{page}",
*  requirements = { "page": "\d+" },
*  name = "blog_list"
* )
*/
public function listAction($page)
{
// ...
}
```

--
<!-- .slide: data-title="Associer une URL à un contrôleur grâce aux annotations" -->
##### Route avec contrainte [2/2]
```php
/**
* @Route("/blog/{page}", name="blog_list")
* @Method("GET")
*/
public function listAction($page)
{
// ...
}
```

--
<!-- .slide: data-title="Associer une URL à un contrôleur grâce aux annotations" -->
##### Route complexe
```php
/**
* @Route(
*  "/blog/{page}",
*  defaults={"page": "1"},
*  requirements={ "page": "\d+" },
*  name="blog_list"
* )
* @Method({ "GET", "HEAD" })
*/
public function listAction($page)
{
// ...
}
```

--

#### Générer une réponse brute ou à partir d’un gabarit
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```php
namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class HelloController extends Controller
{
    /**
     * @Route("/hello")
     */
    public function helloAction()
    {
        return new Response(
            '<html><body>Hello World!</body></html>'
        );
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class HelloController extends Controller
{
    /**
     * @Route("/hello/{name}")
     */
    public function helloAction($name = 'stranger')
    {
        return $this->render('App:Hello:hello.html.twig', array(
            'name' => $name
        ));
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```twig
{# App:Hello:hello.html.twig #}
{% extends "::base.html.twig" %}

{% block title %}App:Hello:hello{% endblock %}

{% block body %}
<h1>Hello {{name}}</h1>
{% endblock %}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```twig
{# base.html.twig #}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>{% block title %}Welcome!{% endblock %}</title>
        {% block stylesheets %}{% endblock %}
        <link rel="icon" type="image/x-icon" href="{{ asset('favicon.ico') }}" />
    </head>
    <body>
        {% block body %}{% endblock %}
        {% block javascripts %}{% endblock %}
    </body>
</html>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Accéder à l’objet de requête de l’utilisateur
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class HelloController extends Controller
{
    /**
     * @Route("/hello/{name}")
     */
    public function helloAction($name = 'stranger')
    {
        return $this->render('App:Hello:hello.html.twig', array(
            'name' => $name
        ));
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class HelloController extends Controller
{
    /**
     * @Route("/hello/{name}")
     */
    public function helloAction(Request $request, $name = 'stranger')
    {
        $request->isXmlHttpRequest(); // is it an Ajax request?

        $request->getPreferredLanguage(array('en', 'fr'));

        // retrieve GET and POST variables respectively
        $request->query->get('page');
        $request->request->get('page');

        // retrieve SERVER variables
        $request->server->get('HTTP_HOST');

        // retrieves an instance of UploadedFile identified by foo
        $request->files->get('foo');

        // retrieve a COOKIE value
        $request->cookies->get('PHPSESSID');

        // retrieve an HTTP request header, with normalized, lowercase keys
        $request->headers->get('host');
        $request->headers->get('content_type');

        return $this->render('App:Hello:hello.html.twig', array(
            'name' => $name
        ));
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### [Gérer des formulaires](https://symfony.com/doc/3.3/forms.html)
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->
##### Formulaires simples

```php
// src/Entity/Task.php
namespace App\Entity;

class Task
{
    protected $task;
    protected $dueDate;

    public function getTask()
    {
        return $this->task;
    }

    public function setTask($task)
    {
        $this->task = $task;
    }

    public function getDueDate()
    {
        return $this->dueDate;
    }

    public function setDueDate(\DateTime $dueDate = null)
    {
        $this->dueDate = $dueDate;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
// src/Controller/DefaultController.php
namespace App\Controller;

use App\Entity\Task;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class DefaultController extends Controller
{
    public function newAction(Request $request)
    {
        // create a task and give it some dummy data for this example
        $task = new Task();
        $task->setTask('Write a blog post');
        $task->setDueDate(new \DateTime('tomorrow'));

        $form = $this->createFormBuilder($task)
            ->add('task', TextType::class)
            ->add('dueDate', DateType::class)
            ->add('save', SubmitType::class, array('label' => 'Create Task'))
            ->getForm();

        return $this->render('default/new.html.twig', array(
            'form' => $form->createView(),
        ));
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```twig
{# app/Resources/views/default/new.html.twig #}
{{ form_start(form) }}
{{ form_widget(form) }}
{{ form_end(form) }}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Formulaires simples" -->
##### Soumettre le formulaire

```php
use Symfony\Component\HttpFoundation\Request;

public function newAction(Request $request)
{
    // just setup a fresh $task object (remove the dummy data)
    $task = new Task();

    $form = $this->createFormBuilder($task)
        ->add('task', TextType::class)
        ->add('dueDate', DateType::class)
        ->add('save', SubmitType::class, array('label' => 'Create Task'))
        ->getForm();

    $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        // $form->getData() holds the submitted values
        // but, the original `$task` variable has also been updated
        $task = $form->getData();

        // ... perform some action, such as saving the task to the database
        // for example, if Task is a Doctrine entity, save it!
        // $em = $this->getDoctrine()->getManager();
        // $em->persist($task);
        // $em->flush();

        return $this->redirectToRoute('task_success');
    }

    return $this->render('default/new.html.twig', array(
        'form' => $form->createView(),
    ));
}
```

--

<!-- .slide: data-title="Formulaires simples" -->
##### Valider les données du formulaires

```php
// src/Entity/Task.php
namespace App\Entity;

use Symfony\Component\Validator\Constraints as Assert;

class Task
{
    /**
     * @Assert\NotBlank()
     */
    public $task;

    /**
     * @Assert\NotBlank()
     * @Assert\Type("\DateTime")
     */
    protected $dueDate;
}
```

```php
use App\Form\TaskType;

public function newAction(Request $request)
{
    $task = new Task();
    $form = $this->createForm(TaskType::class, $task);
}
```

--

<!-- .slide: data-title="Gérer des formulaires" -->
##### Protéger le formulaire avec un jeton CSRF

```php
// src/Form/TaskType.php
namespace App\Form;

use App\Entity\Task;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TaskType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('task', TextType::class)
            ->add('dueDate', DateType::class)
            ->add('save', SubmitType::class, array('label' => 'Create Task'))
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class'      => Task::class,
            'csrf_protection' => true,
            'csrf_field_name' => '_token',
            // a unique key to help generate the secret token
            'csrf_token_id'   => 'task_item',
        ));
    }
}
```

--

<!-- .slide: data-title="Gérer des formulaires" -->
##### Protéger le formulaire avec un jeton CSRF

- Pour les formulaires en Ajax :
    + désactiver le CSRF
    + le jeton se trouvera en entête HTTP (préalablement stocké dans un cookie)
    + validé manuellement

cf. [How to Manually Validate a CSRF Token in a Controller](https://symfony.com/doc/current/controller/csrf_token_validation.html)

[DunglasAngularCsrfBundle](https://github.com/dunglas/DunglasAngularCsrfBundle)

--

#### Lire et écrire des données dans la session de l’utilisateur
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```php
use Symfony\Component\HttpFoundation\Session\Session;

$session = new Session();
$session->start();

// set and get session attributes
$session->set('name', 'Drak');
$session->get('name');

// set flash messages
$session->getFlashBag()->add('notice', 'Profile updated');

// retrieve messages
foreach ($session->getFlashBag()->get('notice', array()) as $message) {
    echo '<div class="flash-notice">'.$message.'</div>';
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
// Dans les controlleurs
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\HttpFoundation\Request;

public function indexAction(SessionInterface $session)
{
    // store an attribute for reuse during a later user request
    $session->set('foo', 'bar');

    // get the attribute set by another controller in another request
    $foobar = $session->get('foobar');

    // use a default value if the attribute doesn't exist
    $filters = $session->get('filters', array());
}

public function updateAction(Request $request)
{
    // ...

    if ($form->isSubmitted() && $form->isValid()) {
        // do some sort of processing

        $this->addFlash(
            'notice',
            'Your changes were saved!'
        );
        // $this->addFlash() is equivalent to $request->getSession()->getFlashBag()->add()

        return $this->redirectToRoute(...);
    }

    return $this->render(...);
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```twig
{# app/Resources/views/base.html.twig #}

{# you can read and display just one flash message type... #}
{% for message in app.flashes('notice') %}
    <div class="flash-notice">
        {{ message }}
    </div>
{% endfor %}

{# ...or you can read and display every flash message available #}
{% for label, messages in app.flashes %}
    {% for message in messages %}
        <div class="flash-{{ label }}">
            {{ message }}
        </div>
    {% endfor %}
{% endfor %}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

cf. [Session Management](https://symfony.com/doc/current/components/http_foundation/sessions.html) 

<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Lire et écrire dans un cookie
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```php
use Symfony\Component\HttpFoundation\Cookie;

$cookie = new Cookie('foo', 'bar', strtotime('now + 10 minutes'));
// Assuming that the current time is "Wed, 28-Dec-2016 15:00:00 +0100",
// this will be the HTTP header added for the cookie:
// Set-Cookie: foo=bar; Expires=Wed, 28-Dec-2016 15:10:00 +0100; Max-Age=600

// Creating cookies with arguments
$cookie = new Cookie('foo', 'bar', strtotime('Wed, 28-Dec-2016 15:00:00 +0100'), '/', '.example.com', true, true, true),

// Creating cookies with a string
$cookie = Cookie::fromString('foo=bar; expires=Wed, 28-Dec-2016 15:00:00 +0100; path=/; domain=.example.com; secure; httponly');

// adding cookies using objects
$response->headers->setCookie(new Cookie('foo', 'bar'));

// adding cookies using strings
$response->headers->set('set-cookie', 'foo=bar', false);
```

--

#### Déclencher une page de type 404
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```php
public function indexAction()
{
    // retrieve the object from database
    $product = ...;
    if (!$product) {
        throw $this->createNotFoundException('The product does not exist');
        // 404
    }

    return $this->render(...);
}

public function otherAction()
{
    // retrieve the object from database
    $product = ...;
    if (!$product) {
        throw new \Exception('Something went wrong!');
        // 500
    }

    return $this->render(...);
}
```

--

#### Déclencher une redirection interne vers une autre action
<!-- .slide: data-title="Concevoir des actions et analyser la requête de l'utilisateur" -->

```php
public function indexAction()
{
    // redirect to the "homepage" route
    return $this->redirectToRoute('homepage');

    // do a permanent - 301 redirect
    return $this->redirectToRoute('homepage', array(), 301);

    // redirect to a route with parameters
    return $this->redirectToRoute('blog_show', array('slug' => 'my-page'));

    // redirect externally
    return $this->redirect('http://symfony.com/doc');
}
```

--

###### _TP : Concevoir des actions et analyser la requête de l'utilisateur_

---

### 7. Internationaliser et localiser l'interface utilisateur

Merci Sensio 
+ [Building your translation process](https://github.com/SymfonyCon/2017-talks#building-your-translation-process)


`app/config/config.yml` => `config/packages/translation.yaml`

<!-- .element class="fragment current-visible highlight-current-red" -->

--

<!-- .slide: data-background-iframe="http://localhost:8000/iframe/sensio/i18n.pdf" -->

--

###### _TP : Internationaliser et localiser l'interface utilisateur_

---

### 8. Injection de dépendance et registre de services

Merci Sensio


`app/config/services.yml` => `config/services.yaml`

<!-- .element class="fragment current-visible highlight-current-red" -->

--

<!-- .slide: data-background-iframe="http://localhost:8000/iframe/sensio/DependencyInjection.pdf" -->

--

###### _TP : Injection de dépendance et registre de services_

---

### 9. Sécuriser l'accès à certaines pages de l'application

Merci Sensio <!-- .element class="fragment" -->

`app/config/security.yml` => `config/packages/security.yaml`

<!-- .element class="fragment current-visible highlight-current-red" -->
`app/config/routing.yml ` => `config/routes.yaml`

<!-- .element class="fragment current-visible highlight-current-red" -->

--

<!-- .slide: data-background-iframe="http://localhost:8000/iframe/sensio/Security.pdf" -->

--

###### _TP : Sécuriser l'accès à certaines pages de l'application_

---

### 10. Améliorer les performances avec le cache HTTP et ESI

Merci Sensio <!-- .element class="fragment" -->

`web/app_dev.php` => `public/index.php`

<!-- .element class="fragment current-visible highlight-current-red" -->

`app/config/config.yml` => `config/packages/translation.yaml`

<!-- .element class="fragment current-visible highlight-current-red" -->

--

<!-- .slide: data-background-iframe="http://localhost:8000/iframe/sensio/HTTPCaching.pdf" -->

--

###### _TP : Améliorer les performances avec le cache HTTP et ESI_

---

### 11. Interagir avec une base de données relationnelle

<ul style="font-size: 0.7em">
<li>Configuring the Database</li>
<li>Creating an Entity Class</li>
<li>Add Mapping Information</li>
<li>Generating Getters and Setters</li>
<li>Creating the Database Tables/Schema</li>
<li>Updating the Database Tables/Schema</li>
<li>Versionning the Database Tables/Schema</li>
<li>Persisting Objects to the Database</li>
<li>Fetching Objects from the Database</li>
<li>Updating an Object</li>
<li>Deleting an Object</li>
<li>Querying for Objects with DQL</li>
<li>Querying for Objects Using Doctrine's Query Builder</li>
<li>How to use Doctrine Extensions: Timestampable, Sluggable, Translatable, etc.</li>
</ul>

--

#### Découvrir l'ORM Doctrine
<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->

##### Configuring the Database

```yml
# This file is a "template" of which env vars need to be defined for your application
# Copy this file to .env file for development, create environment variables when deploying to production
# https://symfony.com/doc/current/best_practices/configuration.html#infrastructure-related-configuration

###> symfony/framework-bundle ###
APP_ENV=dev
APP_SECRET=78a1d22b6cc08b2e023694cc228a5e45
###< symfony/framework-bundle ###

###> doctrine/doctrine-bundle ###
# Format described at http://docs.doctrine-project.org/projects/doctrine-dbal/en/latest/reference/configuration.html#connecting-using-a-url
# For an SQLite database, use: "sqlite:///%kernel.project_dir%/var/data.db"
# Configure your db driver and server_version in config/packages/doctrine.yaml
DATABASE_URL=mysql://root:root@db:3306/probikeshop
###< doctrine/doctrine-bundle ###
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```yml
#config/packages/doctrine.yaml
parameters:
    # Adds a fallback DATABASE_URL if the env var is not set.
    # This allows you to run cache:warmup even if your
    # environment variables are not available yet.
    # You should not need to change this value.
    env(DATABASE_URL): ''

doctrine:
    dbal:
        # configure these for your database server
        driver: 'pdo_mysql'
        server_version: '5.7'
        charset: utf8mb4

        # With Symfony 3.3, remove the `resolve:` prefix
        # url: '%env(resolve:DATABASE_URL)%'
        url: '%env(DATABASE_URL)%'
    orm:
        auto_generate_proxy_classes: '%kernel.debug%'
        naming_strategy: doctrine.orm.naming_strategy.underscore
        auto_mapping: true
        mappings:
            App:
                is_bundle: false
                type: annotation
                dir: '%kernel.project_dir%/src/Entity'
                prefix: 'App\Entity'
                alias: App
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```bash
$ php bin/console doctrine:database:create
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Creating an Entity Class

```php
// src/Entity/Product.php
namespace App\Entity;

class Product
{
    private $name;
    private $price;
    private $description;
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Add Mapping Information
```php
// src/Entity/Product.php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="product")
 */
class Product
{
    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $name;

    /**
     * @ORM\Column(type="decimal", scale=2)
     */
    private $price;

    /**
     * @ORM\Column(type="text")
     */
    private $description;

    // Getters and Setters
}
```
```bash
$ php bin/console doctrine:schema:validate
$ php bin/console make:entity
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Generating Getters and Setters

```bash
$ php bin/console doctrine:generate:entities App:Product
```

```php
// src/Entity/Product.php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="product")
 */
class Product
{
    // Getters and Setters
    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     * @return Product
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string 
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set price
     *
     * @param string $price
     * @return Product
     */
    public function setPrice($price)
    {
        $this->price = $price;

        return $this;
    }

    /**
     * Get price
     *
     * @return string 
     */
    public function getPrice()
    {
        return $this->price;
    }

    /**
     * Set description
     *
     * @param string $description
     * @return Product
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string 
     */
    public function getDescription()
    {
        return $this->description;
    }
}
```

- [Console command d:g:entities cannot find base path #723](https://github.com/doctrine/DoctrineBundle/issues/723) <!-- .element: style="font-size: 0.7em" -->
- [Symfony Flex - Generating entity #729](https://github.com/doctrine/DoctrineBundle/issues/729) <!-- .element: style="font-size: 0.7em" -->

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Creating the Database Tables/Schema

```bash
$ php bin/console doctrine:schema:update --force
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```sql
CREATE TABLE product (
    id INT AUTO_INCREMENT NOT NULL, 
    name VARCHAR(100) NOT NULL, 
    price NUMERIC(10, 2) NOT NULL, 
    description LONGTEXT NOT NULL, 
    PRIMARY KEY(id)
    ) 
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE = InnoDB;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Updating the Database Tables/Schema

```php
    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```bash
$ php bin/console doctrine:schema:update --force
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```sql
ALTER TABLE product CHANGE name name VARCHAR(255) NOT NULL;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Versionning the Database Tables/Schema : [DoctrineMigrationsBundle](https://symfony.com/doc/current/bundles/DoctrineMigrationsBundle/index.html)

```bash
doctrine:migrations
  :diff     Generate a migration by comparing your current database to your mapping information.
  :execute  Execute a single migration version up or down manually.
  :generate Generate a blank migration class.
  :migrate  Execute a migration to a specified version or the latest available version.
  :status   View the status of a set of migrations.
  :version  Manually add and delete migration versions from the version table.
```

```php
namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration,
    Doctrine\DBAL\Schema\Schema;

class Version20100621140655 extends AbstractMigration
{
    public function up(Schema $schema)
    {
    }
    public function down(Schema $schema)
    {
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
// app/DoctrineMigrations/2017/11/Version20171122102449.php
namespace Application\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20171122102449 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE product (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(100) NOT NULL, price NUMERIC(10, 2) NOT NULL, description LONGTEXT NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ENGINE = InnoDB');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE product');
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Persisting Objects to the Database

```php
// src/Controller/DefaultController.php

// ...
use App\Entity\Product;
use Symfony\Component\HttpFoundation\Response;
use Doctrine\ORM\EntityManagerInterface;

public function createAction()
{
    // you can fetch the EntityManager via $this->getDoctrine()
    // or you can add an argument to your action: createAction(EntityManagerInterface $em)
    $em = $this->getDoctrine()->getManager();

    $product = new Product();
    $product->setName('Keyboard');
    $product->setPrice(19.99);
    $product->setDescription('Ergonomic and stylish!');

    // tells Doctrine you want to (eventually) save the Product (no queries yet)
    $em->persist($product);

    // actually executes the queries (i.e. the INSERT query)
    $em->flush();

    return new Response('Saved new product with id '.$product->getId());
}

// if you have multiple entity managers, use the registry to fetch them
public function editAction()
{
    $doctrine = $this->getDoctrine();
    $em = $doctrine->getManager();
    $em2 = $doctrine->getManager('other_connection');
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Persisting Objects to the Database using form

```bash
php bin/console doctrine:generate:form App:Product
```
```php
//App/Form/ProductType.php
namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ProductType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('name')
            ->add('price')
            ->add('description');
    }

    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'App\Entity\Product',
        ));
    }

    /**
     * {@inheritdoc}
     */
    public function getBlockPrefix()
    {
        return 'app_product';
    }
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Persisting Objects to the Database using form

```php
use App\Form\ProductType;

public function createAction(Request $request)
{
    // you can fetch the EntityManager via $this->getDoctrine()
    // or you can add an argument to your action: createAction(EntityManagerInterface $em)
    $em = $this->getDoctrine()->getManager();

    $product = new Product();
    $form = $this->createForm(ProductType::class, $product);

    $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        // tells Doctrine you want to (eventually) save the Product (no queries yet)
        $em->persist($product);

        // actually executes the queries (i.e. the INSERT query)
        $em->flush();
        return new Response('Saved new product with id '.$product->getId());
    }
    return $this->render('default/create.html.twig', array(
        'form' => $form->createView(),
    ));
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Fetching Objects from the Database

```php
public function showAction($productId)
{
    $product = $this->getDoctrine()
        ->getRepository(Product::class)
        ->find($productId);

    if (!$product) {
        throw $this->createNotFoundException(
            'No product found for id '.$productId
        );
    }

    // ... do something, like pass the $product object into a template
}
```
```php
$repository = $this->getDoctrine()->getRepository(Product::class);

// query for a single product by its primary key (usually "id")
$product = $repository->find($productId);

// dynamic method names to find a single product based on a column value
$product = $repository->findOneById($productId);
$product = $repository->findOneByName('Keyboard');

// dynamic method names to find a group of products based on a column value
$products = $repository->findByPrice(19.99);

// find *all* products
$products = $repository->findAll();

// query for a single product matching the given name and price
$product = $repository->findOneBy(
    array('name' => 'Keyboard', 'price' => 19.99)
);

// query for multiple products matching the given name, ordered by price
$products = $repository->findBy(
    array('name' => 'Keyboard'),
    array('price' => 'ASC')
);
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Updating an Object

```php
use App\Entity\Product;
// ...

public function updateAction($productId)
{
    $em = $this->getDoctrine()->getManager();
    $product = $em->getRepository(Product::class)->find($productId);

    if (!$product) {
        throw $this->createNotFoundException(
            'No product found for id '.$productId
        );
    }

    $product->setName('New product name!');
    $em->flush();

    return $this->redirectToRoute('homepage');
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Deleting an Object

```php
$em->remove($product);
$em->flush();
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Querying for Objects with DQL

```php
$repository = $this->getDoctrine()->getRepository(Product::class);

$product = $repository->find($productId);
$product = $repository->findOneByName('Keyboard');

$query = $em->createQuery(
    'SELECT p
    FROM App:Product p
    WHERE p.price > :price
    ORDER BY p.price ASC'
)->setParameter('price', 19.99);

$products = $query->getResult();

$product = $query->setMaxResults(1)->getOneOrNullResult();
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Querying for Objects Using Doctrine's Query Builder

```php
$repository = $this->getDoctrine()
    ->getRepository(Product::class);

// createQueryBuilder() automatically selects FROM App:Product
// and aliases it to "p"
$query = $repository->createQueryBuilder('p')
    ->where('p.price > :price')
    ->setParameter('price', '19.99')
    ->orderBy('p.price', 'ASC')
    ->getQuery();

$products = $query->getResult();
// to get just one result:
// $product = $query->setMaxResults(1)->getOneOrNullResult();
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Organizing Custom Queries into Repository Classes

```php
// src/Entity/Product.php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\ProductRepository")
 */
class Product
{
    //...
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Organizing Custom Queries into Repository Classes

```php
// src/Repository/ProductRepository.php
namespace App\Repository;

use Doctrine\ORM\EntityRepository;

class ProductRepository extends EntityRepository
{
    // DQL
    public function findAllOrderedByName()
    {
        return $this->getEntityManager()
            ->createQuery(
                'SELECT p FROM App:Product p ORDER BY p.name ASC'
            )
            ->getResult();
    }

    // Doctrine's Query Builder
    public function findAllOrderedByPrice($price)
    {
        $query = $this->createQueryBuilder('p')
            ->where('p.price > :price')
            ->setParameter('price', $price)
            ->orderBy('p.price', 'ASC')
            ->getQuery();

        return $query->getResult();
    }
}
```

--

<!-- .slide: data-title="Interagir avec une base de données relationnelle" -->
#### Organizing Custom Queries into Repository Classes

```php
use App\Entity\Product;
// ...

public function listAction()
{
    $products = $this->getDoctrine()
        ->getRepository(Product::class)
        ->findAllOrderedByName();

    $cheapProducts = $this->getDoctrine()
        ->getRepository(Product::class)
        ->findAllOrderedByPrice(19.99);
}
```

--

#### How to use Doctrine Extensions: Timestampable, Sluggable, Translatable, etc. : [KnpLabs/DoctrineBehaviors](https://github.com/KnpLabs/DoctrineBehaviors)

```php
use Doctrine\ORM\Mapping as ORM;
use Knp\DoctrineBehaviors\Model as ORMBehaviors;

/**
 * @ORM\Entity(repositoryClass="CategoryRepository")
 */
class Category implements ORMBehaviors\Tree\NodeInterface, \ArrayAccess
{
    use ORMBehaviors\Blameable\Blameable,
        ORMBehaviors\Geocodable\Geocodable,
        ORMBehaviors\Loggable\Loggable,
        ORMBehaviors\Sluggable\Sluggable,
        ORMBehaviors\SoftDeletable\SoftDeletable,
        ORMBehaviors\Sortable\Sortable,
        ORMBehaviors\Timestampable\Timestampable,
        ORMBehaviors\Translatable\Translatable,
        ORMBehaviors\Tree\Node
    ;

    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="NONE")
     */
    protected $id;
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
use Doctrine\ORM\EntityRepository;
use Knp\DoctrineBehaviors\ORM as ORMBehaviors;

class CategoryRepository extends EntityRepository
{
    use ORMBehaviors\Tree\Tree;
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

###### _TP : Interagir avec une base de données relationnelle_

---

### 12. Authentification et contrôle de droits d'accès

- Développer un fournisseur d’utilisateur personnalisé
- Déclencher du code lorsque l’utilisateur se connecte en tant que quelqu’un d’autre
- Affiner la politique de contrôle d’accès aux ressources grâce aux voteurs

--

#### Développer un fournisseur d’utilisateur personnalisé
<!-- .slide: data-title="Authentification et contrôle de droits d'accès" -->

#### Create your User Entity

```php
// src/Entity/User.php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * @ORM\Table(name="app_users")
 * @ORM\Entity(repositoryClass="App\Repository\UserRepository")
 */
class User implements UserInterface, \Serializable
{
    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=25, unique=true)
     */
    private $username;

    /**
     * @ORM\Column(type="string", length=64)
     */
    private $password;

    /**
     * @ORM\Column(type="string", length=60, unique=true)
     */
    private $email;

    /**
     * @ORM\Column(name="is_active", type="boolean")
     */
    private $isActive;

    public function __construct()
    {
        $this->isActive = true;
        // may not be needed, see section on salt below
        // $this->salt = md5(uniqid('', true));
    }

    public function getUsername()
    {
        return $this->username;
    }

    public function getSalt()
    {
        // you *may* need a real salt depending on your encoder
        // see section on salt below
        return null;
    }

    public function getPassword()
    {
        return $this->password;
    }

    public function getRoles()
    {
        return array('ROLE_USER');
    }

    public function eraseCredentials()
    {
    }

    /** @see \Serializable::serialize() */
    public function serialize()
    {
        return serialize(array(
            $this->id,
            $this->username,
            $this->password,
            // see section on salt below
            // $this->salt,
        ));
    }

    /** @see \Serializable::unserialize() */
    public function unserialize($serialized)
    {
        list (
            $this->id,
            $this->username,
            $this->password,
            // see section on salt below
            // $this->salt
        ) = unserialize($serialized);
    }
}
```


--

<!-- .slide: data-title="Développer un fournisseur d’utilisateur personnalisé" -->
#### Configure Security to load from your Entity

```yml
# app/config/security.yml
security:
    encoders:
        App\Entity\User:
            algorithm: bcrypt

    # ...

    providers:
        our_db_provider:
            entity:
                class: App:User
                property: username
                # if you're using multiple entity managers
                # manager_name: customer

    firewalls:
        main:
            pattern:    ^/
            http_basic: ~
            provider: our_db_provider

    # ...
```

--

<!-- .slide: data-title="Développer un fournisseur d’utilisateur personnalisé" -->
#### Forbid Inactive Users

```php
// src/Entity/User.php

use Symfony\Component\Security\Core\User\AdvancedUserInterface;
// ...

class User implements AdvancedUserInterface, \Serializable
{
    // ...

    public function isAccountNonExpired()
    {
        return true;
    }

    public function isAccountNonLocked()
    {
        return true;
    }

    public function isCredentialsNonExpired()
    {
        return true;
    }

    public function isEnabled()
    {
        return $this->isActive;
    }

    // serialize and unserialize must be updated - see below
    public function serialize()
    {
        return serialize(array(
            // ...
            $this->isActive
        ));
    }
    public function unserialize($serialized)
    {
        list (
            // ...
            $this->isActive
        ) = unserialize($serialized);
    }
}
```

--

<!-- .slide: data-title="Développer un fournisseur d’utilisateur personnalisé" -->
#### Using a Custom Query to Load the User

```php
// src/Repository/UserRepository.php
namespace App\Repository;

use Symfony\Bridge\Doctrine\Security\User\UserLoaderInterface;
use Doctrine\ORM\EntityRepository;

class UserRepository extends EntityRepository implements UserLoaderInterface
{
    public function loadUserByUsername($username)
    {
        return $this->createQueryBuilder('u')
            ->where('u.username = :username OR u.email = :email')
            ->setParameter('username', $username)
            ->setParameter('email', $username)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
```

```yml
# app/config/security.yml
security:
    # ...
    providers:
        our_db_provider:
            entity:
                class: App:User
```

--

#### Déclencher du code lorsque l’utilisateur se connecte en tant que quelqu’un d’autre
<!-- .slide: data-title="Authentification et contrôle de droits d'accès" -->

#### [`security.switch_user`](http://symfony.com/doc/current/security/impersonating_user.html#events)

```php
// src/EventListener/SwitchUserListener.php
namespace App\EventListener;

use Symfony\Component\Security\Http\Event\SwitchUserEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Security\Http\SecurityEvents;

class SwitchUserSubscriber implements EventSubscriberInterface
{
    public function onSwitchUser(SwitchUserEvent $event)
    {
        $event->getRequest()->getSession()->set(
            '_locale',
            // assuming your User has some getLocale() method
            $event->getTargetUser()->getLocale()
        );
    }

    public static function getSubscribedEvents()
    {
        return array(
            // constant for security.switch_user
            SecurityEvents::SWITCH_USER => 'onSwitchUser',
        );
    }
}
```

--

#### Affiner la politique de contrôle d’accès aux ressources grâce aux voteurs
<!-- .slide: data-title="Authentification et contrôle de droits d'accès" -->
##### The Voter Interface

```php
abstract class Voter implements VoterInterface
{
    abstract protected function supports($attribute, $subject);
    abstract protected function voteOnAttribute($attribute, $subject, TokenInterface $token);
}
```

--
<!-- .slide: data-title="Affiner la politique de contrôle d’accès aux ressources grâce aux voteurs" -->
#### Checking for Access in a Controller

```php
// src/Controller/PostController.php
// ...

class PostController extends Controller
{
    /**
     * @Route("/posts/{id}", name="post_show")
     */
    public function showAction($id)
    {
        // get a Post object - e.g. query for it
        $post = ...;

        // check for "view" access: calls all voters
        $this->denyAccessUnlessGranted('view', $post);

        // ...
    }

    /**
     * @Route("/posts/{id}/edit", name="post_edit")
     */
    public function editAction($id)
    {
        // get a Post object - e.g. query for it
        $post = ...;

        // check for "edit" access: calls all voters
        $this->denyAccessUnlessGranted('edit', $post);

        // ...
    }
}
```

--
<!-- .slide: data-title="Affiner la politique de contrôle d’accès aux ressources grâce aux voteurs" -->
#### Creating the custom Voter

```php
// src/Security/PostVoter.php
namespace App\Security;

use App\Entity\Post;
use App\Entity\User;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;

class PostVoter extends Voter
{
    // these strings are just invented: you can use anything
    const VIEW = 'view';
    const EDIT = 'edit';

    protected function supports($attribute, $subject)
    {
        // if the attribute isn't one we support, return false
        if (!in_array($attribute, array(self::VIEW, self::EDIT))) {
            return false;
        }

        // only vote on Post objects inside this voter
        if (!$subject instanceof Post) {
            return false;
        }

        return true;
    }

    protected function voteOnAttribute($attribute, $subject, TokenInterface $token)
    {
        $user = $token->getUser();

        if (!$user instanceof User) {
            // the user must be logged in; if not, deny access
            return false;
        }

        // you know $subject is a Post object, thanks to supports
        /** @var Post $post */
        $post = $subject;

        switch ($attribute) {
            case self::VIEW:
                return $this->canView($post, $user);
            case self::EDIT:
                return $this->canEdit($post, $user);
        }

        throw new \LogicException('This code should not be reached!');
    }

    private function canView(Post $post, User $user)
    {
        // if they can edit, they can view
        if ($this->canEdit($post, $user)) {
            return true;
        }

        // the Post object could have, for example, a method isPrivate()
        // that checks a boolean $private property
        return !$post->isPrivate();
    }

    private function canEdit(Post $post, User $user)
    {
        // this assumes that the data object has a getOwner() method
        // to get the entity of the user who owns this data object
        return $user === $post->getOwner();
    }
}
```

--
<!-- .slide: data-title="Affiner la politique de contrôle d’accès aux ressources grâce aux voteurs" -->
#### Checking for Roles inside a Voter

```php
// src/Security/PostVoter.php

// ...
use Symfony\Component\Security\Core\Authorization\AccessDecisionManagerInterface;

class PostVoter extends Voter
{
    // ...

    private $decisionManager;

    public function __construct(AccessDecisionManagerInterface $decisionManager)
    {
        $this->decisionManager = $decisionManager;
    }

    protected function voteOnAttribute($attribute, $subject, TokenInterface $token)
    {
        // ...

        // ROLE_SUPER_ADMIN can do anything! The power!
        if ($this->decisionManager->decide($token, array('ROLE_SUPER_ADMIN'))) {
            return true;
        }

        // ... all the normal voter logic
    }
}
```

--
<!-- .slide: data-title="Affiner la politique de contrôle d’accès aux ressources grâce aux voteurs" -->
#### Changing the Access Decision Strategy

- __`affirmative`__ (default) : This grants access as soon as there is one voter granting access;
- __`consensus`__ : This grants access if there are more voters granting access than denying;
- __`unanimous`__ : This only grants access once all voters grant access.

```yml
# app/config/security.yml
security:
    access_decision_manager:
        strategy: unanimous
```

--

###### _TP : Authentification et contrôle de droits d'accès_

---

### 13. Découpler le code avec l'approche événementielle

- Découvrir les événements du noyau et des autres composants
- Étendre le noyau en connectant de nouveaux écouteurs d’événement
- Propager des événements personnalisés dans le code métier
- Connecter des écouteurs aux événements personnalisés du code métier

--

#### Découvrir les événements du noyau et des autres composants
<!-- .slide: data-title="Découpler le code avec l'approche événementielle" -->

cf. [Built-in Symfony Events](https://symfony.com/doc/current/reference/events.html)

```php
php bin/console debug:event-dispatcher  

Registered Listeners Grouped by Event
=====================================

"console.command" event
-----------------------

 ------- ------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                        Priority  
 ------- ------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Component\HttpKernel\EventListener\DebugHandlersListener::configure()   2048      
  #2      Symfony\Component\HttpKernel\EventListener\DumpListener::configure()            1024      
  #3      Symfony\Bridge\Monolog\Handler\ConsoleHandler::onCommand()                      255       
 ------- ------------------------------------------------------------------------------- ---------- 

"console.exception" event
-------------------------

 ------- ----------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                            Priority  
 ------- ----------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Bundle\SwiftmailerBundle\EventListener\EmailSenderListener::onException()   0         
 ------- ----------------------------------------------------------------------------------- ---------- 

"console.terminate" event
-------------------------

 ------- ----------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                            Priority  
 ------- ----------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Bundle\SwiftmailerBundle\EventListener\EmailSenderListener::onTerminate()   0         
  #2      Symfony\Bridge\Monolog\Handler\ConsoleHandler::onTerminate()                        -255      
 ------- ----------------------------------------------------------------------------------- ---------- 

"kernel.controller" event
-------------------------

 ------- ----------------------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                                        Priority  
 ------- ----------------------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Bundle\FrameworkBundle\DataCollector\RouterDataCollector::onKernelController()          0         
  #2      Symfony\Component\HttpKernel\DataCollector\RequestDataCollector::onKernelController()           0         
  #3      Sensio\Bundle\FrameworkExtraBundle\EventListener\ControllerListener::onKernelController()       0         
  #4      Sensio\Bundle\FrameworkExtraBundle\EventListener\ParamConverterListener::onKernelController()   0         
  #5      Sensio\Bundle\FrameworkExtraBundle\EventListener\HttpCacheListener::onKernelController()        0         
  #6      Sensio\Bundle\FrameworkExtraBundle\EventListener\SecurityListener::onKernelController()         0         
  #7      Sensio\Bundle\FrameworkExtraBundle\EventListener\TemplateListener::onKernelController()         -128      
 ------- ----------------------------------------------------------------------------------------------- ---------- 

"kernel.exception" event
------------------------

 ------- ----------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                            Priority  
 ------- ----------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Component\HttpKernel\EventListener\ProfilerListener::onKernelException()    0         
  #2      Symfony\Bundle\SwiftmailerBundle\EventListener\EmailSenderListener::onException()   0         
  #3      Symfony\Component\HttpKernel\EventListener\ExceptionListener::onKernelException()   -128      
 ------- ----------------------------------------------------------------------------------- ---------- 

"kernel.finish_request" event
-----------------------------

 ------- ---------------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                                 Priority  
 ------- ---------------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Component\HttpKernel\EventListener\LocaleListener::onKernelFinishRequest()       0         
  #2      Symfony\Component\HttpKernel\EventListener\TranslatorListener::onKernelFinishRequest()   0         
  #3      Symfony\Component\HttpKernel\EventListener\RouterListener::onKernelFinishRequest()       0         
  #4      Symfony\Component\Security\Http\Firewall::onKernelFinishRequest()                        0         
 ------- ---------------------------------------------------------------------------------------- ---------- 

"kernel.request" event
----------------------

 ------- --------------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                                Priority  
 ------- --------------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Component\HttpKernel\EventListener\DebugHandlersListener::configure()           2048      
  #2      Symfony\Component\HttpKernel\EventListener\ProfilerListener::onKernelRequest()          1024      
  #3      Symfony\Component\HttpKernel\EventListener\ValidateRequestListener::onKernelRequest()   256       
  #4      Symfony\Bundle\FrameworkBundle\EventListener\SessionListener::onKernelRequest()         128       
  #5      Symfony\Component\HttpKernel\EventListener\FragmentListener::onKernelRequest()          48        
  #6      Symfony\Component\HttpKernel\EventListener\RouterListener::onKernelRequest()            32        
  #7      Symfony\Component\HttpKernel\EventListener\LocaleListener::onKernelRequest()            16        
  #8      Symfony\Component\HttpKernel\EventListener\TranslatorListener::onKernelRequest()        10        
  #9      Symfony\Component\Security\Http\Firewall::onKernelRequest()                             8         
 ------- --------------------------------------------------------------------------------------- ---------- 

"kernel.response" event
-----------------------

 ------- -------------------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                                     Priority  
 ------- -------------------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Component\HttpKernel\EventListener\ResponseListener::onKernelResponse()              0         
  #2      Symfony\Component\Security\Http\RememberMe\ResponseListener::onKernelResponse()              0         
  #3      Sensio\Bundle\FrameworkExtraBundle\EventListener\HttpCacheListener::onKernelResponse()       0         
  #4      Symfony\Component\HttpKernel\EventListener\ProfilerListener::onKernelResponse()              -100      
  #5      Symfony\Bundle\WebProfilerBundle\EventListener\WebDebugToolbarListener::onKernelResponse()   -128      
  #6      Symfony\Component\HttpKernel\EventListener\SaveSessionListener::onKernelResponse()           -1000     
  #7      Symfony\Component\HttpKernel\EventListener\StreamedResponseListener::onKernelResponse()      -1024     
 ------- -------------------------------------------------------------------------------------------- ---------- 

"kernel.terminate" event
------------------------

 ------- ----------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                            Priority  
 ------- ----------------------------------------------------------------------------------- ---------- 
  #1      Symfony\Bundle\SwiftmailerBundle\EventListener\EmailSenderListener::onTerminate()   0         
  #2      Symfony\Component\HttpKernel\EventListener\ProfilerListener::onKernelTerminate()    -1024     
 ------- ----------------------------------------------------------------------------------- ---------- 

"kernel.view" event
-------------------

 ------- ----------------------------------------------------------------------------------- ---------- 
  Order   Callable                                                                            Priority  
 ------- ----------------------------------------------------------------------------------- ---------- 
  #1      Sensio\Bundle\FrameworkExtraBundle\EventListener\TemplateListener::onKernelView()   0         
 ------- ----------------------------------------------------------------------------------- ---------- 
```


--

#### Étendre le noyau en connectant de nouveaux écouteurs d’événement
<!-- .slide: data-title="Découpler le code avec l'approche événementielle" -->

```php
namespace Acme\Store\Event;

use Symfony\Component\EventDispatcher\Event;
use Acme\Store\Order;

/**
 * The order.placed event is dispatched each time an order is created
 * in the system.
 */
class OrderPlacedEvent extends Event
{
    const NAME = 'order.placed';

    protected $order;

    public function __construct(Order $order)
    {
        $this->order = $order;
    }

    public function getOrder()
    {
        return $this->order;
    }
}
```

--

#### Propager des événements personnalisés dans le code métier
<!-- .slide: data-title="Découpler le code avec l'approche événementielle" -->

```php
use Acme\Store\Order;
use Acme\Store\Event\OrderPlacedEvent;

// the order is somehow created or retrieved
$order = new Order();
// ...

// create the OrderPlacedEvent and dispatch it
$event = new OrderPlacedEvent($order);
$dispatcher->dispatch(OrderPlacedEvent::NAME, $event);
```

--

#### Connecter des écouteurs aux événements personnalisés du code métier
<!-- .slide: data-title="Découpler le code avec l'approche événementielle" -->

```php
namespace Acme\Store\Event;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\FilterResponseEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use Acme\Store\Event\OrderPlacedEvent;

class StoreSubscriber implements EventSubscriberInterface
{
    public static function getSubscribedEvents()
    {
        return array(
            KernelEvents::RESPONSE => array(
                array('onKernelResponsePre', 10),
                array('onKernelResponsePost', -10),
            ),
            OrderPlacedEvent::NAME => 'onStoreOrder',
        );
    }

    public function onKernelResponsePre(FilterResponseEvent $event)
    {
        // ...
    }

    public function onKernelResponsePost(FilterResponseEvent $event)
    {
        // ...
    }

    public function onStoreOrder(OrderPlacedEvent $event)
    {
        // ...
    }
}
```

```yml
# app/config/services.yml
services:
    Acme\Store\Event\StoreSubscriber:
        tags:
            - { name: kernel.event_subscriber }
```

--

###### _TP : Découpler le code avec l'approche événementielle_

---

### 14. Créer des APIs RESTful avec API Platform

<ul style="font-size: 0.7em">
<li>Vue d'ensemble du format JSON-LD et des APIs hypermedia</li>
<li>Générer un modèle de données à partir d'une description schema.org</li>
<li>Exposer une API CRUD basique</li>
<li>Explorer les fonctionnalités natives d'API Platform</li>
<li>Implémenter des règles de validation et de filtrage</li>
<li>Personnaliser la sérialisation des ressources exposées</li>
<li>Comprendre et utiliser le fonctionnement des événements API Platform</li>
<li>Créer des opérations dédiées</li>
<li>Implémenter des mécanismes de stockage personnalisé avec les fournisseurs de stockage</li>
</ul>

cf. [API Platform and Symfony: for API-driven Projects](https://www.slideshare.net/coopTilleuls/api-platform-and-symfony-a-framework-for-apidriven-projects)

cf. [Créer un API web moderne](https://www.youtube.com/watch?v=N_jQcjqEJN8)

--

<blockquote class="twitter-tweet" style="font-size: 0.7em"><p lang="en" dir="ltr">When an API query returns an HTML-formatted error. <img src="https://pbs.twimg.com/media/DPfI1o_WsAAWpd4.jpg" height="400" class="plain" /></p>&mdash; Waldo Jaquith (@waldojaquith) <a href="https://twitter.com/waldojaquith/status/934436283325321216?ref_src=twsrc%5Etfw">November 25, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

--

#### Vue d'ensemble du format JSON-LD et des APIs hypermedia
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

- JSON-LD
- HAL
- Collection+JSON
- SIREN

cf. [On choosing a hypermedia type for your API](https://sookocheff.com/post/api/on-choosing-a-hypermedia-format/)

cf. [JSON Based Hypermedia Structures - Notes & Comparisons](https://gist.github.com/tmaiaroto/8533343)

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### JSON-LD

__J__avaScript __O__bject __N__otation for __L__inked __D__ata

- Format normalisé par le W3C (2004)
- Supporté par Google, BBC, Microsoft, US & UK govs
- Web sémantique : RDF, SPARQL, triple store...

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### JSON-LD

```json
{
  "@context": "http://schema.org",
  "@type": "ItemList",
  "url": "http://multivarki.ru?filters%5Bprice%5D%5BLTE%5D=39600",
  "numberOfItems": "315",
  "itemListElement": [{
      "@type": "Product",
      "image": "http://img01.multivarki.ru.ru/c9/f1/a5fe6642-18d0-47ad-b038-6fca20f1c923.jpeg",
      "url": "http://multivarki.ru/brand_502/",
      "name": "Brand 502"
    },{
      "@type": "Product",
      "name": "..."
    }
  ],
    "offers": {
      "@type": "Offer",
      "price": "4399 p."
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```json
{
  "@context": "http://schema.org",
  "@type": "Product",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "3.5",
    "reviewCount": "11"
  },
  "description": "0.7 cubic feet countertop microwave. Has six preset cooking categories and convenience features like Add-A-Minute and Child Lock.",
  "name": "Kenmore White 17\" Microwave",
  "image": "kenmore-microwave-17in.jpg",
  "offers": {
    "@type": "Offer",
    "availability": "http://schema.org/InStock",
    "price": "55.00",
    "priceCurrency": "USD"
  },
  "review": [
    {
      "@type": "Review",
      "author": "Ellie",
      "datePublished": "2011-04-01",
      "description": "The lamp burned out and now I have to replace it.",
      "name": "Not a happy camper",
      "reviewRating": {
        "@type": "Rating",
        "bestRating": "5",
        "ratingValue": "1",
        "worstRating": "1"
      }
    },
    {
      "@type": "Review",
      "author": "Lucas",
      "datePublished": "2011-03-25",
      "description": "Great microwave for the price. It is small and fits in my apartment.",
      "name": "Value purchase",
      "reviewRating": {
        "@type": "Rating",
        "bestRating": "5",
        "ratingValue": "4",
        "worstRating": "1"
      }
    }
  ]
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### HAL

__H__ypertext __A__pplication __L__anguage

- [Internet Draft](https://www.ietf.org/id-info/) ("work in progress")
- Référencer des liens dans les API (JSON, XML)

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### HAL

```json
{
  "_links": {
    "self": { "href": "/orders" },
    "next": { "href": "/orders?page=2" },
    "find": { "href": "/orders{?id}", "templated": true }
  },
  "_embedded": {
    "orders": [{
        "_links": {
          "self": { "href": "/orders/123" },
          "basket": { "href": "/baskets/98712" },
          "customer": { "href": "/customers/7809" }
        },
        "total": 30.00,
        "currency": "USD",
        "status": "shipped",
      },{
        "_links": {
          "self": { "href": "/orders/124" },
          "basket": { "href": "/baskets/97213" },
          "customer": { "href": "/customers/12369" }
        },
        "total": 20.00,
        "currency": "USD",
        "status": "processing"
    }]
  },
  "currentlyProcessing": 14,
  "shippedToday": 20
}
```

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### Collection+JSON

read/write hypermedia-type designed to support management and querying of simple collections.

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### Collection+JSON

```json
{ "collection" :
  {
    "version" : "1.0",
    "href" : "http://example.org/friends/",
    
    "links" : [
      {"rel" : "feed", "href" : "http://example.org/friends/rss"},
      {"rel" : "queries", "href" : "http://example.org/friends/?queries"},
      {"rel" : "template", "href" : "http://example.org/friends/?template"}
    ],
    
    "items" : [
      {
        "href" : "http://example.org/friends/jdoe",
        "data" : [
          {"name" : "full-name", "value" : "J. Doe", "prompt" : "Full Name"},
          {"name" : "email", "value" : "jdoe@example.org", "prompt" : "Email"}
        ],
        "links" : [
          {"rel" : "blog", "href" : "http://examples.org/blogs/jdoe", "prompt" : "Blog"},
          {"rel" : "avatar", "href" : "http://examples.org/images/jdoe", "prompt" : "Avatar", "render" : "image"}
        ]
      }
    ]
  } 
}
```

--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### SIREN

hypermedia specification for representing entities, offering structures to communicate information about entities, actions for executing state transitions, and links for client navigation.



--

<!-- .slide: data-title="Vue d'ensemble du format JSON-LD et des APIs hypermedia" -->
##### SIREN

```json
{
  "class": [ "order" ],
  "properties": { 
      "orderNumber": 42, 
      "itemCount": 3,
      "status": "pending"
  },
  "entities": [
    { 
      "class": [ "items", "collection" ], 
      "rel": [ "http://x.io/rels/order-items" ], 
      "href": "http://api.x.io/orders/42/items"
    },
    {
      "class": [ "info", "customer" ],
      "rel": [ "http://x.io/rels/customer" ], 
      "properties": { 
        "customerId": "pj123",
        "name": "Peter Joseph"
      },
      "links": [
        { "rel": [ "self" ], "href": "http://api.x.io/customers/pj123" }
      ]
    }
  ],
  "actions": [
    {
      "name": "add-item",
      "title": "Add Item",
      "method": "POST",
      "href": "http://api.x.io/orders/42/items",
      "type": "application/x-www-form-urlencoded",
      "fields": [
        { "name": "orderNumber", "type": "hidden", "value": "42" },
        { "name": "productCode", "type": "text" },
        { "name": "quantity", "type": "number" }
      ]
    }
  ],
  "links": [
    { "rel": [ "self" ], "href": "http://api.x.io/orders/42" },
    { "rel": [ "previous" ], "href": "http://api.x.io/orders/41" },
    { "rel": [ "next" ], "href": "http://api.x.io/orders/43" }
  ]
}
```

--

#### Générer un modèle de données à partir d'une description schema.org
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```yml
# app/config/schema.yml

# The list of types and properties we want to use
types:
    # Parent class of Person
    Thing:
        properties:
            name: ~
    Person:
        properties:
            familyName: ~
            givenName: ~
            additionalName: ~
            gender: ~
            address: ~
            birthDate: ~
            telephone: ~
            email: ~
            url: ~
            jobTitle: ~
    PostalAddress:
        # Disable the generation of the class hierarchy for this type
        parent: false
        properties:
            # Force the type of the addressCountry property to text
            addressCountry: { range: "Text" }
            addressLocality: ~
            addressRegion: ~
            postOfficeBoxNumber: ~
            postalCode: ~
            streetAddress: ~
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```bash
vendor/bin/schema generate-types src/ app/config/schema.yml
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
<?php

declare(strict_types=1);

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiProperty;
use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * A person (alive, dead, undead, or fictional).
 *
 * @see http://schema.org/Person Documentation on Schema.org
 *
 * @ORM\Entity
 * @ApiResource(iri="http://schema.org/Person")
 */
class Person
{
    /**
     * @var int|null
     *
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var string|null the name of the item
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/name")
     */
    private $name;

    /**
     * @var string|null Family name. In the U.S., the last name of an Person. This can be used along with givenName instead of the name property.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/familyName")
     */
    private $familyName;

    /**
     * @var string|null Given name. In the U.S., the first name of a Person. This can be used along with familyName instead of the name property.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/givenName")
     */
    private $givenName;

    /**
     * @var string|null an additional name for a Person, can be used for a middle name
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/additionalName")
     */
    private $additionalName;

    /**
     * @var string|null Gender of the person. While http://schema.org/Male and http://schema.org/Female may be used, text strings are also acceptable for people who do not identify as a binary gender.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/gender")
     */
    private $gender;

    /**
     * @var PostalAddress|null physical address of the item
     *
     * @ORM\ManyToOne(targetEntity="App\Entity\PostalAddress")
     * @ApiProperty(iri="http://schema.org/address")
     */
    private $address;

    /**
     * @var \DateTimeInterface|null date of birth
     *
     * @ORM\Column(type="date", nullable=true)
     * @ApiProperty(iri="http://schema.org/birthDate")
     * @Assert\Date
     */
    private $birthDate;

    /**
     * @var string|null the telephone number
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/telephone")
     */
    private $telephone;

    /**
     * @var string|null email address
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/email")
     * @Assert\Email
     */
    private $email;

    /**
     * @var string|null URL of the item
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/url")
     * @Assert\Url
     */
    private $url;

    /**
     * @var string|null the job title of the person (for example, Financial Manager)
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/jobTitle")
     */
    private $jobTitle;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setName(?string $name): void
    {
        $this->name = $name;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setFamilyName(?string $familyName): void
    {
        $this->familyName = $familyName;
    }

    public function getFamilyName(): ?string
    {
        return $this->familyName;
    }

    public function setGivenName(?string $givenName): void
    {
        $this->givenName = $givenName;
    }

    public function getGivenName(): ?string
    {
        return $this->givenName;
    }

    public function setAdditionalName(?string $additionalName): void
    {
        $this->additionalName = $additionalName;
    }

    public function getAdditionalName(): ?string
    {
        return $this->additionalName;
    }

    public function setGender(?string $gender): void
    {
        $this->gender = $gender;
    }

    public function getGender(): ?string
    {
        return $this->gender;
    }

    public function setAddress(?PostalAddress $address): void
    {
        $this->address = $address;
    }

    public function getAddress(): ?PostalAddress
    {
        return $this->address;
    }

    public function setBirthDate(?\DateTimeInterface $birthDate): void
    {
        $this->birthDate = $birthDate;
    }

    public function getBirthDate(): ?\DateTimeInterface
    {
        return $this->birthDate;
    }

    public function setTelephone(?string $telephone): void
    {
        $this->telephone = $telephone;
    }

    public function getTelephone(): ?string
    {
        return $this->telephone;
    }

    public function setEmail(?string $email): void
    {
        $this->email = $email;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setUrl(?string $url): void
    {
        $this->url = $url;
    }

    public function getUrl(): ?string
    {
        return $this->url;
    }

    public function setJobTitle(?string $jobTitle): void
    {
        $this->jobTitle = $jobTitle;
    }

    public function getJobTitle(): ?string
    {
        return $this->jobTitle;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
<?php

declare(strict_types=1);

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiProperty;
use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;

/**
 * The mailing address.
 *
 * @see http://schema.org/PostalAddress Documentation on Schema.org
 *
 * @ORM\Entity
 * @ApiResource(iri="http://schema.org/PostalAddress")
 */
class PostalAddress
{
    /**
     * @var int|null
     *
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @var string|null The country. For example, USA. You can also provide the two-letter \[ISO 3166-1 alpha-2 country code\](http://en.wikipedia.org/wiki/ISO\_3166-1).
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/addressCountry")
     */
    private $addressCountry;

    /**
     * @var string|null The locality. For example, Mountain View.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/addressLocality")
     */
    private $addressLocality;

    /**
     * @var string|null The region. For example, CA.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/addressRegion")
     */
    private $addressRegion;

    /**
     * @var string|null the post office box number for PO box addresses
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/postOfficeBoxNumber")
     */
    private $postOfficeBoxNumber;

    /**
     * @var string|null The postal code. For example, 94043.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/postalCode")
     */
    private $postalCode;

    /**
     * @var string|null The street address. For example, 1600 Amphitheatre Pkwy.
     *
     * @ORM\Column(type="text", nullable=true)
     * @ApiProperty(iri="http://schema.org/streetAddress")
     */
    private $streetAddress;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setAddressCountry(?string $addressCountry): void
    {
        $this->addressCountry = $addressCountry;
    }

    public function getAddressCountry(): ?string
    {
        return $this->addressCountry;
    }

    public function setAddressLocality(?string $addressLocality): void
    {
        $this->addressLocality = $addressLocality;
    }

    public function getAddressLocality(): ?string
    {
        return $this->addressLocality;
    }

    public function setAddressRegion(?string $addressRegion): void
    {
        $this->addressRegion = $addressRegion;
    }

    public function getAddressRegion(): ?string
    {
        return $this->addressRegion;
    }

    public function setPostOfficeBoxNumber(?string $postOfficeBoxNumber): void
    {
        $this->postOfficeBoxNumber = $postOfficeBoxNumber;
    }

    public function getPostOfficeBoxNumber(): ?string
    {
        return $this->postOfficeBoxNumber;
    }

    public function setPostalCode(?string $postalCode): void
    {
        $this->postalCode = $postalCode;
    }

    public function getPostalCode(): ?string
    {
        return $this->postalCode;
    }

    public function setStreetAddress(?string $streetAddress): void
    {
        $this->streetAddress = $streetAddress;
    }

    public function getStreetAddress(): ?string
    {
        return $this->streetAddress;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Exposer une API CRUD basique
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```yml
# app/config/routing.yml
api:
    resource: '.'
    type: 'api_platform'
    prefix: '/api' # Optional
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
<?php
// src/Entity/Product.php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ApiResource
 * @ORM\Entity
 */
class Product // The class name will be used to name exposed resources
{
    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    public $id;

    /**
     * @param string $name A name property - this description will be available in the API documentation too.
     *
     * @ORM\Column
     * @Assert\NotBlank
     */
    public $name;

    // Notice the "cascade" option below, this is mandatory if you want Doctrine to automatically persist the related entity
    /**
     * @ORM\OneToMany(targetEntity="Offer", mappedBy="product", cascade={"persist"})
     */
    public $offers;

    public function __construct()
    {
        $this->offers = new ArrayCollection(); // Initialize $offers as an Doctrine collection
    }

    // Adding both an adder and a remover as well as updating the reverse relation are mandatory
    // if you want Doctrine to automatically update and persist (thanks to the "cascade" option) the related entity
    public function addOffer(Offer $offer): void
    {
        $offer->product = $this;
        $this->offers->add($offer);
    }

    public function removeGreeting(Offer $offer): void
    {
        $offer->product = null;
        $this->offers->removeElement($offer);
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
<?php
// src/Entity/Offer.php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * An offer from my shop - this description will be automatically extracted form the PHPDoc to document the API.
 *
 * @ApiResource(iri="http://schema.org/Offer")
 * @ORM\Entity
 */
class Offer
{
    /**
     * @ORM\Column(type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    public $id;

    /**
     * @ORM\Column(type="text")
     */
    public $description;

    /**
     * @ORM\Column(type="float")
     * @Assert\NotBlank
     * @Assert\Range(min=0, minMessage="The price must be superior to 0.")
     * @Assert\Type(type="float")
     */
    public $price;

    /**
     * @ORM\ManyToOne(targetEntity="Product", inversedBy="offers")
     */
    public $product;
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->


| METHOD | URL | DESCRIPTION |
| ------ | --- | ----------- |
| GET | /products | Retrieve the (paged) collection |
| POST |    /products | Create a new product |
| GET | /products/{id} | Retrieve a product |
| PUT | /products/{id} | Update a product |
| DELETE |  /products/{id} | Delete a product |

<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Explorer les fonctionnalités natives d'API Platform
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

- API Platform Core Library
- Schema generator
- API Platform Admin
- API Platform Client Generator

--

<!-- .slide: data-background-iframe="https://demo.api-platform.com/" data-title="Explorer les fonctionnalités natives d'API Platform" -->

--

#### Implémenter des règles de validation et de filtrage
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```php
<?php
// src/Entity/Book.php

use ApiPlatform\Core\Annotation\ApiResource;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ApiResource(attributes={"validation_groups"={"a", "b"}})
 */
class Book
{
    /**
     * @Assert\NotBlank(groups={"a"})
     */
    private $name;

    /**
     * @Assert\NotNull(groups={"b"})
     */
    private $author;

    // ...
}
```

--

#### Filtre de recherche
<!-- .slide: data-title="Implémenter des règles de validation et de filtrage" -->

- `exact` : =
- `partial` : LIKE %text%
- `start` : LIKE text%
- `end` : LIKE %text
- `word_start` : LIKE text% OR LIKE % text%

```yml
# app/config/api_filters.yml
services:
    offer.search_filter:
        parent: 'api_platform.doctrine.orm.search_filter'
        arguments: [ { id: 'exact', price: 'exact', name: 'partial' } ]
        tags: [ 'api_platform.filter' ]
```

```php
// src/Entity/Offer.php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;

/**
 * @ApiResource(attributes={"filters"={"offer.search_filter"}})
 */
class Offer
{
    // ...
}
```

--

#### Autres filtres disponibles
<!-- .slide: data-title="Implémenter des règles de validation et de filtrage" -->

- Date
- Booléen
- Numérique
- Plage
- Ordre
- Serializer
- Personnalisés

cf. [Filters](https://api-platform.com/docs/core/filters)

--

#### Personnaliser la sérialisation des ressources
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->
##### [The Serialization Process](https://api-platform.com/docs/core/serialization)

```yml
# app/config/services.yml
services:
    'App\Serializer\ApiNormalizer':
        decorates: 'api_platform.jsonld.normalizer.item'
        arguments: [ '@App\Serializer\ApiNormalizer.inner' ]
```

--

#### Personnaliser la sérialisation des ressources
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->


```php
<?php
// src/Serializer/ApiNormalizer

namespace App\Serializer;

use Symfony\Component\Serializer\Normalizer\DenormalizerInterface;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

final class ApiNormalizer implements NormalizerInterface, DenormalizerInterface
{
    private $decorated;

    public function __construct(NormalizerInterface $decorated)
    {
        if (!$decorated instanceof DenormalizerInterface) {
            throw new \InvalidArgumentException(sprintf('The decorated normalizer must implement the %s.', DenormalizerInterface::class));
        }

        $this->decorated = $decorated;
    }

    public function supportsNormalization($data, $format = null)
    {
        return $this->decorated->supportsNormalization($data, $format);
    }

    public function normalize($object, $format = null, array $context = [])
    {
        $data = $this->decorated->normalize($object, $format, $context);
        if (is_array($data)) {
            $data['date'] = date(\DateTime::RFC3339);
        }

        return $data;
    }

    public function supportsDenormalization($data, $type, $format = null)
    {
        return $this->decorated->supportsDenormalization($data, $type, $format);
    }

    public function denormalize($data, $class, $format = null, array $context = [])
    {
        return $this->decorated->denormalize($data, $class, $format, $context);
    }
}
```

--

#### Personnaliser la sérialisation des ressources
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```json
{
  "@context": "/contexts/Book",
  "@id": "/books/62",
  "@type": "Book",
  "name": "My awesome book",
  "author": "/people/59"
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```json
{
  "@context": {
    "@vocab": "http://localhost:8000/apidoc#",
    "hydra": "http://www.w3.org/ns/hydra/core#",
    "name": "http://schema.org/name",
    "author": "http://schema.org/author"
  },
  "@id": "/books/62",
  "@type": "Book",
  "name": "My awesome book",
  "author": "/people/59"
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```php
<?php
// src/Entity/Book.php

namespace App\Entity;

use ApiPlatform\Core\Annotation\ApiResource;

/**
 * @ApiResource(
 *     attributes={"normalization_context"={"jsonld_embed_context"=true}
 * })
 */
class Book
{
    // ...
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### Comprendre et utiliser le fonctionnement des événements API Platform
##### [The Event System](https://api-platform.com/docs/core/events)
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```php
<?php
// src/EventSubscriber/BookMailSubscriber.php

namespace App\EventSubscriber;

use ApiPlatform\Core\EventListener\EventPriorities;
use App\Entity\Book;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Event\GetResponseForControllerResultEvent;
use Symfony\Component\HttpKernel\KernelEvents;

final class BookMailSubscriber implements EventSubscriberInterface
{
    private $mailer;

    public function __construct(\Swift_Mailer $mailer)
    {
        $this->mailer = $mailer;
    }

    public static function getSubscribedEvents()
    {
        return [
            KernelEvents::VIEW => ['sendMail', EventPriorities::POST_WRITE],
        ];
    }

    public function sendMail(GetResponseForControllerResultEvent $event)
    {
        $book = $event->getControllerResult();
        $method = $event->getRequest()->getMethod();

        if (!$book instanceof Book || Request::METHOD_POST !== $method) {
            return;
        }

        $message = \Swift_Message::newInstance()
            ->setSubject('A new book has been added')
            ->setFrom('system@example.com')
            ->setTo('contact@les-tilleuls.coop')
            ->setBody(sprintf('The book #%d has been added.', $book->getId()));

        $this->mailer->send($message);
    }
}
```

--

<!-- .slide: data-title="Comprendre et utiliser le fonctionnement des événements API Platform" -->

| Name | Event | Pre & Post hooks | Priority | Description 3
| --- | --- | --- | --- | --- |
| `AddFormatListener` | `kernel.request` | None | 7 | guess the best response format ( [content negotiation](/docs/core/content-negotiation) ) |
| `ReadListener` | `kernel.request` | `PRE_READ` , `POST_READ` | 4 | retrieve data from the persistence system using the [data providers](https://api-platform.com/docs/core/data-providers) |
| `DeserializeListener` | `kernel.request` | `PRE_DESERIALIZE` , `POST_DESERIALIZE` | 2 | deserialize data into a PHP entity ( `GET` , `POST` , `DELETE` ); update the entity retrieved using the data provider ( `PUT` ) |
| `ValidateListener` | `kernel.view` | `PRE_VALIDATE` , `POST_VALIDATE` | 64 | [validate data](https://api-platform.com/docs/core/validation) ( `POST` , `PUT` ) |
| `WriteListener` | `kernel.view` | `PRE_WRITE` , `POST_WRITE` | 32 | if using the Doctrine ORM, persist data ( `POST` , `PUT` , `DELETE` ) |
| `SerializeListener` | `kernel.view` | None | 16 | serialize the PHP entity in string [according to the request format](https://api-platform.com/docs/core/content-negotiation) |
| `RespondListener` | `kernel.view` | `PRE_RESPOND` , `POST_RESPOND` | 8 | transform serialized to a `Symfony\Component\HttpFoundation\Response` instance |
| `AddLinkHeaderListener` | `kernel.response` | None | 0 | add a `Link` HTTP header pointing to the Hydra documentation |
| `ValidationExceptionListener` | `kernel.exception` | None | 0 | serialize validation exceptions in the Hydra format |
| `ExceptionListener` | `kernel.exception` | None | -96 | serialize PHP exceptions in the Hydra format (including the stack trace in debug mode) |

<!-- .element: style="font-size: 0.4em;" -->

--

<!-- .slide: data-title="Comprendre et utiliser le fonctionnement des événements API Platform" -->

| Constant | Event | Priority |
| --- | --- | --- |
| `PRE_READ` | `kernel.request` | 5 |
| `POST_READ` | `kernel.request` | 3 |
| `PRE_DESERIALIZE` | `kernel.request` | 3 |
| `POST_DESERIALIZE` | `kernel.request` | 1 |
| `PRE_VALIDATE` | `kernel.view` | 65 |
| `POST_VALIDATE` | `kernel.view` | 63 |
| `PRE_WRITE` | `kernel.view` | 33 |
| `POST_WRITE` | `kernel.view` | 31 |
| `PRE_RESPOND` | `kernel.view` | 9 |
| `POST_RESPOND` | `kernel.response` | 0 |

<!-- .element: style="font-size: 0.9em;" -->

--

#### Créer des opérations dédiées
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```php
<?php
// src/Entity/Book.php

use ApiPlatform\Core\Annotation\ApiResource;

/**
 * @ApiResource(itemOperations={
 *     "get"={"method"="GET"},
 *     "special"={"route_name"="book_special"}
 * })
 */
class Book
{
    //...
}
```

--

<!-- .slide: data-title="Créer des opérations dédiées" -->

```php
<?php
// src/Action/BookSpecial.php

namespace App\Action;

use App\Entity\Book;
use Doctrine\Common\Persistence\ManagerRegistry;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Symfony\Component\Routing\Annotation\Route;

class BookSpecial
{
    private $myService;

    public function __construct(MyService $myService)
    {
        $this->myService = $myService;
    }

    /**
     * @Route(
     *     name="book_special",
     *     path="/books/{id}/special",
     *     defaults={"_api_resource_class"=Book::class, "_api_item_operation_name"="special"}
     * )
     * @Method("PUT")
     */
    public function __invoke($data) // API Platform retrieves the PHP entity using the data provider then (for POST and
                                    // PUT method) deserializes user data in it. Then passes it to the action. Here $data
                                    // is an instance of Book having the given ID. By convention, the action's parameter
                                    // must be called $data.
    {
        $this->myService->doSomething($data);

        return $data; // API Platform will automatically validate, persist (if you use Doctrine) and serialize an entity
                      // for you. If you prefer to do it yourself, return an instance of Symfony\Component\HttpFoundation\Response
    }
}
```

--

<!-- .slide: data-title="Créer des opérations dédiées" -->

```php
<?php
// src/Controller/BookController.php

namespace App\Controller;

use App\Entity\Book;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class BookController extends Controller
{
    public function specialAction($data)
    {
        return $this->get('my_service')->doSomething($data);
    }
}
```

```yml
# app/config/routing.yml
book_special:
    path: '/books/{id}/special'
    methods:  ['PUT']
    defaults:
        _controller: 'App:Book:special'
        _api_resource_class: 'App\Entity\Book'
        _api_item_operation_name: 'special'
```

--

#### Implémenter des mécanismes de stockage personnalisé avec les fournisseurs de stockage
##### Custom Collection Data Provider
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

```php
<?php
// src/DataProvider/BlogPostCollectionDataProvider.php

namespace App\DataProvider;

use App\Entity\BlogPost;
use ApiPlatform\Core\DataProvider\CollectionDataProviderInterface;
use ApiPlatform\Core\Exception\ResourceClassNotSupportedException;

final class BlogPostCollectionDataProvider implements CollectionDataProviderInterface
{
    public function getCollection(string $resourceClass, string $operationName = null)
    {
        if (BlogPost::class !== $resourceClass) {
            throw new ResourceClassNotSupportedException();
        }

        // Retrieve the blog post collection from somewhere
        return [new BlogPost(1), new BlogPost(2)];
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```yml
# app/config/services.yml
services:
    # ...
    'App\DataProvider\BlogPostCollectionDataProvider':
        tags: [ { name: 'api_platform.collection_data_provider', priority: 2 } ]
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

##### Custom Item Data Provider
<!-- .slide: data-title="Implémenter des mécanismes de stockage personnalisé avec les fournisseurs de stockage" -->

```php
<?php
// src/DataProvider/BlogPostItemDataProvider.php

namespace App\DataProvider;

use App\Entity\BlogPost;
use ApiPlatform\Core\DataProvider\ItemDataProviderInterface;
use ApiPlatform\Core\Exception\ResourceClassNotSupportedException;

final class BlogPostItemDataProvider implements ItemDataProviderInterface
{
    public function getItem(string $resourceClass, $id, string $operationName = null, array $context = [])    {
        if (BlogPost::class !== $resourceClass) {
          throw new ResourceClassNotSupportedException();
        }

        // Retrieve the blog post item from somewhere then return it or null if not found
        return new BlogPost($id);
    }
}
```
```yml
# app/config/services.yml
services:
    # ...
    'App\DataProvider\BlogPostItemDataProvider':
        tags: [ 'api_platform.item_data_provider' ]
```

--

##### [ElasticSearch Support](https://hugo-soltys.com/blog/use-api-platform-with-elasticsearch-instead-of-doctrine-in-your-symfony-application)
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

<blockquote style="width: 100%" class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">New approach : Use <a href="https://twitter.com/hashtag/Elasticsearch?src=hash&amp;ref_src=twsrc%5Etfw">#Elasticsearch</a> with <a href="https://twitter.com/hashtag/ApiPlatform?src=hash&amp;ref_src=twsrc%5Etfw">#ApiPlatform</a> instead of <a href="https://twitter.com/hashtag/Doctrine?src=hash&amp;ref_src=twsrc%5Etfw">#Doctrine</a> in your <a href="https://twitter.com/hashtag/Symfony?src=hash&amp;ref_src=twsrc%5Etfw">#Symfony</a> application<a href="https://t.co/T6mBbNLcOJ">https://t.co/T6mBbNLcOJ</a></p>&mdash; Hugo Soltys (@HugoSoltys) <a href="https://twitter.com/HugoSoltys/status/935148203590213633?ref_src=twsrc%5Etfw">November 27, 2017</a></blockquote>

--

##### ElasticSearch Support : [FOSElasticaBundle](https://github.com/FriendsOfSymfony/FOSElasticaBundle)
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->


```yml
fos_elastica:
    clients:
        default: { host: %elastic_host%, port: %elastic_port% }
    indexes:
        my_index_name:
            types:
                article:
                    mappings:
                        title: ~
                        content: ~
                        publishedAt: ~
                        author: ~
                    persistence:
                        driver: orm
                        model: App\Entity\Article
                        provider: ~
                        finder: ~
                        repository: App\SearchRepository\ArticleRepository
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```xml
<?xml version="1.0" ?>
<container xmlns="http://symfony.com/schema/dic/services"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://symfony.com/schema/dic/services http://symfony.com/schema/dic/services/services-1.0.xsd">
    <services>
        <service id="app.data_provider.article_collection" class="App\DataProvider\ArticleCollectionDataProvider">
            <argument type="service" id="fos_elastica.repository_manager" />
            <tag name="api_platform.collection_data_provider" />
        </service>
    </services>
</container>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
<?php

namespace App\DataProvider;

use ApiPlatform\Core\DataProvider\CollectionDataProviderInterface;
use App\SearchRepository\ArticleRepository;
use FOS\ElasticaBundle\Manager\RepositoryManager;

final class CollectionDataProvider implements CollectionDataProviderInterface
{
    private $repositoryManager;

    public function __construct(RepositoryManager $repositoryManager)
    {
        $this->repositoryManager = $repositoryManager;
    }

    public function getCollection(string $resourceClass, string $operationName = null)
    {
        $classAsArray = explode('\\', $resourceClass);
        $className = strtolower(end($classAsArray));

        /** @var SearchRepository $repository */
        $repository = $this->repositoryManager->getRepository('App:' . $className);

        // your custom elastic query
        $results = $repository->getQueryForMultipleItems();

        return $results;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->


```xml
<?xml version="1.0" ?>
<container xmlns="http://symfony.com/schema/dic/services"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://symfony.com/schema/dic/services http://symfony.com/schema/dic/services/services-1.0.xsd">
    <services>
        <service id="app.data_provider.article_item" class="App\DataProvider\ArticleItemDataProvider">
            <argument type="service" id="fos_elastica.repository_manager" />
            <tag name="api_platform.item_data_provider" />
        </service>
    </services>
</container>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```php
<?php

namespace App\DataProvider;

use ApiPlatform\Core\DataProvider\ItemDataProviderInterface;
use App\SearchRepository\ArticleRepository;
use FOS\ElasticaBundle\Finder\TransformedFinder;
use FOS\ElasticaBundle\Manager\RepositoryManager;

class ItemDataProvider implements ItemDataProviderInterface
{
    private $repositoryManager;

    public function __construct(RepositoryManager $repositoryManager)
    {
        $this->repositoryManager = $repositoryManager;
    }

    public function getItem(string $resourceClass, $id, string $operationName = null, array $context = [])
    {
        $classAsArray = explode('\\', $resourceClass);
        $className = strtolower(end($classAsArray));

        /** @var SearchRepository $repository */
        $repository = $this->repositoryManager->getRepository('App:' . $className);

        // your custom elastic query
        $results = $repository->getQueryForSingleItem($id);

        if (is_array($results) && array_key_exists(0, $results)) {
            return $results[0];
        }

        return null;
    }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

##### GraphQL Support
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

![](images/php/graphql.org_.png)

[api-platform/core@master](https://github.com/api-platform/api-platform/tree/master) ([@alanpoulain](https://github.com/alanpoulain) & [@raoulclais](https://github.com/raoulclais))

```bash
$ composer req webonyx/graphql-php 
```

--

<iframe width="960" height="600" src="https://www.youtube-nocookie.com/embed/fegcUxhMyp0?rel=0" frameborder="0" allowfullscreen></iframe>

--

##### [GraphQL Support : côté client](http://graphql.org/code/#javascript-1)
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

<ul style="font-size: 0.9em"><li><a href="https://facebook.github.io/relay/" target="_blank" rel="nofollow noopener noreferrer">Relay</a> (<a href="https://github.com/facebook/relay" target="_blank" rel="nofollow noopener noreferrer">github</a>) (<a href="https://www.npmjs.com/package/react-relay" target="_blank" rel="nofollow noopener noreferrer">npm</a>): Facebook's framework for building React applications that talk to a GraphQL backend.</li><li><a href="http://apollographql.com/client/" target="_blank" rel="nofollow noopener noreferrer">Apollo Client</a> (<a href="https://github.com/apollographql/apollo-client" target="_blank" rel="nofollow noopener noreferrer">github</a>): A powerful JavaScript GraphQL client, designed to work well with React, React Native, Angular 2, or just plain JavaScript.</li><li><a href="https://github.com/graphcool/graphql-request" target="_blank" rel="nofollow noopener noreferrer">graphql-request</a>: A simple and flexible JavaScript GraphQL client that works in all JavaScript environments (the browser, Node.js, and React Native) - basically a lightweight wrapper around <code>fetch</code>.</li><li><a href="https://github.com/kadirahq/lokka" target="_blank" rel="nofollow noopener noreferrer">Lokka</a>: A simple JavaScript GraphQL client that works in all JavaScript environments (the browser, Node.js, and React Native).</li><li><a href="https://github.com/yoshuawuyts/nanogql" target="_blank" rel="nofollow noopener noreferrer">nanogql</a>: Tiny GraphQL client library using template strings.</li></ul>

--

##### GraphQL : Ressources
<!-- .slide: data-title="Créer des APIs RESTful avec API Platform" -->

- [GraphQL.org](http://graphql.org/)
- [Jour 14 - Une API GraphQL avec Symfony](https://afsy.fr/avent/2017/14-une-api-graphql-avec-symfony)
- [Symfony Finland : Adding a GraphQL API to your Symfony Flex application](https://symfony.fi/entry/adding-a-graphql-api-to-your-symfony-flex-app)
- [GraphQL vs. REST - A GraphQL Tutorial](https://www.toptal.com/api-development/graphql-vs-rest-tutorial)
- [A Front End Developer’s Guide to GraphQL](https://css-tricks.com/front-end-developers-guide-graphql/)

--

###### _TP : Créer des APIs RESTful avec API Platform_

---

### 15. Bonus 
#### Avantages de Symfony 4 et Symfony Flex

--

![](images/php/symfony-4.jpg) <!-- .element class="plain" height="200" -->

- A Better Symfony <!-- .element class="fragment" -->
- Automate everything <!-- .element class="fragment" -->
- Micro by default <!-- .element class="fragment" -->
- Rock solid stability <!-- .element class="fragment" -->
- Smooth Upgrade <!-- .element class="fragment" -->

--

![](images/php/symfony-4.jpg) <!-- .element class="plain" height="200" -->

[Symfony Finland: Four things I like about Symfony 4](https://symfony.fi/entry/four-things-i-like-about-symfony-4)

1. Simplified project structure <!-- .element class="fragment" -->
2. Easier installation of extensions <!-- .element class="fragment" -->
3. Dependency Injection improvements <!-- .element class="fragment" -->
4. Symfony Encore for asset management <!-- .element class="fragment" -->

--

<blockquote style="font-size: 0.7em" class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">We&#39;re working non-stop to update all docs to Symfony 4. The best so far? Symfony 4 is so simple that we remove twice the lines we add 😍 <a href="https://t.co/j6f9zubH6z"><img class="plain" data-aria-label-part="" src="https://pbs.twimg.com/media/DPaFHFjX0AAmo2T.jpg" alt="" style="width: 100%; top: -0px;"></a></p>&mdash; Symfony Docs (@symfonydocs) <a href="https://twitter.com/symfonydocs/status/934080419938611201?ref_src=twsrc%5Etfw">November 24, 2017</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


--
<!-- .slide: data-title="Introduction à Symfony 4 et Symfony Flex" -->
#### Installation et configuration

- Symfony 4 + Symfony Flex

```bash
composer create-project symfony/skeleton my_project
composer create-project symfony/skeleton my_project 3.4
```

--
<!-- .slide: data-title="Introduction à Symfony 4 et Symfony Flex" -->
#### Installation et configuration

Symfony Flex : Projet existant

<ol style="font-size: 0.5em">
<li>Create a new empty Symfony application (<code class="notranslate">composer create-project
symfony/skeleton my-project-flex</code>)</li>
<li>Merge the <code class="notranslate">require</code> and <code class="notranslate">require-dev</code> dependencies defined in your
original project's <code class="notranslate">composer.json</code> file to the <code class="notranslate">composer.json</code> file of the
new project (don't copy the <code class="notranslate">symfony/symfony</code> dependency, but add the
relevant components you are effectively using in your project).</li>
<li>Install the dependencies in the new project executing <code class="notranslate">composer install</code>.
This will make Symfony Flex generate all the configuration files in
<code class="notranslate">config/packages/</code></li>
<li>Review the generated <code class="notranslate">config/packages/*.yaml</code> files and make any needed
changes according to the configuration defined in the
<code class="notranslate">app/config/config_*.yml</code> file of your original project. Beware that this is
the most time-consuming and error-prone step of the upgrade process.</li>
<li>Move the original parameters defined in <code class="notranslate">app/config/parameters.*.yml</code> to
the new <code class="notranslate">config/services.yaml</code> and <code class="notranslate">.env</code> files depending on your needs.</li>
<li>Move the original source code from <code class="notranslate">src/{App,...}Bundle/</code> to <code class="notranslate">src/</code> and
update the namespaces of every PHP file to be <code class="notranslate">App\...</code> (advanced IDEs can do
this automatically).</li>
<li>Move the original templates from <code class="notranslate">app/Resources/views/</code> to <code class="notranslate">templates/</code>
and <code class="notranslate">app/Resources/translations</code> to <code class="notranslate">translations/</code>. There may be a few
other files you need to move into a new location.</li>
<li>Make any other change needed by your application. For example, if your
original <code class="notranslate">web/app_*.php</code> front controllers were customized, add those changes
to the new <code class="notranslate">public/index.php</code> controller.</li>
</ol>

--
<!-- .slide: data-title="Introduction à Symfony 4 et Symfony Flex" -->

#### Architecture d’un projet Symfony 4 / Flex

```css
|-- bin/
|   `-- console
|-- composer.json
|-- composer.lock
|-- config/
|   |-- bundles.php
|   |-- packages
|   |   |-- dev
|   |   |   `-- routing.yaml
|   |   |-- framework.yaml
|   |   |-- routing.yaml
|   |   `-- test
|   |       `-- framework.yaml
|   |-- routes.yaml
|   `-- services.yaml
|-- public/
|   |-- bundles
|   `-- index.php
|-- src/
|   |-- Controller
|   |-- ...
|   `-- Kernel.php
|-- symfony.lock
|-- templates/
|-- translations/
`-- var
    |-- cache
    `-- log
└── vendor/
```

--
<!-- .slide: data-title="Introduction à Symfony 4 et Symfony Flex" -->

#### Symfony Flex Recipes

- [Symfony Recipes Repository](https://github.com/symfony/recipes)
- [Symfony Contrib Recipes Repositories](https://github.com/symfony/recipes-contrib)
- [symfony.sh : Symfony Recipes Server](https://symfony.sh/)

```bash
composer require admin
composer require api
composer require mailer
```

```json
{
    "bundles": {
        "Symfony\\Bundle\\SwiftmailerBundle\\SwiftmailerBundle": ["all"]
    },
    "copy-from-recipe": {
        "config/": "%CONFIG_DIR%/"
    },
    "env": {
        "MAILER_URL": "smtp://localhost:25?encryption=&auth_mode="
    },
    "aliases": ["mailer", "mail"]
}
```

--
<!-- .slide: data-background-iframe="https://symfony.sh/" data-title="Symfony Flex Recipes" -->

--

###### _TP : Bonus : Symfony 4 et Symfony Flex_

---

## Symfony : 
### Ressources

<ul style="font-size: 0.6em">
<li>[Symfony Documentation](https://symfony.com/doc/current/index.html) : Doc officielle de Symfony</li>
<li>[Doctrine ORM Documentation](http://docs.doctrine-project.org/projects/doctrine-orm/en/latest/) : doc officielle de Doctrine ROM</li>
<li>[Doctrine Migrations documentation](http://docs.doctrine-project.org/projects/doctrine-migrations/en/latest/) : doc officielle de Doctrine Migrations</li>
<li>[Symfony Recipes Server](https://symfony.sh/) : pour trouver les recettes qui vont bien</li>
<li>[SensioLabs - YouTube Channel](https://www.youtube.com/channel/UCLdVmxwj9dQqM8tJJp2LYGw) : pour apprendre en vidéo</li>
<li>[KnpBundles](http://knpbundles.com/) : pour trouver les bundles qui nous facilite la vie</li>
<li>[KnpUniversity](https://knpuniversity.com/) : encore pour apprendre</li>
<li>[KnpUniversity - YouTube Channel](https://www.youtube.com/channel/UClZfXDJYYRqGV60HQeEk46g) : toujours plus de vidéos</li>
<li>[API Platform](https://api-platform.com/) : la solution idéal pour créer des API REST (et même GraphQL !)</li>
</ul>

--

## Symfony : 
### Bundles __incontournables__ !

<ul style="font-size: 0.6em">
<li>[PayumBundle](https://github.com/Payum/PayumBundle) : Le bundle qui facilite la mise en place d'une centaine de moyen de paiement différents, amazing !</li>
<li>[EasyAdminBundle](https://symfony.com/doc/current/bundles/EasyAdminBundle/index.html) : Pour créer le BO simplement et rapidement</li>
<li>[DoctrineMigrationsBundle](https://symfony.com/doc/master/bundles/DoctrineMigrationsBundle/index.html) : pour versionner notre schema de BDD, en générant les migrations</li>
<li>[FOSElasticaBundle](https://github.com/FriendsOfSymfony/FOSElasticaBundle) : pour intégrer ElasticSearch facilement</li>
<li>[FOSJsRoutingBundle](https://symfony.com/doc/master/bundles/FOSJsRoutingBundle/index.html) : pour exposer le routing Symfony au JS</li>
<li>[FOSUserBundle](https://github.com/FriendsOfSymfony/FOSUserBundle) : pour faciliter la gestion des utilisateurs/groupes en BDD</li>
<li>[BazingaJsTranslationBundle](https://github.com/willdurand/BazingaJsTranslationBundle) : pour exposer les catalogues de traduction Symfony au JS</li>
<li>[BazingaFakerBundle](https://github.com/willdurand/BazingaFakerBundle) : pour générer des données de test</li>
<li>[KnpLabs/DoctrineBehaviors](https://github.com/KnpLabs/DoctrineBehaviors) : pour ajouter des comportements aux entités Doctrine</li>
<li>[DunglasAngularCsrfBundle](https://github.com/dunglas/DunglasAngularCsrfBundle) : pour protéger les formulaires soumis en Ajax des attaques CSRF</li>
<li>[ReactRenderer](https://github.com/Limenius/ReactRenderer) : pour faire le rendu côté serveur d'application React (quand on n'a pas de serveur NodeJS)</li>
<li>[php-translation/symfony-bundle](https://github.com/php-translation/symfony-bundle) : pour que les dév n'aient plus à gérer la mise à jour des traductions</li>
</ul>
