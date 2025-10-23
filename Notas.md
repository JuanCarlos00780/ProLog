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
```

### Expresiones anidadas como argumentos
```lisp
;; Se evalúa la función de cada paréntesis
(+ (+ 3 4) (+ 5 6) (+ 8 9))
;; ---> 35
```
### Definición de funciones con defun
```lisp
(defun sumas ()
    (+ (+ 3 4) (+ 5 6) (+ 8 9))
)
```
### Carga de Funciones
Para cargar funciones en el top-level se usa la funcion load:
```lisp
[1]> (load "funcion.lsp")
```
### Operaciones aritmeticas 
Suma: (+ x y z)
Resta: (- x y)
Multiplicación: (* x y)
División: (/ x y)

## Argumentos y recursividad
### Funciones con argumentos
```lisp
(defun cuadrado (x)
    (* x x)
)
```
### Factorial (Recursivo)
```lisp
(defun factorial (x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))
    )
)
```
Ejemplo de factorial de 3
```lisp
factorial(3)
    3 * factorial(2)    → 3 * 2 = 6
        2 * factorial(1) → 2 * 1 = 2
            1 * factorial(0) → 1
```

## Manipulación de listas
### Car - Primer elemento
```lisp
(car '(1 2 3))
;; Salida: 1
```
### cdr - Cola de la lista
```lisp
(cdr '(1 2 3))
;; Salida: (2 3)
```
### Combinaciones
Las operaciones se ejecutan de derecha a izquierda
```lisp
(cadr '(1 2 3))
;; Primero: cdr → (2 3)
;; Luego: car → 2
;; Salida: 2
```