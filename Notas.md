# Notas

## Temas Cubiertos
- Funciones y paréntesis
- Carga de funciones
- Operaciones aritméticas
- Argumentos en funciones
- Recursividad
- Quotes, car y cdr

## Funciones y Paréntesis

### Todo se maneja como función
```lisp
;; 'x' en este contexto es una función que recibe un número indefinido de argumentos
(+ 4 5 6 4)
;; ---> 19

### Expresiones anidadas como argumentos
```lisp
;; Se evalúa la función de cada paréntesis
(+ (+ 3 4) (+ 5 6) (+ 8 9))
;; ---> 35