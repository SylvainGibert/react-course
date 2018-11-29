<!-- # JavaScript : L'avenir c'est maintenant

-- -->

![](images/js/jsfrokids.jpg) 
<!-- .element: class="plain" style="width: 65%" -->

---
<!-- .slide: data-title="JavaScript" -->

## Programme

1. Les bases
1. ES2015/6/7
2. Webpack
3. Introduction à React
4. React avancé
5. Getting started with Redux
6. Redux avancé (Gestion de l'asynchrone)
7. React + Redux + React-router
8. React Server Side Rendering (NodeJS, React-PHP-V8Js)

---
<!-- .slide: data-title="JavaScript" -->
## Les bases

- HTML / JS
- Les variables
- Nombres et opérateurs
- Les chaînes de caractères
- Les objets
- Les tableaux
- Fonctions et portée des fonctions
- Les structures de contrôle

--
<!-- .slide: data-title="JavaScript" -->
## HTML / JS

```html
<!DOCTYPE html>
<html>
<head>
  <title>Hello World!</title>
    <script>
    // Du code JS ici
    </script>
</head>
  <body>
    <script>
    // ou ici
    </script>
  </body>
</html>
```

--
<!-- .slide: data-title="JavaScript" -->
## HTML / JS

```html

<!DOCTYPE html>
<html>
<head>
  <title>Hello World!</title>
  <script src="toto.js" async defer />
</head>
  <body>
    <script src="titi.js" async defer />
  </body>
</html>
```
```js
// Du code JS ici (fichier toto.js)
```
```js
// Du code JS ici (fichier titi.js)
```

- async : exécution asynchrone (le navigateur parse le HTML)
- defer : exécution quand le navigateur a terminé le chargement et le rendu de la page

--
<!-- .slide: data-title="JavaScript" -->
## Les variables

```js
// Nombre
var myAge = 17;

// Texte
var dolphinGoodbye = 'So long and thanks for all the fish';

// Bool
var iAmAlive = true;
var test = 6 < 3;

// Tableaux
var myNameArray = ['Chris', 'Bob', 'Jim'];
var myNumberArray = [10,15,40];
myNameArray[0]; // renverra 'Chris'
myNumberArray[2]; // renverra 40

// Objet
var dog = { name : 'Spot', breed : 'Dalmatian' };
dog.name // renverra 'Spot'
```

--
<!-- .slide: data-title="JavaScript" -->
## Les variables : typage faible

```js
var myNumber = '500'; // 'est une chaîne
typeof(myNumber);
myNumber = 500; // maintenant c'est un nombre
typeof(myNumber);
```


--
<!-- .slide: data-title="JavaScript" -->
## Nombres et opérateurs

<table class="standard-table" style="font-size: 0.5em">
 <thead>
  <tr>
   <th scope="col">Operateur</th>
   <th scope="col">Nom</th>
   <th scope="col">But</th>
   <th scope="col">Exemple</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td><code>+</code></td>
   <td>Addition</td>
   <td>Ajoute deux nombres.</td>
   <td><code>6 + 9</code></td>
  </tr>
  <tr>
   <td><code>-</code></td>
   <td>Soustraction</td>
   <td>Soustrait le nombre de droite de celui de gauche.</td>
   <td><code>20 - 15</code></td>
  </tr>
  <tr>
   <td><code>`*`</code></td>
   <td>Multiplication</td>
   <td>Multiplie les deux nombrer.</td>
   <td><code>3 * 7</code></td>
  </tr>
  <tr>
   <td><code>/</code></td>
   <td>Division</td>
   <td>Divise le nombre de gauche par celui de droite.</td>
   <td><code>10 / 5</code></td>
  </tr>
  <tr>
   <td><code>%</code></td>
   <td>
    <p>Reste (quelquefois nommé modulo)</p>
   </td>
   <td>
    <p>Renvoie le reste de la division du nombre de gauche par celui de droite.</p>
   </td>
   <td><code>8 % 3</code> (renvoie 2, car 3 est contenu 2 fois dans 8, et il reste 2.)</td>
  </tr>
  <tr>
   <td><code>++</code></td>
   <td>
    <p>incrémentation</p>
   </td>
   <td>
    <p>ajoute 1</p>
   </td>
   <td><code>3++;</code> retourne 4</td>
  </tr>
  <tr>
   <td><code>--</code></td>
   <td>
    <p>décrémentation</p>
   </td>
   <td>
    <p>soustrait 1</p>
   </td>
   <td><code>3--;</code> retourne 2</td>
  </tr>
 </tbody>
</table>

--
<!-- .slide: data-title="JavaScript" -->
## Nombres et opérateurs

<table class="standard-table" style="font-size: 0.5em">
 <thead>
  <tr>
   <th scope="col">Operateur</th>
   <th scope="col">Nom</th>
   <th scope="col">But</th>
   <th scope="col">Exemple</th>
   <th scope="col">Raccourci pour</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td><code>+=</code></td>
   <td>Addition et assignation</td>
   <td>Ajoute la valeur de droite à la valeur de la variable de gauche, puis renvoie la nouvelle valeur de la variable</td>
   <td><code>x = 3;<br>
    x += 4;</code></td>
   <td><code>x = 3;<br>
    x = x + 4;</code></td>
  </tr>
  <tr>
   <td><code>-=</code></td>
   <td>Soustraction et assignation</td>
   <td>Soustrait la valeur de droite à la valeur de la variable de gauche, puis renvoie la nouvelle valeur de la variable</td>
   <td><code>x = 6;<br>
    x -= 3;</code></td>
   <td><code>x = 6;<br>
    x = x - 3;</code></td>
  </tr>
  <tr>
   <td><code>`*=`</code></td>
   <td>Multiplication et assignation</td>
   <td>Multiplie la valeur de droite par la valeur de la variable de gauche, puis renvoie la nouvelle valeur de la variable</td>
   <td><code>x = 2;<br>
    x *= 3;</code></td>
   <td><code>x = 2;<br>
    x = x * 3;</code></td>
  </tr>
  <tr>
   <td><code>/=</code></td>
   <td>Division et assignation</td>
   <td>Divise la valeur de la variable de gauche par la valeur de droite, puis renvoie la nouvelle valeur de la variable</td>
   <td><code>x = 10;<br>
    x /= 5;</code></td>
   <td><code>x = 10;<br>
    x = x / 5;</code></td>
  </tr>
 </tbody>
</table>

--
<!-- .slide: data-title="JavaScript" -->
## Les chaînes de caractères

```js
var sgl = 'Guillemet simple.';
var dbl = "Guillemets doubles.";
```

- Soit l'un, soit l'autre
- Pas mélanger `'` et `"`
- Ne pas inclure `'` et `"` dans la chaîne

```js
var bigmouth = 'Je n\'ai pas eu droit à prendre place...';
```

--
<!-- .slide: data-title="JavaScript" -->
## Les chaînes de caractères : Concaténation

```js
var one = 'Hello, ';
var two = 'comment allez‑vous ?';
var joined = one + two;
```

--
<!-- .slide: data-title="JavaScript" -->
## Les chaînes de caractères : Méthodes utiles

```js
// Trouver la longueur d'une chaîne
var browserType = 'mozilla';
browserType.length; // 7

// Retrouver un caractère donné dans une chaîne
browserType[0]; // 'm'
browserType[browserType.length-1]; // 'a'

// Trouver une sous-chaîne à l'intérieur d'une chaîne et l'extraire
browserType.indexOf('zilla'); // 2
browserType.indexOf('vanilla'); // -1
```

--
<!-- .slide: data-title="JavaScript" -->
## Les chaînes de caractères : Méthodes utiles

```js
// Extraire une section d'une chaine de caractères
browserType.slice(0,3); // 'moz'

// Changer la casse
var radData = 'My NaMe Is MuD';
radData.toLowerCase();
radData.toUpperCase();

// Actualiser des parties de chaîne
var browserType = 'mozilla';
browserType.replace('moz','van');
```

--
<!-- .slide: data-title="JavaScript" -->
## Les objets

```js
var obj = new Object();
var obj = {};
obj.nom = "Simon"

var obj = {
  nom: "Carotte",
  for: "Max",
  details: {
    couleur: "orange",
    taille: 12
  }
};
obj.details.couleur; // orange
obj["details"]["taille"]; // 12
```

--
<!-- .slide: data-title="JavaScript" -->
## Les tableaux

```js
var shopping = ['pain', 'lait', 'fromage', 'houmous', 'nouilles'];
var sequence = [1, 1, 2, 3, 5, 8, 13];
var random = ['arbre', 795, [0, 1, 2]];
```

```js
shopping[0]; // renvoie "pain"

shopping[0] = 'crème de sésame';
shopping;
// shopping renvoie maintenant [ "crème de sésame", "lait", "fromage", "houmous", "nouilles" ]
```

```js
// Trouver la taille d'un tableau
sequence.length; // renvoie 7
```

--
<!-- .slide: data-title="JavaScript" -->
## Les tableaux : itération

```js
var sequence = [1, 1, 2, 3, 5, 8, 13];
for (var i = 0; i < sequence.length; i++) {
  console.log(sequence[i]);
}
```

--
<!-- .slide: data-title="JavaScript" -->
## Les tableaux : Méthodes utiles

```js
// Conversions entre chaînes et tableaux
var myData = 'Manchester,London,Liverpool,Birmingham,Leeds,Carlisle';
var myArray = myData.split(',');
var myNewString = myArray.join(',');

var dogNames = ["Rocket","Flash","Bella","Slugger"];
dogNames.toString(); //Rocket,Flash,Bella,Slugger
```

--
<!-- .slide: data-title="JavaScript" -->
## Les tableaux : Méthodes utiles

```js
// Ajout et suppression d'éléments de tableau (à la fin)
var myArray = ['Manchester', 'London', 'Liverpool', 'Birmingham', 'Leeds', 'Carlisle'];
myArray.push('Cardiff'); // ['Manchester', 'London', 'Liverpool', 'Birmingham', 'Leeds', 'Carlisle', 'Cardiff']
myArray.pop(); // ['Manchester', 'London', 'Liverpool', 'Birmingham', 'Leeds', 'Carlisle']

// Ajout et suppression d'éléments de tableau (au début)
myArray.unshift('Cardiff'); // ['Cardiff', 'Manchester', 'London', 'Liverpool', 'Birmingham', 'Leeds', 'Carlisle']
myArray.shift(); // ['Manchester', 'London', 'Liverpool', 'Birmingham', 'Leeds', 'Carlisle']
```

--
<!-- .slide: data-title="JavaScript" -->
## Fonctions et portée des fonctions

```js
/* Déclaration de la fonction 'maFonction' */
 function maFonction(monObjet)
 {
   monObjet.marque = "Toyota";
 }
 
```

--
<!-- .slide: data-title="JavaScript" -->
## Fonctions et portée des fonctions

```js
 /*
  * Déclaration de la variable 'mavoiture';
  * création et initialisation d'un nouvel objet;
  * assigner une référence à 'mavoiture'
  */
 var mavoiture = {
   marque: "Honda",
   modele: "Accord",
   annee: 1998
 };

 /* Affiche 'Honda' */
 console.log(mavoiture.marque);

```

--
<!-- .slide: data-title="JavaScript" -->
## Fonctions et portée des fonctions

```js
 /* Passer la référence de l'objet à la fonction */
 maFonction(mavoiture);

 /*
  * Affiche 'Toyota' pour valeur de la propriété 'marque'
  * de l'objet. C'est ce que la fonction a changé.
  */
 console.log(mavoiture.marque);
```

--
<!-- .slide: data-title="JavaScript" -->
## Fonctions et portée des fonctions

```js
// anonyme
var maFonction = function() {
  /* instructions */
}

// nommée
var maFonction = function pouet(){
  /* instructions */
}

// expression de fonction immédiatement invoquée
(function() {
    /* instruction */
})();
var result = (function () { 
    var name = "Barry"; 
    return name; 
})(); 
// Crée immédiatement la sortie: 
result; // "Barry"
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
var nom = "des chatons";
if (nom == "des chiots") {
  nom += " !";
} else if (nom == "des chatons") {
  nom += " !!";
} else {
  nom = " !" + nom;
}
nom == "des chatons !!"
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
while (true) {
  // une boucle infinie !
}

do {
  var input = getInput();
} while (inputNonValide(input))
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
for (var i = 0; i < 5; i++) {
  // Sera exécutée cinq fois
}
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
for (let propriété in objet) {
  // utiliser des instructions
  // pour manipuler la propriété
}
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
for (let value of array) {
  // utiliser des instructions
  // pour manipuler la valeur value
}
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
var nom = o && o.getNom();
var nom = autreNom || "nomParDéfaut";
var nom = nomEnCache || (nomEnCache = getNom());
var permis = (age > 18) ? "oui" : "non";
```

--
<!-- .slide: data-title="JavaScript" -->
## Les structures de contrôle

```js
switch (action) {
  case 'dessiner':
    dessine();
    break;
  case 'manger':
    mange();
    break;
  default:
    neRienFaire();
}
```

---
<!-- .slide: data-title="JavaScript" -->
## ES2015/6/7

- ```let```, ```const``` vs ```var```
- Math + Number + String + Object APIs
- Fat Arrows Function
- Classes
- Template strings
- Destructuring, Default, Rest & Spread
- Itérateurs & Générateurs
- Promise, async/await
- Modules

--

### ```let``` is the new ```var```
### ```const``` le faux ami
<!-- .slide: data-title="ES2015/6/7" -->

- Oublier ce que vous savez sur ```var```

- __```let```__ : déclaration de variable, portée au niveau du bloc

- __```const```__ : déclaration de variable __à assignation unique__ (mais pas immutable), portée au niveau du bloc

--

### ```let```, ```const```
<!-- .slide: data-title="ES2015/6/7" -->

```js
function fn() {
  let foo = "bar";
  var foo2 = "bar";
  if (true) {
    let foo; // pas d'erreur, foo === undefined
    var foo2;
    // Attention, les déclarations "var" ne sont pas scopées au niveau bloc
    // foo2 est en réalité écrasé !
    foo = "qux";
    foo2 = "qux";
    console.log(foo);
    // "qux", la variable appartient au scope de son blocs (le "if")
    console.log(foo2);
    // "qux"
  }
  console.log(foo);
  // "bar", la variable appartient au scope de son bloc (la fonction "fn")
  console.log(foo2);
  // "qux"
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->


```js
function fn2() {
  let i = 0;
  for (let i = i; i < 10; i++) {
    console.log(i);
  }
  console.log(i);
  // 0

  for (let j = i; j < 10; j++) {}
  console.log(j);
  // j is not defined
}
fn2(); // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
function fn() {
  const foo = "bar"
  if (true) {
    const foo // SyntaxError, la variable a besoin d'être assignée
    const foo = "qux"
    foo = "norf" // SyntaxError, la variable ne peut pas être réassignée
    console.log(foo)
    // "qux", la variable appartient au scope de son bloc (le "if")
  }
  console.log(foo)
  // "bar", la variable appartient au scope de la fonction "fn"
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
function fn() {
  const arr = [1, 2, 3];
  // déclaration évaluée à chaque passage de l'itérateur, 
  // const est donc un meilleur choix que let
  for (const el of arr) {
    console.log(el);
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

![](images/js/d2c7b732-screen-shot-2017-10-28-at-6.33.24-pm-1024x702.png)

--

### Math, Number, String, Object :
##### Nouvelles APIs
<!-- .slide: data-title="ES2015/6/7" -->

```js
Number.EPSILON 
// 2.220446049250313e-16

Number.isInteger(Infinity)
// false

Number.isNaN("NaN")
// false
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
Math.acosh(3) 
// 1.762747174039086

Math.hypot(3, 4) 
// 5

Math.imul(Math.pow(2, 32) - 1, Math.pow(2, 32) - 2) 
// 2
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
"abcde".includes("cd") // true
"abc".repeat(3) // "abcabcabc"
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
Array.from(document.querySelectorAll("*")) 
// Returns a real Array

Array.of(1, 2, 3) 
// Similar to new Array(...), but without special one-arg behavior

[0, 0, 0].fill(7, 1) 
// [0,7,7]

[1,2,3].findIndex(x => x == 2) 
// 1

["a", "b", "c"].entries() 
// iterator [0, "a"], [1,"b"], [2,"c"]

["a", "b", "c"].keys() 
// iterator 0, 1, 2

["a", "b", "c"].values() 
// iterator "a", "b", "c"
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
const o = { y: 0 };
const o1 = { x: 1, y: 2 };
const o2 = { x: undefined, z: 3 };
Object.assign(o, o1, o2); // { x: undefined, y: 2, z: 3 }
o; // { x: undefined, y: 2, z: 3 }
o1; // non modifié
o2; // non modifié
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
// Attention à la mutabilité !
const o1 = { x: 1 };
const o2 = { y: 2 };
const o = Object.assign({}, o1, o2);
o; // { x: 1, y: 2 }
// o1 et o2 n'ont pas été modifiés
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### Fat Arrows Function
<!-- .slide: data-title="ES2015/6/7" -->

- La fin de `Function.prototype.bind`
- Syntaxe raccourcie
- Les fonctions fléchées n'ont pas de `this`

```js
// es5
var myFn = function(x) {
  return x + 1;
};

// es6
const myFn = x => {
  return x + 1;
};

// es6
const myFn = x => x + 1;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
import React, { Component } from “react”
class Stuff extends Component {

  // Ça c'était avant
  onClick(e) {
    this.setState({ omg: false })
  } 

  render() {
    return (
      <div>
        { /* Ça c'était avant */ }
        <button onClick={ this.onClick.bind(this) }>
          Trop old school
        </button>

        { /* Mais c'est super !  */ }
        <button onClick={ (e) => this.onClick(e) }>
          Plus besoin de `bind` !
        </button>

        { /* C'est bien, mais il y a mieux */ }
        <button onClick={ (e) => this.setState({ omg: true }) }>
          Cool mais cela créer une méthode à chaque render
        </button>
      </div>
    )
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```
import React, { Component } from “react”
class Stuff extends Component {

  handleClick = (e) => {
    this.setState({ omg: true })
  }

  render() {
    return (
      <div>
        { /* La crème de la crème */ }
        <button onClick={ this.handleClick }>
          Hell yeah
        </button>
      </div>
    )
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### Classes : Enfin de la vraie POO
<!-- .slide: data-title="ES2015/6/7" -->

- Héritage basé sur prototype
- Méthode d'instance, static et constructeur
- Appels aux méthodes du parent

```js
class Rectangle {
  constructor(hauteur, largeur) {
    this.hauteur = hauteur;
    this.largeur = largeur;
  }
 
  get area() {
    return this.calcArea();
  }

  calcArea() {
    return this.largeur * this.hauteur;
  }
}

const carré = new Rectangle(10, 10);

console.log(carré.area);
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
class Point {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  static distance(a, b) {
    const dx = a.x - b.x;
    const dy = a.y - b.y;
    return Math.hypot(dx, dy);
  }
}

const p1 = new Point(5, 5);
const p2 = new Point(10, 10);

console.log(Point.distance(p1, p2));
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
class Animal { 
  constructor(nom) {
    this.nom = nom;
  }
  
  parle() {
    console.log(this.nom + ' fait du bruit.');
  }
}

class Chien extends Animal {
  constructor(nom) {
    super(nom); // appelle le constructeur parent avec le paramètre
  }
  parle() {
    console.log(this.nom + ' aboie.');
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### Template strings
<!-- .slide: data-title="ES2015/6/7" -->

- Entourée par `
- Plus de concaténation avec `+`
- Chaînes de caractères multi-lignes

```js
// Basic literal string creation
`This is a pretty little template string.`

// Multiline strings
`In ES5 this is
 not legal.`

// Interpolate variable bindings
var name = "Bob", time = "today";
`Hello ${name}, how are you ${time}?`

// Unescaped template strings
String.raw`In ES5 "\n" is a line-feed.`
```

--

### Destructuring
<!-- .slide: data-title="ES2015/6/7" -->

- Affectation via pattern matching
- Support des tableaux et objets

```js
// list matching
var [a, ,b] = [1,2,3];
a === 1;
b === 3;

// object matching
var { op: a, lhs: { op: b }, rhs: c }
       = getASTNode()

// object matching shorthand
// binds `op`, `lhs` and `rhs` in scope
var {op, lhs, rhs} = getASTNode()

// Can be used in parameter position
function g({name: x}) {
  console.log(x);
}
g({name: 5})

// Fail-soft destructuring
var [a] = [];
a === undefined;

// Fail-soft destructuring with defaults
var [a = 1] = [];
a === 1;

// Destructuring + defaults arguments
function r({x, y, w = 10, h = 10}) {
  return x + y + w + h;
}
r({x:1, y:2}) === 23
```

--

### Default, Rest & Spread
<!-- .slide: data-title="ES2015/6/7" -->

```js
function f(x, y=12) {
  // y is 12 if not passed (or passed as undefined)
  return x + y;
}
f(3) == 15
```

```js
function f(x, ...y) {
  // y is an Array
  return x * y.length;
}
f(3, "hello", true) == 6
```

```js
function f(x, y, z) {
  return x + y + z;
}
// Pass each elem of array as argument
f(...[1,2,3]) == 6
```

--

### Itérateurs & Générateurs
<!-- .slide: data-title="ES2015/6/7" -->

 - for...of
 - function* et Generator
 - yield et yield*

--

### for...of

Itération simplifiée sur les objets itérables tels que :

- Array
- String
- Maps & WeakMaps
- Generators
- NodeList
- arguments

--

### Itérateurs

- Objet qui accède aux éléments d'une collection
- Expose une méthode next()

```js
function makeIterator(array){
    var nextIndex = 0;
    
    return {
       next: function(){
           return nextIndex < array.length ?
               {value: array[nextIndex++], done: false} :
               {done: true};
       }
    }
}
var it = makeIterator(['yo', 'ya']);
console.log(it.next().value); // 'yo'
console.log(it.next().value); // 'ya'
console.log(it.next().done);  // true
```

--

### Itérables personnalisés
<!-- .slide: data-title="ES2015/6/7" -->

```js
var monItérable = {};
monItérable[Symbol.iterator] = function* () {
    yield 1;
    yield 2;
    yield 3;
};
[...monItérable] // [1, 2, 3]
```

_Itérables natifs : _
`String`, `Array`, `TypedArray`, `Map`, `Set`

--

### Générateurs : <br>`function*` + `yield`
<!-- .slide: data-title="ES2015/6/7" -->

```js
function* idMaker(){
  var index = 0;
  while(true)
    yield index++;
}

var gen = idMaker();

console.log(gen.next().value); // 0
console.log(gen.next().value); // 1
console.log(gen.next().value); // 2
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
function* fibonacci(){
  var fn1 = 0;
  var fn2 = 1;
  while (true){
    var current = fn1;
    fn1 = fn2;
    fn2 = fn1 + current;
    var reset = yield current;
    if (reset){
        fn1 = 0;
        fn2 = 1;
    }
  }
}


const iterator = fibonacci();
for (let n of iterator) {
  if (n >= 100) {
    break;
  }
  console.log(n);
}
// 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### Promise, async/await
<!-- .slide: data-title="ES2015/6/7" -->

- Promise :
    + recevoir une valeur (ou une erreur)
    + 3 états : en cours, résolue, rejetée
    + la fin des callbacks
- `async`/`await` :
    + fonctions asynchrones
    + refactorisation d'un code bloquant vers un code non bloquant

--

### Promise
<!-- .slide: data-title="ES2015/6/7" -->

```js
const functionWithCallback1 = callback => callback("test", undefined);
const functionWithCallback2 = (arg, callback) => callback(arg, undefined);
const functionWithCallback3 = (arg, callback) => callback(arg, undefined);
const functionWithCallback4 = (arg, callback) => callback(arg, undefined);
const functionWithCallback5 = (arg, callback) => callback(arg, undefined);
const functionWithCallback6 = (arg, callback) => callback(arg, undefined);

functionWithCallback1((result1, err) => {
  if (err) {
    throw err;
  }
  functionWithCallback2(result1, (result2, err) => {
    if (err) {
      throw err;
    }
    functionWithCallback3(result2, (result3, err) => {
      if (err) {
        throw err;
      }
      functionWithCallback4(result3, (result4, err) => {
        if (err) {
          throw err;
        }
        functionWithCallback5(result4, (result5, err) => {
          if (err) {
            throw err;
          }
          functionWithCallback6(result5, (result6, err) => {
            if (err) {
              throw err;
            }
            console.log(`Exemple avec les callback : ${result6}`);
          });
        });
      });
    });
  });
});
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
const functionWithPromise1 = () => Promise.resolve("test");
const functionWithPromise2 = arg => Promise.resolve(arg);
const functionWithPromise3 = arg => Promise.resolve(arg);
const functionWithPromise4 = arg => Promise.resolve(arg);
const functionWithPromise5 = arg => Promise.resolve(arg);
const functionWithPromise6 = arg => Promise.resolve(arg);

functionWithPromise1()
  .then(functionWithPromise2)
  .then(functionWithPromise3)
  .then(functionWithPromise4)
  .then(functionWithPromise5)
  .then(functionWithPromise6)
  .then(result => console.log(`Exemple avec les promesses : ${result}`))
  .catch(err => {
    throw err;
  });
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
const functionThatReturnAPromise = success => {
  // On utilise la classe Promise pour en créer une, le constructeur prend 2
  // fonctions en paramètre :
  // - resolve que l'on pourra appeler avec le résultat de notre fonction
  // - reject que l'on pourra appeler avec une erreur s'il y a une erreur
  return new Promise((resolve, reject) => {
    if (success) {
      resolve("success");
    } else {
      reject("failed");
    }
  });
};

// Vous pouvez maintenant utiliser votre fonction comme vu précédemment
functionThatReturnAPromise(success)
  .then(res => console.log(res))
  .catch(error => console.log(error));

// équivalent dans notre cas à
functionThatReturnAPromise(success).then(
  res => console.log(res),
  error => console.log(error)
);
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### `async`/`await`
<!-- .slide: data-title="ES2015/6/7" -->

```js
function sendEmails(query) {
  const usersP = getUsers(query);
  // On récupère le champ "email" de tous les utilisateurs
  const emailsP = usersP.then(users => users.map(u => u.email));
  // Pour chaque email…
  const sentP = emailsP.then(emails =>
    emails.map(email => {
      // … on envoie un mail
      return sendMail(email, "Bonne fête");
    })
  );
  // On attend que tous les envois soient résolus
  return Promise.all(sentP);
}

sendEmails({ firstName: "Léo" })
  .then(() => console.log("OK"))
  .catch(() => console.error("FAIL"));
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
async function sendEmails(query) {
  const users = await getUsers(query);
  const emails = users.map(u => u.email);
  const sentP = emails.map(email => sendMail(email, "Bonne fête"));
  return await Promise.all(sentP);
}

// Attention, on ne peut pas utiliser "await" hors d'une fonction "async"
// il faut donc "wrapper" notre code autour d'une fonction asynchrone
async function main() {
  try {
    await sendEmails({ firstName: "Léo" });
    console.log("OK");
  } catch (e) {
    console.error("FAIL");
  }
}

main();
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
// Dans ce cas on perd l'aspect concurrentiel :
const x = await getX() // Requête Ajax…
// … requête terminée !
const y = await getY() // Requête BDD…
// … requête terminée !
const result = sum([x, y])
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
const xP = getX() // Requête Ajax démarrée…
const yP = getY() // Requête BDD démarrée…

// Version 1 :
const x = await xP // …requête Ajax terminée !
const y = await yP // …requête BDD terminée !
const result = sum([x, y])

// Version 2 avec un tableau :
const vars = [await xP, await yP]
const result = sum(vars)

// Version 3 avec Promise.all :
const vars = await Promise.all([xP, yP])
const result = sum(vars)
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### Modules
<!-- .slide: data-title="ES2015/6/7" -->

- `export`/`import` : fonctions, objets, classes, valeurs

```js
// exports nommés
// module "monModule.js"
function cube(x) {
  return x * x * x;
}
const truc = Math.PI + Math.SQRT2;
export { cube, truc };

// fichier app.js
import { cube, truc } from 'monModule';
console.log(cube(3)); // 27
console.log(truc);    // 4.555806215962888
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
// exports par défaut
// module "monModule.js"
export default function cube(x) {
  return x * x * x;
}

// fichier app.js
import cube from 'monModule';
console.log(cube(3)); // 27
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
import React from 'react'

const Pokemon = ({ pokemon }) => (
  <li className="pokemons__item">
    <button
      type="button"
      className="pokemons__sprite"
      style={{
        backgroundImage: `url(${`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png`})`
      }}
    />
    <p className="pokemons__name">{pokemon.name}</p>
  </li>
)

export default Pokemon
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="ES2015/6/7" -->
## Recap'

- Nouvelles façons de définir des variables
- Meilleure gestion de l'asynchrone
- Nouvelles API
- JS => POO

---

<!-- .slide: data-background-iframe="https://webpack.js.org/" -->
## Webpack
<!-- .element: style="opacity: 0" -->

--

## Webpack

- Installation
- Points d'entrée/sortie
- Loaders
- Plugins

--

### Prérequis
<!-- .slide: data-title="Webpack" -->
### [Yarn](https://yarnpkg.com/lang/en/)
- Debian / Ubuntu

```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
export PATH="$PATH:`yarn global bin`"
```

- Windows [Méthode Old School via l'installeur](https://yarnpkg.com/latest.msi)

```bash
choco install yarn
```
```bash
scoop install yarn
scoop install nodejs
```


--

### Installation
<!-- .slide: data-title="Webpack" -->

```bash
# Création du répertoire du projet
mkdir project_name && cd project_name
# Initialisation du projet
yarn init

# Création de la structure et des fichiers de base du projet
mkdir src dist src/assets/{media,js,scss} -p
touch webpack.config.js README.md .babelrc src/index.html \
    src/app.js src/assets/scss/app.scss
```

```bash
├── dist
├── README.md
├── src
│   ├── app.js
│   ├── assets
│   │   ├── js
│   │   ├── media
│   │   └── scss
│   │       └── app.scss
│   └── index.html
└── webpack.config.js
```

--

### Installation
<!-- .slide: data-title="Webpack" -->

```bash
yarn add --dev webpack
```

Édition du `package.json`

```json
...
"scripts": {
  "build": "webpack",
  "build:prod": "webpack -p",
  "watch": "webpack --watch"
}
...
```

_Pour le mode **"watch"** il faudra désactiver **"safe write"** de PHPStorm_

--

### Points d'entrée/sortie
<!-- .slide: data-title="Webpack" -->

Édition du `webpack.config.js`

```js
const path = require('path');

module.exports = {
  entry: {
    app: './src/app.js',
    vendors: './src/vendors.js'
  },
  output: {
    filename: 'bundle.[chunkhash].js',
    // Output path using NodeJS path module
    path: path.resolve(__dirname, 'dist')
  },
  devtool: 'inline-source-map'
};
```

--

### Loaders
<!-- .slide: data-title="Webpack" -->

- babel-loader

```bash
yarn add --dev babel-loader babel-core babel-preset-env babel-preset-react
```
```js
// webpack.config.js
...
module.exports = {
  ...
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: /src/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ['env', 'react']
          } 
        }
      }
    ]
  }
}
```

--

### Loaders
<!-- .slide: data-title="Webpack" -->

- {css,style,sass}-loader + extract-text-webpack-plugin

```bash
yarn add --dev sass-loader node-sass css-loader style-loader extract-text-webpack-plugin
```
```js
// app.js
import './assets/scss/app.scss';
```
```js
// webpack.config.js
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const webpack = require('webpack');
const extractPlugin = new ExtractTextPlugin({ filename: './assets/css/app.css' });
module.exports = {
  ...
  module: {
    rules: [
      ...
      //sass-loader
      {
        test: /\.scss$/,
        include: [path.resolve(__dirname, 'src', 'assets', 'scss')],
        use: extractPlugin.extract({
          use: [
            {
              loader: 'css-loader',
              options: {
                sourceMap: true
              }
            },
            {
              loader: 'sass-loader',
              options: {
                sourceMap: true
              }
            }
          ],
          fallback: 'style-loader'
        })
      }
    ]
  },
  plugins: [
    new CleanWebpackPlugin(['dist']),
    extractPlugin
  ]
}
```

--

### Plugins
<!-- .slide: data-title="Webpack" -->

- clean-webpack-plugin

```bash
yarn add --dev clean-webpack-plugin
```
```js
// webpack.config.js
...
const CleanWebpackPlugin = require('clean-webpack-plugin');
module.exports = {
    ...
    plugins: [
      new CleanWebpackPlugin(['dist'])
    ]
}
```

--

### Chez nous
<!-- .slide: data-title="Webpack" -->

```js
// webpack.config.js
module.exports = function(env) {
  // Chargement de la configuration en fonction de l'envirronement
  return require(`./webpack.${env}.js`)
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
// webpack.common.js
const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const ManifestPlugin = require('webpack-manifest-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const WebpackChunkHash = require('webpack-chunk-hash');

module.exports = {
  entry: {
    'global': './web/js/global.js',
    'ie8': './web/js/ie8.js'
  },
  output: {
    path: path.join(__dirname, 'web/dist'),
    filename: 'js/[name].[chunkhash].js'
  },
  module: {
    rules: [
      {
        test: /\.modernizrrc.js$/,
        use: [ 'modernizr-loader' ]
      },
      {
        test: /\.modernizrrc(\.json)?$/,
        use: [ 'modernizr-loader', 'json-loader' ]
      },
      // export de la fonction jQuery 'foundation' depuis le core de Foundation
      // @see https://stephane-richin.fr/blog/configurer-foundation-avec-webpack
      {
        test: /(foundation\.core)/,
        loader: 'exports-loader?foundation=jQuery.fn.foundation'
      },
      // Babel permet de transformer notre code JS ES5 en code JS compatible avec tous les navigateurs
      {
        test: /\.js$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['es2015']
          }
        }
      },
      // export de jQuery en tant que variables globales jQuery et $ pour qu'il soit disponible dans l'objet window
      {
        test: require.resolve('jquery'),
        use: [{
          loader: 'expose-loader',
          options: 'jQuery'
        },{
          loader: 'expose-loader',
          options: '$'
        }]
      }
    ]
  },
  // Chaque fichier .js pourra utiliser la fonction 'foundation'
  // On indique alors où est situé cette objet
  resolve: {
    extensions: ['.js'],
    alias: {
      // See https://github.com/Modernizr/Modernizr/blob/master/lib/config-all.json for all available options.
      modernizr$: path.resolve(__dirname, ".modernizrrc"),
      Foundation: 'foundation-sites/js/foundation.core'
    }
  },
  // Puis on ajoute jQuery en global
  plugins: [
    // Ajout d'un hash à chaque fichier pour ne pas avoir à vider le cache navigateur
    new WebpackChunkHash({algorithm: 'sha256'}),
    // Création d'un fichier json faisant le lien entre fichier sans hash et fichier avec hash
    // Sera utilisé par le composant Asset de Symfony cf. https://symfony.com/doc/current/components/asset.html
    new ManifestPlugin({publicPath: '/dist/'}),
    // Suppression des fichiers compilés avant toute nouvelle compilation
    new CleanWebpackPlugin([path.join(__dirname, 'web/dist/*')]),
    // Extraction des css
    new ExtractTextPlugin({
      filename: 'css/[name].[contenthash].css',
      allChunks: true
    }),
    // liens entre varaibles globales et modules npm
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.$': 'jquery',
      'window.jQuery': 'jquery'
    })
  ]
};
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
// webpack.dev.js
const Merge = require('webpack-merge');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CommonConfig = require('./webpack.common.js');

module.exports = Merge(CommonConfig, {
  module: {
    rules: [
      {
        // Compilation des fichiers scss en css (version de dev) avec ajout de commentaires pour savoir où sont définis les sélecteur
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: [
            "css-loader?url=false",
            {
              loader: "sass-loader", options: {
                sourceComments: true,
                outputStyle: 'expanded'
              }
            }
          ]
        })
      }
    ]
  }
});
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
// webpack.prod.js
const webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const Merge = require('webpack-merge');
const CommonConfig = require('./webpack.common.js');

