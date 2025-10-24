
* La Tierra es un planeta.

Constantes de Individuo: Tierra

Propiedades (Predicados Unarios): planeta(tierra)

Dominio del discurso: Tierra

***

* La Luna no es un planeta.

Constantes de Individuo: Luna

Propiedades (Predicados Unarios): ¬planeta(luna)

Dominio del discurso: Luna

***

* La Luna es un satélite.

Constantes de Individuo: Luna

Propiedades (Predicados Unarios): satelite(luna)

Dominio del discurso: Luna

***

* La Tierra gira alrededor del Sol.

Constantes de Individuo: Tierra, Sol

Relaciones (Predicados N-arios): gira_alrededor(tierra, sol)

Dominio del discurso: Tierra, Sol

***

* Todo planeta es un satélite.

Variables de Individuo: planetas 

Cuantificadores: Universal(∀)

Propiedades: Satelite 

Relaciones (Predicados N-arios): ∀xplaneta(x) ⟶ satelite(x)

Dominio del discurso: Planetas

***

* Todo planeta gira alrededor del Sol.

Constantes de Individuo: Sol

Variables de Individuo: planetas 

Cuantificadores: Universal(∀)

Propiedades: gira_alrededor(x, y)

Relaciones (Predicados N-arios): ∀xplaneta(x) ⟶ gira_alrededor(x, sol)

Dominio del discurso: Planetas, Sol

***

* Algún planeta gira alrededor de la Luna.

Constantes de Individuo: Luna

Variables de Individuo: planetas 

Cuantificadores: Existencial(∃)

Propiedades: gira_alrededor(x, y)

Relaciones (Predicados N-arios): ∃xplaneta(x) ^ gira_alrededor(x, luna)

Dominio del discurso: Planetas, Luna

***

* Hay por lo menos un satélite.

Variables de Individuo: x

Cuantificadores: Existencial(∃)

Propiedades: satelite

Relaciones (Predicados N-arios): ∃xsatelite(x)

***


* Todos los perros del vecindario muerden a algún cartero.

Variables de Individuo: Perros, Cartero

Cuantificadores: Universal(∀), Existencial(∃)

Propiedades: muerden, Cartero

Relaciones (Predicados N-arios): ∀xperros(x) ⟶ ∃ycartero(y) ^ muerden(x, y)

Dominio del discurso: Perros, Cartero


***

* Hay un cartero al que lo muerden todos los perros

Variables de Individuo: x, y

Cuantificadores: Universal(∀), Existencial unico (∃!)

Propiedades: muerden, Cartero, perro

Relaciones (Predicados N-arios): ∃Cartero(x) ^ ∀(perro(y) ⟶ muerde(y, x))

Dominio del discurso: Perros, Cartero

***

* Todos los carteros son mordidos por algún perro.

Variables de Individuo: x, y

Cuantificadores: Universal(∀), Existencial

Propiedades: mordido, Cartero, perro

Relaciones (Predicados N-arios): ∀Cartero(x) ⟶ ∃y(perro(y) ^ mordido(x, y))

Dominio del discurso: Perros, Cartero

***

* Hay un perro que muerde a todos los carteros

Variables de Individuo: x, y

Cuantificadores: Universal(∀), Existencial(∃)

Propiedades: muerde, Cartero, perro

Relaciones (Predicados N-arios): ∃x(perro(x) ^ ∀y(Cartero(y) ⟶ muerde(x, y)))

Dominio del discurso: Perros, Cartero


***

* Todos los perros que asustan a algún cartero, lo muerden

Variables de Individuo: x, y

Cuantificadores: Universal(∀), Existencial(∃)

Propiedades: asusta, Cartero, perro, muerde

Relaciones (Predicados N-arios): ∀x(perro(x) ^ ∃y(cartero(y) ^ asusta(x, y))) ⟶ muerde(x, y)

Dominio del discurso: Perros, Cartero

***

* Hay un perro que muerde a todos los perros que muerden a algún cartero

Variables de Individuo: x, y, z

Cuantificadores: Universal(∀), Existencial(∃)

Propiedades: muerde, perro, cartero

Relaciones (Predicados N-arios): ∃x(perro(x) ^ ∀y(perros(y) ^ ∃z(cartero(z) ^ muerde(y, z)) ⟶ muerde(x, y)))

Dominio del discurso: Perros, Cartero

***

* Hay un solo perro que se muerde a sí mismo

Variables de Individuo: x

Propiedades: muerde, perro

Relaciones (Predicados N-arios): ∃!x(perro(x) ^ muerde(x, x))

Dominio del discurso: Perros

***