module.exports = Merge(CommonConfig, {
  module: {
    rules: [
      {
        // Compilation des fichiers scss en css (version de prod)
        // Utilisation de plugins pour prefixer et minifier les css
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          //resolve-url-loader may be chained before sass-loader if necessary
          use: [
            { loader: 'css-loader', options: { importLoaders: 1, url: false } },
            {
              loader: 'postcss-loader',
              options: {
                plugins: (loader) => [
                  require('postcss-import')({ root: loader.resourcePath }),
                  require('autoprefixer')({browsers: ['last 2 versions', 'ie 8', 'ie 9'], expand: true, flatten: true}),
                  require('cssnano')({preset: 'advanced'})
                ]
              }
            },
            "sass-loader"
          ]
        })
      }
    ]
  },
  plugins: [
    // Uglification du code js compilé
    new webpack.optimize.UglifyJsPlugin(
      {
        comments: false,
        mangle: {
          // Indispensable pour le code utilisant Function.prototype.name, comme Foundation
          keep_fnames: true
        },
        compress: {
          drop_debugger: true,
          drop_console: true,
          // Indispensable pour le code utilisant Function.prototype.name, comme Foundation
          keep_fnames: true
        }
      }
    )
  ]
});
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

<!-- .slide: data-title="Webpack" -->
## Recap'

- Installation via [Yarn](https://yarnpkg.com/lang/fr/), ou [NPM](https://www.npmjs.com/) (_gestion dépendances_)
- Config : JS / environnement
- Entry : fichiers sources à traiter
- Output : fichiers de prod
- Loaders : chargement de différents types de fichiers
- Plugins : modifier les fichiers en sortie

---

## Introduction à React

- Initialisation du projet
- React 101

--

## Initialisation du projet
<!-- .slide: data-title="Introduction à React" -->

Simplifions nous la vie : Create React App

```bash
yarn global add create-react-app

create-react-app my-app
cd my-app/
```

<video id="videoPlayer" src="videos/js/create-react-app.webm" autoplay autobuffer controls />

--

### Structure du projet
<!-- .slide: data-title="Introduction à React" -->

```css
my-app
├── node_modules
├── package.json
├── package-lock.json
├── public
│   ├── favicon.ico
│   ├── index.html
│   └── manifest.json
├── README.md
└── src
    ├── App.css
    ├── App.js
    ├── App.test.js
    ├── index.css
    ├── index.js
    ├── logo.svg
    └── registerServiceWorker.js
```

--

### En mode développement
<!-- .slide: data-title="Introduction à React" -->

```bash
yarn start
```

<video id="videoPlayer" src="videos/js/create-react-app-2.webm" autoplay autobuffer controls />

--

![](/images/js/React-App.png)

--

### En mode prod
<!-- .slide: data-title="Introduction à React" -->

```bash
yarn build
```
```css
my-app
├── build
│   ├── asset-manifest.json
│   ├── favicon.ico
│   ├── index.html
│   ├── manifest.json
│   ├── service-worker.js
│   └── static
│       ├── css
│       │   ├── main.c17080f1.css
│       │   └── main.c17080f1.css.map
│       ├── js
│       │   ├── main.b0ff49e0.js
│       │   └── main.b0ff49e0.js.map
│       └── media
│           └── logo.5d5d9eef.svg
├── node_modules
[...]
```

--

### Pour prendre la main sur Webpack
<!-- .slide: data-title="Introduction à React" -->

```bash
yarn eject
```
```css
my-app
├── build
├── config
│   ├── env.js
│   ├── jest
│   │   ├── cssTransform.js
│   │   └── fileTransform.js
│   ├── paths.js
│   ├── polyfills.js
│   ├── webpack.config.dev.js
│   ├── webpack.config.prod.js
│   └── webpackDevServer.config.js
[...]
├── scripts
│   ├── build.js
│   ├── start.js
│   └── test.js
└── src

[...]
```

--

### React 101
<!-- .slide: data-title="Introduction à React" -->

```js
// index.js
// import de React
import React from 'react';
// import de ReactDOM (pour rendre l'application)
import ReactDOM from 'react-dom';
// import des CSS (compilés au bon endroit par Webpack)
import './index.css';
// import du composant principal de notre application
import App from './App';
// Utilisation de Service Worker (offline first)
import registerServiceWorker from './registerServiceWorker';

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
// App.js
// import de React et de la class Component
import React, { Component } from 'react';
// import des images (sauvées, et optimisées, au bon endroit par Webpack)
import logo from './logo.svg';
// import des CSS (compilés au bon endroit par Webpack)
import './App.css';

// Création de notre application
class App extends Component {
  // rendu de code jsx en HTML
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
      </div>
    );
  }
}

// Export de notre composant sous la forme de module
export default App;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

###### _TP : Création du projet_
<!-- .element: class="fragment current-visible current-visible-only" -->

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->

- [Differences In Attributes](https://reactjs.org/docs/dom-elements.html#differences-in-attributes)
  + propriétés en lowerCamelCase _(sauf pour `aria-*` et `data-*`)_
  + selected, checked, +defaultChecked
  + value, +defaultValue
  + class => className
  + for => htmlFor
  + dangerouslySetInnerHTML

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->
- [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

Instruction JavaScript dans les props

```
<MyComponent foo={1 + 2 + 3 + 4} />
```
Chaînes de caractères

```
<MyComponent message="&lt;3 Probikeshop" />
<MyComponent message={'<3 Probikeshop'} />
```
Props par défaut à “True”

```
<input type="search" autocomplete />
<input type="search" autocomplete={true} />
```

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->
- [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

Décomposition des props
```
const Button = props => {
  const { kind, ...other } = props;
  const className = kind === "primary" ? "PrimaryButton" : "SecondaryButton";
  return <button className={className} {...other} />;
};
```

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->
- [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

Enfants = chaînes de caractères
```
<MyComponent>Hello world!</MyComponent>

<div>This is valid HTML &amp; JSX at the same time.</div>

<div>Hello World</div>

<div>
  Hello World
</div>

<div>
  Hello
  World
</div>

<div>

  Hello World
</div>
```

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->
- [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

Enfants = JSX
```
<MyContainer>
  <MyFirstComponent />
  <MySecondComponent />
</MyContainer>

<div>
  Here is a list:
  <ul>
    <li>Item 1</li>
    <li>Item 2</li>
  </ul>
</div>

render() {
  // No need to wrap list items in an extra element!
  return [
    // Don't forget the keys :)
    <li key="A">First item</li>,
    <li key="B">Second item</li>,
    <li key="C">Third item</li>,
  ];
}

// Depuis React v16.2.0
render() {
  return (
    <>
      <ChildA />
      <ChildB />
      <ChildC />
    </>
  );
}

function Glossary(props) {
  return (
    <dl>
      {props.items.map(item => (
        // Without the `key`, React will fire a key warning
        <Fragment key={item.id}>
          <dt>{item.term}</dt>
          <dd>{item.description}</dd>
        </Fragment>
      ))}
    </dl>
  );
}
```

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->
- [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

Enfants = Instruction JavaScript
```
<MyComponent>foo</MyComponent>

<MyComponent>{'foo'}</MyComponent>

function Item(props) {
  return <li>{props.message}</li>;
}

function TodoList() {
  const todos = ['finish doc', 'submit pr', 'nag dan to review'];
  return (
    <ul>
      {todos.map((message) => <Item key={message} message={message} />)}
    </ul>
  );
}

// Calls the children callback numTimes to produce a repeated component
function Repeat(props) {
  let items = [];
  for (let i = 0; i < props.numTimes; i++) {
    items.push(props.children(i));
  }
  return <div>{items}</div>;
}

function ListOfTenThings() {
  return (
    <Repeat numTimes={10}>
      {(index) => <div key={index}>This is item {index} in the list</div>}
    </Repeat>
  );
}
```

--

### JSX != HTML
<!-- .slide: data-title="Introduction à React" -->
- [JSX In Depth](https://reactjs.org/docs/jsx-in-depth.html)

Booleans, Null, et Undefined sont ignorés
```
<div />

<div></div>

<div>{false}</div>

<div>{null}</div>

<div>{undefined}</div>

<div>{true}</div>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
<div>
  {showHeader && <Header />}
  <Content />
</div>

<div>
  {props.messages.length > 0 &&
    <MessageList messages={props.messages} />
  }
</div>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
<div>
  My JavaScript variable is {String(myVariable)}.
</div>
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--

#### La vie d'un composant
<!-- .slide: data-title="Introduction à React" -->

![](images/js/react-js-life-cycle-of-components-6267eb79b564.png)
cf. [React JS — Life Cycle of Components](https://medium.com/@aravishack/react-js-life-cycle-of-components-6267eb79b564)

Note:

- Mounting
  + constructor(props)
    * super(props)
    * this.props
    * this.state
    * pas d'event handler
  + getDerivedStateFromProps()
    * retourne un objet pour mettre à jour le state / props
  + render()
    * Création du DOM
  + componentDidMount()
    * DOM
    * API
    * Event Handler
- Updating
  + shouldComponentUpdate(nextProps, nextState)
    * return true ou false : render ou pas
  + getSnapshotBeforeUpdate()
    * capture some information from the DOM (e.g. scroll position) before it is potentially changed.
  + render()
    * modif DOM
  + componentDidUpdate(prevProps, prevState)
    * modif DOM
- Unmounting
  + componentWillUnmount()
    * suppression event handler
- Error Handling
  + componentDidCatch(error, info)
- Autres
  + setState()
  + forceUpdate()
- Class Properties
  + defaultProps
  + displayName
- Instance Properties
  + props
  + state

--

### Premiers pas avec React
<!-- .slide: data-title="Introduction à React" -->

- Renommer App.js en App.jsx
- Créer un composant ProductList
  + Liste des produits de la catégorie [Vélos Électriques](https://www.probikeshop.fr/velo-urbain/velos-urbains-velos-electriques-c9252.html)
- Créer un composant Product
- Créer un "Functional Component" ShoppingCart

--

### Premiers pas avec React
<!-- .slide: data-title="Introduction à React" -->

- Créer un composant ProductList

```js
//...
import products from './c9252.json';
//...
class ProductList extends Component {
// TODO boucle sur products
// TODO méthode render
}
export default ProductList;
```

###### _TP : Ajout d'un composant statique_
<!-- .element: class="fragment" -->

--

### Utilisation des props
<!-- .slide: data-title="Introduction à React" -->

- Créer un composant Product

```js
//...
class Product extends Component {
// TODO méthode render en utilisant les props
}
export default Product;
```
###### _TP : Ajout d'un second composant et utilisation des `props`_
<!-- .element: class="fragment" -->

--

### Gestion des événements
<!-- .slide: data-title="Introduction à React" -->

```js
//...
class Product extends Component {
// TODO Ajouter un bouton "Ajouter au panier"
// TODO gestion du clic
}
export default Product;
```
###### _TP : Gestion de l'état d'un composant_
<!-- .element: class="fragment" -->

--

### Outils développeurs
<!-- .slide: data-title="Introduction à React" -->

[![](images/js/devtools.png)](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi)

--

### Dans quel état j'erre
<!-- .slide: data-title="Introduction à React" -->

 
```diff
 import React, { Component } from 'react';
 
 class Product extends Component {
+  constructor(props) {
+    super();
+    this.state = {
+      isAddedToBasket: false
+    }
+  }
+  handleAddClick = () => {
+    // TODO Mettre à jour l'état
+  }
+  handleRemoveClick = () => {
+    // TODO Mettre à jour l'état
+  }
   render() {
     return (
       <li itemScope itemType="http://schema.org/Product">
         <span itemProp="name">{this.props.bike.name}</span>
         <div itemProp="offers" itemScope itemType="http://schema.org/Offer">
           <span itemProp="price" content="{this.props.bike.price.replace(' ', '').replace(',', '.')}">
@@ -13,6 +27,11 @@ class Product extends Component {
           <link itemProp="availability" href="http://schema.org/InStock" /> En stock
         </div>
         <img itemProp="image" src={this.props.bike.image} alt={this.props.bike.name}/>
+        {
+          this.state.isAddedToBasket
+          ? (<button className="RemoveFromBasket" onClick={this.handleRemoveClick}>Supprimer du panier</button>)
+          : (<button className="AddToBasket" onClick={this.handleAddClick}>Ajouter au panier</button>)
+        }
       </li>
     );
   }
```

--

### Dans quel état j'erre
<!-- .slide: data-title="Introduction à React" -->

```diff
import ProductList from './ProductList';
 import './App.css';
 
 class App extends Component {
+  constructor(props) {
+    super();
+    this.state = {
+      basket: []
+    }
+  }
+  handleAdd = (product) => {
+    // TODO mettre à jour l'état
+  }
+  handleRemove = (product) => {
+    // TODO mettre à jour l'état
+  }
   render() {
     return (
       <div className="App">
        <div className="accountBox_myBasket">
          <img width={20} id="my-basket-image-large" className="accountBoxMyBasket_imageLarge" src="https://assets.probikeshop.fr/images/header/my_basket_blue_large.svg" />
          <span id="my-basket-text-large" className="accountBoxMyBasket_numberProductsLarge">
            {`Mon Panier (${this.state.basket.length})`}
          </span>
        </div>
+        <ProductList onAdd={this.handleAdd} onRemove={this.handleRemove}/>
       </div>
     );
   }
```

--

### Functional Components
<!-- .slide: data-title="Introduction à React" -->

```
function ShoppingCart(props) {
  return (
    // TODO jsx du panier
  );
}
```

###### _TP : Gestion de l'état de l'application_
<!-- .element: class="fragment" -->

--

<!-- .slide: data-title="Introduction à React" -->
## Recap'
- Composant : class  ou fonction
- Utiliser les devtools
- Utilisation des props (rendu de variables, eventHandler)
- Gestion de l'état global de l'application

---

##  Previously On 
<!-- .slide: data-background-size="cover" data-background-image="images/js/javascript-image.jpg" -->

--

- Les bases
  + var, const, let (portée)
  + fonction / méthode
  + classe / héritage
  + ES2015/6/7

- React
  + yarn / npm (~ composer)
  + Composant, render => JSX / HTML
  + Cycle de vie
  + Props / état

--

#### La vie d'un composant
<!-- .slide: data-title="Introduction à React" -->

![](images/js/react-js-life-cycle-of-components-6267eb79b564.png)
cf. [React JS — Life Cycle of Components](https://medium.com/@aravishack/react-js-life-cycle-of-components-6267eb79b564)

--

---

## React avancé

- Typage des props
- Typage dynamique fort
- Refs & DOM
- Controlled / Uncontrolled Components
- Optimisation des performances
- Le context
- Les portals
- Gestion des erreurs
- Higher-Order Components _(HOC)_
- Utiliser des librairies tierces _(jQuery et Foundation)_

--
<!-- .slide: data-title="React avancé" -->
### Typage des props


    import PropTypes from 'prop-types';
    class Greeting extends React.Component {
      render() {
        return (
          <h1>Hello, {this.props.name}</h1>
        );
      }
    }
    Greeting.propTypes = {
      name: PropTypes.string
    };

--
<!-- .slide: data-title="React avancé" -->
### [Typage des props](https://reactjs.org/docs/typechecking-with-proptypes.html#proptypes)

```js
import PropTypes from 'prop-types';

MyComponent.propTypes = {
  // You can declare that a prop is a specific JS primitive. By default, these
  // are all optional.
  optionalArray: PropTypes.array,
  optionalBool: PropTypes.bool,
  optionalFunc: PropTypes.func,
  optionalNumber: PropTypes.number,
  optionalObject: PropTypes.object,
  optionalString: PropTypes.string,
  optionalSymbol: PropTypes.symbol,

  // Anything that can be rendered: numbers, strings, elements or an array
  // (or fragment) containing these types.
  optionalNode: PropTypes.node,

  // A React element.
  optionalElement: PropTypes.element,

  // You can also declare that a prop is an instance of a class. This uses
  // JS's instanceof operator.
  optionalMessage: PropTypes.instanceOf(Message),

  // You can ensure that your prop is limited to specific values by treating
  // it as an enum.
  optionalEnum: PropTypes.oneOf(['News', 'Photos']),

  // An object that could be one of many types
  optionalUnion: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number,
    PropTypes.instanceOf(Message)
  ]),

  // An array of a certain type
  optionalArrayOf: PropTypes.arrayOf(PropTypes.number),

  // An object with property values of a certain type
  optionalObjectOf: PropTypes.objectOf(PropTypes.number),

  // An object taking on a particular shape
  optionalObjectWithShape: PropTypes.shape({
    color: PropTypes.string,
    fontSize: PropTypes.number
  }),

  // You can chain any of the above with `isRequired` to make sure a warning
  // is shown if the prop isn't provided.
  requiredFunc: PropTypes.func.isRequired,

  // A value of any data type
  requiredAny: PropTypes.any.isRequired,

  // You can also specify a custom validator. It should return an Error
  // object if the validation fails. Don't `console.warn` or throw, as this
  // won't work inside `oneOfType`.
  customProp: function(props, propName, componentName) {
    if (!/matchme/.test(props[propName])) {
      return new Error(
        'Invalid prop `' + propName + '` supplied to' +
        ' `' + componentName + '`. Validation failed.'
      );
    }
  },

  // You can also supply a custom validator to `arrayOf` and `objectOf`.
  // It should return an Error object if the validation fails. The validator
  // will be called for each key in the array or object. The first two
  // arguments of the validator are the array or object itself, and the
  // current item's key.
  customArrayProp: PropTypes.arrayOf(function(propValue, key, componentName, location, propFullName) {
    if (!/matchme/.test(propValue[key])) {
      return new Error(
        'Invalid prop `' + propFullName + '` supplied to' +
        ' `' + componentName + '`. Validation failed.'
      );
    }
  })
};
```
###### _TP : Prettier + PropTypes_
<!-- .element: class="fragment" -->

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code

![](images/js/eslint.org_.png) <!-- .element: class="plain" style="vertical-align: middle;" -->
![](images/js/prettier.io_.png) <!-- .element: class="plain" style="vertical-align: middle;" -->

- Respect des conventions avec [ESLint](https://eslint.org/) et [Prettier](https://prettier.io/)

--
<!-- .slide: data-background-iframe="/iframe/js/Probikeshop-JavaScript-Style-Guide.html" data-title="Conventions de code" -->

--
<!-- .slide: data-background-iframe="/iframe/js/Probikeshop-React-JSX-Style-Guide.html" data-title="Conventions de code" -->

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code

- Respect des conventions avec [ESLint](https://eslint.org/) et [Prettier](https://prettier.io/)
- Organisation du code

```
src
├── actions
│   └── NavBarActions.js
├── containers
│   └── NavBar.jsx
├── constants
│   └── NavBarConstants.js
├── components
│   └── App.jsx
└── reducers
    └── NavBarReducer.js
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
src
├── containers # Atoms
│    └── NavBar
│        ├── NavBar.jsx
│        ├── actions.js
│        ├── constants.js
│        └── reducer.js
└── components # Molecules, Organisms, Templates, Pages
    └── App.jsx
```
<!-- .element: class="fragment" -->

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code

- Convention de nommage :
  + `.jsx` pour les composants React
  + `.js` pour le vanilla/plain JavaScript
  + classes en `UpperCamelCase`

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code

- Convention de nommage :
  + eventHandler unique : 

  `onClick = handleClick`
  + eventHandler multiple :

  ` onClick = handleSaveButtonClick, handleCancelButtonClick`

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code

- Binding des eventHandler :


```
import React, { Component } from “react”
class Stuff extends Component {

  // On ne fait plus ça
  handleClick(e) {
    this.setState({ omg: false })
  } 

  render() {
    return (
      <div>
        { /* On ne fait plus ça */ }
        <button onClick={ this.handleClick.bind(this) }>
          Trop old school
        </button>

        { /* C'est mieux, mais non on ne fait pas ça non plus  */ }
        <button onClick={ (e) => this.handleClick(e) }>
          Plus besoin de `bind` !
        </button>

        { /* C'est bien, mais pas idéal */ }
        <button onClick={ (e) => this.setState({ omg: true }) }>
          Cool mais cela créer une méthode à chaque render
        </button>
      </div>
    )
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```
import React, { Component } from “react”
class Stuff extends Component {

  // Utilisation de Fat Arrow pour déclarer l'eventHandler 
  // de la classe
  handleClick = (e) => {
    this.setState({ omg: true })
  }

  render() {
    return (
      <div>
        { /* La crème de la crème */ }
        <button onClick={ this.handleClick }>
          Hell yeah
        </button>
      </div>
    )
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code
- Convention de nommage :
  + pour les actions
    * `getMenu` = `{verb}{Model}`
  + pour les constantes
    * `GET_MENU_PENDING`, `GET_MENU_ERROR`, `GET_MENU_SUCCESS`
    * `{VERB}_{MODEL}_PENDING`, `{VERB}_{MODEL}_ERROR`, `{VERB}_{MODEL}_SUCCESS`
  + `{verb}` = get, post, put, patch, delete
  + `{VERB}` = GET, POST, PUT, PATCH, DELETE

--
<!-- .slide: data-title="React avancé" -->
### Conventions de code
###### _TP : Prettier + PropTypes + ESLint_

--
<!-- .slide: data-title="React avancé" -->
### Refs & DOM

- Cas d'usage :
  + focus, sélection, audio/video
  + animations
  + librairies tierces (jQuery)

__Ne pas pas en abuser !__

--
<!-- .slide: data-title="React avancé" -->
### Ajouter un Ref à un élément

```js
class CustomTextInput extends React.Component {
  constructor(props) {
    super(props);
    this.focusTextInput = this.focusTextInput.bind(this);
  }

  focusTextInput() {
    // Explicitly focus the text input using the raw DOM API
    this.textInput.focus();
  }

  render() {
    // Use the `ref` callback to store a reference to the text input DOM
    // element in an instance field (for example, this.textInput).
    return (
      <div>
        <input
          type="text"
          ref={(input) => { this.textInput = input; }} />
        <input
          type="button"
          value="Focus the text input"
          onClick={this.focusTextInput}
        />
      </div>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
class AutoFocusTextInput extends React.Component {
  componentDidMount() {
    this.textInput.focusTextInput();
  }

  render() {
    return (
      <CustomTextInput
        ref={(input) => { this.textInput = input; }} />
    );
  }
}

class CustomTextInput extends React.Component {
  // ...
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React avancé" -->
### Ref + Functional Component

```js
function MyFunctionalComponent() {
  return <input />;
}

class Parent extends React.Component {
  render() {
    // This will *not* work!
    return (
      <MyFunctionalComponent
        ref={(input) => { this.textInput = input; }} />
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```js
function CustomTextInput(props) {
  // textInput must be declared here so the ref callback can refer to it
  let textInput = null;

  function handleClick() {
    textInput.focus();
  }

  return (
    <div>
      <input
        type="text"
        ref={(input) => { textInput = input; }} />
      <input
        type="button"
        value="Focus the text input"
        onClick={handleClick}
      />
    </div>
  );  
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React avancé" -->
### Exposer le Ref au parent
```
function CustomTextInput(props) {
  return (
    <div>
      <input ref={props.inputRef} />
    </div>
  );
}

class Parent extends React.Component {
  render() {
    return (
      <CustomTextInput
        inputRef={el => this.inputElement = el}
      />
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```
function CustomTextInput(props) {
  return (
    <div>
      <input ref={props.inputRef} />
    </div>
  );
}

function Parent(props) {
  return (
    <div>
      My input: <CustomTextInput inputRef={props.inputRef} />
    </div>
  );
}


class Grandparent extends React.Component {
  render() {
    return (
      <Parent
        inputRef={el => this.inputElement = el}
      />
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
### [Controlled Components](https://reactjs.org/docs/forms.html)

```
class NameForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
    // this.setState({value: event.target.value.toUpperCase()});
  }

  handleSubmit(event) {
    alert('A name was submitted: ' + this.state.value);
    event.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <input type="text" value={this.state.value} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class EssayForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: 'Please write an essay about your favorite DOM element.'
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    alert('An essay was submitted: ' + this.state.value);
    event.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <textarea value={this.state.value} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class FlavorForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {value: 'coconut'};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    alert('Your favorite flavor is: ' + this.state.value);
    event.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Pick your favorite La Croix flavor:
          <select value={this.state.value} onChange={this.handleChange}>
            <option value="grapefruit">Grapefruit</option>
            <option value="lime">Lime</option>
            <option value="coconut">Coconut</option>
            <option value="mango">Mango</option>
          </select>
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class Reservation extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isGoing: true,
      numberOfGuests: 2
    };

    this.handleInputChange = this.handleInputChange.bind(this);
  }

  handleInputChange(event) {
    const target = event.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.setState({
      [name]: value
    });
  }

  render() {
    return (
      <form>
        <label>
          Is going:
          <input
            name="isGoing"
            type="checkbox"
            checked={this.state.isGoing}
            onChange={this.handleInputChange} />
        </label>
        <br />
        <label>
          Number of guests:
          <input
            name="numberOfGuests"
            type="number"
            value={this.state.numberOfGuests}
            onChange={this.handleInputChange} />
        </label>
      </form>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
### [Uncontrolled Components](https://reactjs.org/docs/uncontrolled-components.html)

```
class NameForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    alert('A name was submitted: ' + this.input.value);
    event.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <input type="text" defaultValue="Bob" ref={(input) => this.input = input} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
```

--
<!-- .slide: data-title="React avancé" -->

### Optimisation des performances

#### Production Build

![](images/js/devtools-prod-d0f767f80866431ccdec18f200ca58f1-1e9b4.png)
![](images/js/devtools-dev-e434ce2f7e64f63e597edf03f4465694-1e9b4.png)

--
<!-- .slide: data-title="React avancé" -->

### Optimisation des performances

#### shouldComponentUpdate to the rescue

![](images/js/should-component-update-5ee1bdf4779af06072a17b7a0654f6db-9a3ff.png)

--
<!-- .slide: data-title="React avancé" -->

### Optimisation des performances

#### shouldComponentUpdate et PureComponent en action

```
class CounterButton extends React.Component {
  constructor(props) {
    super(props);
    this.state = {count: 1};
  }

  shouldComponentUpdate(nextProps, nextState) {
    if (this.props.color !== nextProps.color) {
      return true;
    }
    if (this.state.count !== nextState.count) {
      return true;
    }
    return false;
  }

  render() {
    return (
      <button
        color={this.props.color}
        onClick={() => this.setState(state => ({count: state.count + 1}))}>
        Count: {this.state.count}
      </button>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class CounterButton extends React.PureComponent {
  constructor(props) {
    super(props);
    this.state = {count: 1};
  }

  render() {
    return (
      <button
        color={this.props.color}
        onClick={() => this.setState(state => ({count: state.count + 1}))}>
        Count: {this.state.count}
      </button>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class ListOfWords extends React.PureComponent {
  render() {
    return <div>{this.props.words.join(',')}</div>;
  }
}

class WordAdder extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      words: ['marklar']
    };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    // This section is bad style and causes a bug
    const words = this.state.words;
    words.push('marklar');
    this.setState({words: words});
  }

  render() {
    return (
      <div>
        <button onClick={this.handleClick} />
        <ListOfWords words={this.state.words} />
      </div>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React avancé" -->

### Optimisation des performances
#### Des données __Immutables__

```
handleClick() {
  this.setState(prevState => ({
    words: [...prevState.words, 'marklar'],
  }));
};

function updateColorMap(colormap) {
  colormap.right = 'blue';
}
function updateColorMap(colormap) {
  return Object.assign({}, colormap, {right: 'blue'});
}
```

--
<!-- .slide: data-title="React avancé" -->

### Le context

Représente l'état général de l'application

>Context provides a way to pass data through the component tree without having to pass props down manually at every level.

<!-- .element: style="text-align: justify" -->

cf. [Context](https://reactjs.org/docs/context.html)

--
<!-- .slide: data-title="React avancé" -->

### Les portals

Rendre un composant en dehors du DOM de son composant parent
<iframe height='400' scrolling='no' title='Example: Portal event bubbling' src='//codepen.io/gaearon/embed/preview/jGBWpE/?height=400&theme-id=dark&default-tab=js,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'>See the Pen <a href='https://codepen.io/gaearon/pen/jGBWpE/'>Example: Portal event bubbling</a> by Dan Abramov (<a href='https://codepen.io/gaearon'>@gaearon</a>) on <a href='https://codepen.io'>CodePen</a>.
</iframe>

--
<!-- .slide: data-title="React avancé" -->

### Gestion des erreurs

```
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  componentDidCatch(error, info) {
    // Display fallback UI
    this.setState({ hasError: true });
    // You can also log the error to an error reporting service
    logErrorToMyService(error, info);
  }

  render() {
    if (this.state.hasError) {
      // You can render any custom fallback UI
      return <h1>Something went wrong.</h1>;
    }
    return this.props.children;
  }
}
```

--
<!-- .slide: data-title="React avancé" -->

### Gestion des erreurs

<iframe height='400' scrolling='no' title='wqvxGa' src='//codepen.io/gaearon/embed/preview/wqvxGa/?height=400&theme-id=dark&default-tab=js,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'>See the Pen <a href='https://codepen.io/gaearon/pen/wqvxGa/'>wqvxGa</a> by Dan Abramov (<a href='https://codepen.io/gaearon'>@gaearon</a>) on <a href='https://codepen.io'>CodePen</a>.
</iframe>

--
<!-- .slide: data-title="React avancé" -->

### Higher-Order Components __(HOC)__

Une fonction qui prend un composant en paramètre et retourne un nouveau composant

_Redux `connect([mapStateToProps], [mapDispatchToProps], [mergeProps], [options])`_

--
<!-- .slide: data-title="React avancé" -->

### Higher-Order Components __(HOC)__
```
class CommentList extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      // "DataSource" is some global data source
      comments: DataSource.getComments()
    };
  }

  componentDidMount() {
    // Subscribe to changes
    DataSource.addChangeListener(this.handleChange);
  }

  componentWillUnmount() {
    // Clean up listener
    DataSource.removeChangeListener(this.handleChange);
  }

  handleChange() {
    // Update component state whenever the data source changes
    this.setState({
      comments: DataSource.getComments()
    });
  }

  render() {
    return (
      <div>
        {this.state.comments.map((comment) => (
          <Comment comment={comment} key={comment.id} />
        ))}
      </div>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class BlogPost extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      blogPost: DataSource.getBlogPost(props.id)
    };
  }

  componentDidMount() {
    DataSource.addChangeListener(this.handleChange);
  }

  componentWillUnmount() {
    DataSource.removeChangeListener(this.handleChange);
  }

  handleChange() {
    this.setState({
      blogPost: DataSource.getBlogPost(this.props.id)
    });
  }

  render() {
    return <TextBlock text={this.state.blogPost} />;
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
const CommentListWithSubscription = withSubscription(
  CommentList,
  (DataSource) => DataSource.getComments()
);

const BlogPostWithSubscription = withSubscription(
  BlogPost,
  (DataSource, props) => DataSource.getBlogPost(props.id)
);
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
// This function takes a component...
function withSubscription(WrappedComponent, selectData) {
  // ...and returns another component...
  return class extends React.Component {
    constructor(props) {
      super(props);
      this.handleChange = this.handleChange.bind(this);
      this.state = {
        data: selectData(DataSource, props)
      };
    }

    componentDidMount() {
      // ... that takes care of the subscription...
      DataSource.addChangeListener(this.handleChange);
    }

    componentWillUnmount() {
      DataSource.removeChangeListener(this.handleChange);
    }

    handleChange() {
      this.setState({
        data: selectData(DataSource, this.props)
      });
    }

    render() {
      // ... and renders the wrapped component with the fresh data!
      // Notice that we pass through any additional props
      return <WrappedComponent data={this.state.data} {...this.props} />;
    }
  };
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React avancé" -->

### Utiliser des librairies tierces _(jQuery et Foundation)_

```
class SomePlugin extends React.Component {
  componentDidMount() {
    this.$el = $(this.el);
    this.$el.somePlugin();
  }

  componentWillUnmount() {
    this.$el.somePlugin('destroy');
  }

  render() {
    return <div ref={el => this.el = el} />;
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
class SomePlugin extends React.Component {
  componentDidMount() {
    this.$el = $(this.el);
    this.$el.foundation();
    // Ou
    this.$dropdownMenu = new Foundation.DropdownMenu(this.$el, options);
  }

  componentWillUnmount() {
    this.$el.foundation('_destroy');
  }

  render() {
    return (
      <ul ref={el => this.el = el} class="dropdown menu" data-dropdown-menu>
        <li><a href="#">Item 1</a></li>
        <li><a href="#">Item 2</a></li>
        <li><a href="#">Item 3</a></li>
        <li><a href="#">Item 4</a></li>
      </ul>
    );
  }
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

---

## Getting started with Redux

--
<!-- .slide: data-title="Getting started with Redux" -->
### Fonctionnement de Redux

![The Flux diagram : [https://facebook.github.io/flux/](https://facebook.github.io/flux/)](https://facebook.github.io/flux/img/flux-simple-f8-diagram-explained-1300w.png)

--
<!-- .slide: data-title="Getting started with Redux" -->

![Redux Basic Flow](https://camo.githubusercontent.com/5aba89b6daab934631adffc1f301d17bb273268b/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6d656469612d702e736c69642e65732f75706c6f6164732f3336343831322f696d616765732f323438343535322f415243482d5265647578322d7265616c2e676966)

--
<!-- .slide: data-title="Getting started with Redux" -->

![Redux Side Effects with API Middleware](https://camo.githubusercontent.com/9de527b9432cc9244dc600875b46b43311918b59/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6d656469612d702e736c69642e65732f75706c6f6164732f3336343831322f696d616765732f323438343739302f415243482d5265647578322d657874656e6465642d7265616c2d6465636c657261746976652e676966)

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux : 101

```js
import { createStore } from 'redux'

/**
 * This is a reducer, a pure function with (state, action) => state signature.
 * It describes how an action transforms the state into the next state.
 *
 * The shape of the state is up to you: it can be a primitive, an array, an object,
 * or even an Immutable.js data structure. The only important part is that you should
 * not mutate the state object, but return a new object if the state changes.
 *
 * In this example, we use a `switch` statement and strings, but you can use a helper that
 * follows a different convention (such as function maps) if it makes sense for your
 * project.
 */
function counter(state = 0, action) {
  switch (action.type) {
  case 'INCREMENT':
    return state + 1
  case 'DECREMENT':
    return state - 1
  default:
    return state
  }
}

// Create a Redux store holding the state of your app.
// Its API is { subscribe, dispatch, getState }.
let store = createStore(counter)

// You can use subscribe() to update the UI in response to state changes.
// Normally you'd use a view binding library (e.g. React Redux) rather than subscribe() directly.
// However it can also be handy to persist the current state in the localStorage.

store.subscribe(() =>
  console.log(store.getState())
)

// The only way to mutate the internal state is to dispatch an action.
// The actions can be serialized, logged or stored and later replayed.
store.dispatch({ type: 'INCREMENT' })
// 1
store.dispatch({ type: 'INCREMENT' })
// 2
store.dispatch({ type: 'DECREMENT' })
// 1
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux : Actions

Envoyer des données au Store
```js
/*
 * action types
 */

export const ADD_TODO = 'ADD_TODO'
export const TOGGLE_TODO = 'TOGGLE_TODO'
export const SET_VISIBILITY_FILTER = 'SET_VISIBILITY_FILTER'

/*
 * other constants
 */

export const VisibilityFilters = {
  SHOW_ALL: 'SHOW_ALL',
  SHOW_COMPLETED: 'SHOW_COMPLETED',
  SHOW_ACTIVE: 'SHOW_ACTIVE'
}

/*
 * action creators
 */

export function addTodo(text) {
  return { type: ADD_TODO, text }
}

export function toggleTodo(index) {
  return { type: TOGGLE_TODO, index }
}

export function setVisibilityFilter(filter) {
  return { type: SET_VISIBILITY_FILTER, filter }
}
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux : Reducers

Mettre à jour l'état de l'application en fonction d'un action

```js
import { combineReducers } from 'redux'
import {
  ADD_TODO,
  TOGGLE_TODO,
  SET_VISIBILITY_FILTER,
  VisibilityFilters
} from './actions'
const { SHOW_ALL } = VisibilityFilters

function visibilityFilter(state = SHOW_ALL, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return action.filter
    default:
      return state
  }
}

function todos(state = [], action) {
  switch (action.type) {
    case ADD_TODO:
      return [
        ...state,
        {
          text: action.text,
          completed: false
        }
      ]
    case TOGGLE_TODO:
      return state.map((todo, index) => {
        if (index === action.index) {
          return Object.assign({}, todo, {
            completed: !todo.completed
          })
        }
        return todo
      })
    default:
      return state
  }
}

const todoApp = combineReducers({
  visibilityFilter,
  todos
})

export default todoApp
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux : Store

Enregistre, et structure, l'état global de l'application

```js
import { createStore } from 'redux'
import todoApp from './reducers'
import {
  addTodo,
  toggleTodo,
  setVisibilityFilter,
  VisibilityFilters
} from './actions'

let store = createStore(todoApp)

// Log the initial state
console.log(store.getState())

// Every time the state changes, log it
// Note that subscribe() returns a function for unregistering the listener
const unsubscribe = store.subscribe(() =>
  console.log(store.getState())
)

// Dispatch some actions
store.dispatch(addTodo('Learn about actions'))
store.dispatch(addTodo('Learn about reducers'))
store.dispatch(addTodo('Learn about store'))
store.dispatch(toggleTodo(0))
store.dispatch(toggleTodo(1))
store.dispatch(setVisibilityFilter(VisibilityFilters.SHOW_COMPLETED))

// Stop listening to state updates
unsubscribe()
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux + React

<table style="font-size: 0.8em">
    <thead>
        <tr>
            <th></th>
            <th scope="col" style="text-align:left">Présentation</th>
            <th scope="col" style="text-align:left">Logique</th>
        </tr>
    </thead>
    <tbody>
        <tr>
          <th scope="row" style="text-align:right">But</th>
          <td>Layout (html, styles)</td>
          <td>Fonctionnel (API, state)</td>
        </tr>
        <tr>
          <th scope="row" style="text-align:right">Voit Redux</th>
          <td>Non
          </td><td>Oui
        </td></tr>
        <tr>
          <th scope="row" style="text-align:right">Lire l'état</th>
          <td>Via props</td>
          <td>Via Redux</td>
        </tr>
        <tr>
          <th scope="row" style="text-align:right">Change l'état</th>
          <td>Callbacks / props</td>
          <td>Actions Redux</td>
        </tr>
    </tbody>
</table>

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux + React

1. Définir&nbsp;l'état
2. Définir&nbsp;les&nbsp;reducers
3. Définir&nbsp;les&nbsp;actions

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux + React
#### Les actions

```js
export const addToBasket = (value) => {
  return { type: "ADD_TO_BASKET", id: value };
}

export const removeFromBasket = (value) => {
  return { type: "REMOVE_FROM_BASKET", id: value };
}
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux + React
#### Les reducers

```js
const basket = (state = [], action) => {
  switch (action.type) {
    case "ADD_TO_BASKET":
      const basketState = state.slice();
      basketState.push({id: action.id})
      return basketState;
    case "REMOVE_FROM_BASKET":
      return state.filter(element => element.id !== action.id);
    default:
      (action: empty);
      return state;
  }
}

export default basket
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux + React
#### Point d'entrée

```js
 import React from 'react';
 import ReactDOM from 'react-dom';
 import { Provider } from 'react-redux'
 import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
 import pbsApp from './reducers'
 import './index.css';
 import App from './App';
 import registerServiceWorker from './registerServiceWorker';
 
// Initialisation des middlewares et extensions de Redux
const enhancers = [];
const middleware = [];

if (process.env.NODE_ENV === 'development') {
    const devToolsExtension = window.devToolsExtension;
    if (typeof devToolsExtension === 'function') {
      enhancers.push(devToolsExtension());
    }
}

const composedEnhancers = compose(
    applyMiddleware(...middleware),
    ...enhancers
);

let store = createStore(pbsApp, composedEnhancers)

ReactDOM.render(
    <Provider store={store}>
        <App />
    </Provider>,
    document.getElementById('root')
);
```

--
<!-- .slide: data-title="Getting started with Redux" -->
### Redux + React
#### Composant "connecté"

```js
 import React, { Component } from 'react';
 import { connect } from 'react-redux'
 import { addToBasket, removeFromBasket } from './actions'
 import ProductList from './ProductList';
 import ShoppingCart from './ShoppingCart';
 import './App.css';
 
 class App extends Component {
   handleAdd = product => {
     this.props.dispatch(addToBasket(product.id));
   };
   handleRemove = product => {
     this.props.dispatch(removeFromBasket(product.id));
   };
   render() {
     return (
       <div className="App">
         <ShoppingCart productCount={this.props.basket.length} />
         <ProductList onAdd={this.handleAdd} onRemove={this.handleRemove} />
       </div>
     );
   }
 }
 
const mapStateToProps = state => ({
   basket: state.basket
});

export default connect(mapStateToProps)(App);
```
<!-- .element: class="fragment current-visible current-visible-only" -->
```js
 import React, { Component } from 'react';
 import { connect } from 'react-redux'
 import { bindActionCreators } from 'redux'
 import * as actionCreators from './actions'
 import ProductList from './ProductList';
 import ShoppingCart from './ShoppingCart';
 import './App.css';
 
 class App extends Component {
   handleAdd = product => {
     this.props.actions.addToBasket(product.id);
   };
   handleRemove = product => {
     this.props.actions.removeFromBasket(product.id);
   };
   render() {
     return (
       <div className="App">
         <ShoppingCart productCount={this.props.basket.length} />
         <ProductList onAdd={this.handleAdd} onRemove={this.handleRemove} />
       </div>
     );
   }
 }
 
const mapStateToProps = state => ({
   basket: state.basket
});
const mapDispatchToProps = dispatch => {
  return {
     actions: bindActionCreators(Object.assign({}, actionCreators), dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
```
<!-- .element: class="fragment current-visible current-visible-only" -->

###### _TP : Gestion de l'état de l'application avec Redux_
<!-- .element: class="fragment" -->

---

## Redux avancé
### Utilisation de  Redux Thunk

```js
const INCREMENT_COUNTER = 'INCREMENT_COUNTER';

function increment() {
  return {
    type: INCREMENT_COUNTER
  };
}

function incrementAsync() {
  return dispatch => {
    setTimeout(() => {
      // Yay! Can invoke sync or async actions with `dispatch`
      dispatch(increment());
    }, 1000);
  };
}

function incrementIfOdd() {
  return (dispatch, getState) => {
    const { counter } = getState();

    if (counter % 2 === 0) {
      return;
    }

    dispatch(increment());
  };
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="Redux avancé" -->
### Redux Thunk
#### Point d'entrée

```js
 import React from 'react';
 import ReactDOM from 'react-dom';
 import { Provider } from 'react-redux';
 import thunkMiddleware from 'redux-thunk'
 import { createStore, applyMiddleware, compose } from 'redux';
 import pbsApp from './reducers';
 import './index.css';
 import App from './App';
 
 // Initialisation des middlewares et extensions de Redux
 const enhancers = [];
 const middleware = [thunkMiddleware];
```

--
<!-- .slide: data-title="Redux avancé" -->
### Redux Thunk
#### Les actions

```js
export const fetchProducts = () => {
  return (dispatch, getState) => {
    dispatch({ type: "FETCH_PRODUCTS", isLoading: true });
    fetch("/products")
    .then(response => {return response.json()})
    .then(json => {dispatch({ type: "FETCH_PRODUCTS_SUCCESS", isLoading: false, products: json })})
    .catch(error => {dispatch({ type: "FETCH_PRODUCTS_ERROR", isLoading: false, errorMessage: error })});
  }
};
```

--
<!-- .slide: data-title="Redux avancé" -->
### Redux Thunk
#### Les reducers

```js
const products = (state = {isLoading: false, products: []}, action) => {
  switch (action.type) {
    case "FETCH_PRODUCTS": 
      return { ...state, isLoading: action.isLoading };
    case "FETCH_PRODUCTS_SUCCESS": 
      return { ...state, isLoading: action.isLoading, products: action.products };
    case "FETCH_PRODUCTS_ERROR": 
      return { ...state, isLoading: action.isLoading };
    default:
      return state;
  }
}

export default products;
```

--
<!-- .slide: data-title="Redux avancé" -->
### Redux Thunk
#### Composant "connecté"

```js
 import React, { Component } from 'react';
 import Product from './Product';
 import { connect } from 'react-redux';
 import { bindActionCreators } from 'redux';
 import * as actionCreators from './actions/products.js';
 import './App.css';
 
 class ProductList extends Component {
   handleClick = () => {
     this.props.actions.fetchProducts();
   }
   render() {
     if (this.props.products.isLoading) {
       return <div className="App">...loading</div>
     }
     else
     {
       if (this.props.products.products.length) {
         const bikes = this.props.products.products.map((bike, index) => {
           return (
             <Product
               onAdd={this.props.onAdd}
               onRemove={this.props.onRemove}
               key={`product-${index}`}
               bike={bike}
             />
           );
         });
         return (
           <div className="App">
             <header className="App-header">
               <h1 className="App-title">Vélos Électriques</h1> 35 produit(s)
             </header>
             <ul className="App-intro ProductList">{bikes}</ul>
           </div>
         )
       }
       return (
         <div className="App">
               <button onClick={this.handleClick}>Charger les produits</button>
             </div>
             );
     }
   }
 }
 
const mapStateToProps = state => ({
  products: state.products
});
const mapDispatchToProps = dispatch => {
  return {
    actions: bindActionCreators(Object.assign({}, actionCreators), dispatch)
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(ProductList);
```

###### _TP : Action asynchrone avec Redux Thunk_
<!-- .element: class="fragment" -->

---

## React + Redux + React-router

![](images/js/reacttraining.com_react-router_.png)
```bash
yarn add react-router-dom
```

--
<!-- .slide: data-title="React + Redux + React-router" -->
### Utilisation simple

```
// components/Root.js
import React from 'react'
import PropTypes from 'prop-types'
import { Provider } from 'react-redux'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import App from './App'

const Root = ({ store }) => (
  <Provider store={store}>
    <Router>
      <Route path="/:filter?" component={App} />
    </Router>
  </Provider>
)

Root.propTypes = {
  store: PropTypes.object.isRequired
}

export default Root
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
// index.js
import React from 'react'
import { render } from 'react-dom'
import { createStore } from 'redux'
import todoApp from './reducers'
import Root from './components/Root'

let store = createStore(todoApp)

render(
  <Root store={store} />,
  document.getElementById('root')
)
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React + Redux + React-router" -->
### API : routing

- [`<Router>`](https://reacttraining.com/react-router/web/api/Router) : API bas niveau
- [`<BrowserRouter>`](https://reacttraining.com/react-router/web/api/BrowserRouter) : HTML5 history API
- [`<HashRouter>`](https://reacttraining.com/react-router/web/api/HashRouter) : #
- [`<MemoryRouter>`](https://reacttraining.com/react-router/web/api/MemoryRouter) : sans navigateur, ou React Native
- [`<NativeRouter>`](https://reacttraining.com/react-router/native/api/NativeRouter) : iOS / Android
- [`<StaticRouter>`](https://reacttraining.com/react-router/web/api/StaticRouter) : sans changement d'URL (SSR)

--
<!-- .slide: data-title="React + Redux + React-router" -->
### API : navigation

- [`<Link>`](https://reacttraining.com/react-router/web/api/Link) : lien (to: string | object, replace: boolean)
- [`<NavLink>`](https://reacttraining.com/react-router/web/api/NavLink) : lien + styles (activeClassName: string...)
- [`<Redirect>`](https://reacttraining.com/react-router/web/api/Redirect) : redirection (to: string | object, from: string, push: boolean)
- [`<Route>`](https://reacttraining.com/react-router/web/api/Route) : URL <=> composant
- [`<Switch>`](https://reacttraining.com/react-router/web/api/Switch) : rendre le premier `<Route>`, `<Redirect>` / URL
- [`<Prompt>`](https://reacttraining.com/react-router/core/api/Prompt) : confirmation utilisateur pour quitter la page actuelle

--
<!-- .slide: data-title="React + Redux + React-router" -->
### API : utilitaire

- [`history`](https://reacttraining.com/react-router/web/api/history) : historique de navigation
- [`location`](https://reacttraining.com/react-router/web/api/location) : état présent, passé et futur
- [`match`](https://reacttraining.com/react-router/web/api/match) : information / URL
- [`matchPath`](https://reacttraining.com/react-router/web/api/matchPath) : action / URL en dehors du rendu
- [`withRouter`](https://reacttraining.com/react-router/web/api/withRouter) : HOC `props: { match, location, history }`

--
<!-- .slide: data-title="React + Redux + React-router" -->
### Code Splitting

```
/* Import the components */
import Home from "./containers/Home";
import Posts from "./containers/Posts";
import NotFound from "./containers/NotFound";

/* Use components to define routes */
export default () =>
  <Switch>
    <Route path="/" exact component={Home} />
    <Route path="/posts/:id" exact component={Posts} />
    <Route component={NotFound} />
  </Switch>;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
// src/components/AsyncComponent.js
import React, { Component } from "react";

export default function asyncComponent(importComponent) {
  class AsyncComponent extends Component {
    constructor(props) {
      super(props);

      this.state = {
        component: null
      };
    }

    async componentDidMount() {
      const { default: component } = await importComponent();

      this.setState({
        component: component
      });
    }

    render() {
      const C = this.state.component;

      return C ? <C {...this.props} /> : null;
    }
  }

  return AsyncComponent;
}
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
import asyncComponent from "./components/AsyncComponent";
/* Import the components */
const AsyncHome = asyncComponent(() => import("./containers/Home"));
const AsyncPosts = asyncComponent(() => import("./containers/Posts"));
const AsyncNotFound = asyncComponent(() => import("./containers/NotFound"));

/* Use components to define routes */
export default ({ childProps }) =>
  <Switch>
    <Route path="/" exact component={AsyncHome} />
    <Route path="/posts/:id" exact component={AsyncPosts} />
    <Route component={AsyncNotFound} />
  </Switch>;
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React + Redux + React-router" -->
### Code Splitting : react-loadable

```
yarn add react-loadable
```

![](images/js/687474703a2f2f7468656a616d65736b796c652e636f6d2f696d672f72656163742d6c6f616461626c652d6865616465722e706e67.png)

--
<!-- .slide: data-title="React + Redux + React-router" -->
### Code Splitting : react-loadable

```
const AsyncHome = Loadable({
  loader: () => import("./containers/Home"),
  loading: MyLoadingComponent
});

const MyLoadingComponent = ({isLoading, error}) => {
  // Handle the loading state
  if (isLoading) {
    return <div>Loading...</div>;
  }
  // Handle the error state
  else if (error) {
    return <div>Sorry, there was a problem loading the page.</div>;
  }
  else {
    return null;
  }
};
```

--
<!-- .slide: data-title="React + Redux + React-router" -->
### HOC avec Redux

```js
// before
export default connect(mapStateToProps)(Something)

// after
import { withRouter } from 'react-router-dom'
export default withRouter(connect(mapStateToProps)(Something))
```

--
<!-- .slide: data-title="React + Redux + React-router" -->
### State avec Redux

```
yarn add react-router-redux@next history
```

history + store (redux) → react-router-redux → enhanced history → react-router

--
<!-- .slide: data-title="React + Redux + React-router" -->
### State avec Redux : point d'entrée

```
// index.js
import React from 'react'
import { render } from 'react-dom'
import { createStore } from 'redux'
import todoApp from './reducers'
import Root from './components/Root'

let store = createStore(todoApp)

render(
  <Root store={store} />,
  document.getElementById('root')
)
```

<!-- .element: class="fragment current-visible current-visible-only" -->
```
// index.js
import React from 'react'
import { render } from 'react-dom'
import { createStore, combineReducers, applyMiddleware } from 'redux'
import createHistory from 'history/createBrowserHistory'
import { routerReducer, routerMiddleware } from 'react-router-redux'
import { Route } from 'react-router'
import todoApp from './reducers'
import Root from './components/Root'

// Create a history of your choosing (we're using a browser history in this case)
const history = createHistory()

// Build the middleware for intercepting and dispatching navigation actions
const middleware = routerMiddleware(history)

// Add the reducer to your store on the `router` key
// Also apply our middleware for navigating
const store = createStore(
  combineReducers({
    todoApp,
    router: routerReducer
  }),
  applyMiddleware(middleware)
)

render(
  <Root store={store} history={history} />,
  document.getElementById('root')
)
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React + Redux + React-router" -->
### State avec Redux : routing

```
// components/Root.js
import React from 'react'
import PropTypes from 'prop-types'
import { Provider } from 'react-redux'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import App from './App'

const Root = ({ store }) => (
  <Provider store={store}>
    <Router>
      <Route path="/:filter?" component={App} />
    </Router>
  </Provider>
)

Root.propTypes = {
  store: PropTypes.object.isRequired
}

export default Root
```
<!-- .element: class="fragment current-visible current-visible-only" -->

```
// components/Root.js
import React from 'react'
import PropTypes from 'prop-types'
import { Provider } from 'react-redux'
import { Route } from 'react-router-dom'
import { ConnectedRouter as Router, push } from 'react-router-redux'
import App from './App'

const Root = ({ store, history }) => (
  <Provider store={store}>
    <Router history={history}>
      <Route path="/:filter?" component={App} />
    </Router>
  </Provider>
)

Root.propTypes = {
  store: PropTypes.object.isRequired,
  history: PropTypes.object.isRequired
}

export default Root
```
<!-- .element: class="fragment current-visible current-visible-only" -->

--
<!-- .slide: data-title="React + Redux + React-router" -->
### API react-router-redux

- `store.dispatch(...)` :
  + `push` : Pushes a new location to history, becoming the current location.
  + `replace` : Replaces the current location in history.
  + `go` : Moves backwards or forwards a relative number of locations in history.
  + `goForward` : Moves forward one location. Equivalent to go(1)
  + `goBack` : Moves backwards one location. Equivalent to go(-1)


###### _TP : Routing avec React Router_
<!-- .element: class="fragment" -->

---

## React Server Side Rendering

--
<!-- .slide: data-title="React Server Side Rendering" -->
### NodeJS

```
import { createServer } from 'http'
import React from 'react'
import ReactDOMServer from 'react-dom/server'
import { StaticRouter } from 'react-router'

createServer((req, res) => {

  // This context object contains the results of the render
  const context = {}

  const html = ReactDOMServer.renderToString(
    <StaticRouter location={req.url} context={context}>
      <App/>
    </StaticRouter>
  )

  // context.url will contain the URL to redirect to if a <Redirect> was used
  if (context.url) {
    res.writeHead(302, {
      Location: context.url
    })
    res.end()
  } else {
    res.write(html)
    res.end()
  }
}).listen(3000)
```

--
<!-- .slide: data-title="React Server Side Rendering" -->
### React-PHP-V8Js

PHP avec ReactBundle

```bash
composer require limenius/react-bundle
```

```php
// app/AppKernel.php
// ...
class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = array(
            // ...
            new Limenius\ReactBundle\LimeniusReactBundle(),
        );
        // ...
    }
    // ...
}
```

--
<!-- .slide: data-title="React Server Side Rendering" -->
### React-PHP-V8Js

PHP avec ReactBundle

```php
/**
 * @Route("/redux/", name="homepage_redux")
 */
public function homeReduxAction(Request $request)
{
  $serializer = $this->get('serializer');
  return $this->render('recipe-redux/home.html.twig', [
    // We pass an array as props
    'initialState' => $serializer->normalize(
      ['recipes' => $this->get('recipes.repository.recipe')->findAll(),
    ])
  ]);
}
/**
 * @Route("/redux/recipe/{id}", name="recipe_redux")
 */
public function recipeReduxAction($id, Request $request)
{
  $serializer = $this->get('serializer');
  if (!$recipe = $this->get('recipes.repository.recipe')->find($id)) {
    throw $this->createNotFoundException('The recipe does not exist');
  }
  return $this->render('recipe-redux/recipe.html.twig', [
    // A JSON string also works
    'initialState' => $serializer->serialize(
      ['recipe' => $recipe,], 'json')
  ]);
}
```

```twig
{{ redux_store('MySharedReduxStore', initialState ) }}
{{ react_component('RecipesApp') }}
```

--
<!-- .slide: data-title="React Server Side Rendering" -->
### React-PHP-V8Js

JS avec ReactBundle

```bash
npm install react-on-rails
```

```
//index.js
import ReactOnRails from 'react-on-rails';
import RecipesApp from './RecipesAppServer';
import configureStore from './store/configureStore';

ReactOnRails.registerStore({ configureStore });
ReactOnRails.register({ RecipesApp });

//RecipesApp.js
const store = ReactOnRails.getStore('MySharedReduxStore');

return (
  <Provider store={store}>
    <Scorecard />
  </Provider>
);
```
