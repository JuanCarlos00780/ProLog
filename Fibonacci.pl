
% fibonacci


fibonacci(0, 0).
fibonacci(1, 1).

fibonacci(N, F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1 + F2.

% Division con restas

% La condición de parada es que el dividendo sea menor que el divisor (no se puede dividir mas) 
division(Dividendo, Divisor, 0) :-
    Dividendo < Divisor.

division(Dividendo, Divisor, Cociente) :-
    Dividendo >= Divisor,
    NuevoDividendo is Dividendo - Divisor,
    division(NuevoDividendo, Divisor, RestoCociente),
    Cociente is RestoCociente + 1.




% Potencia con sumas

% Hace multiplicaciones con sumas
multiplicar(_, 0, 0).
multiplicar(X, Y, R) :-
    Y > 0,
    Y1 is Y - 1,
    multiplicar(X, Y1, R1),
    R is R1 + X.

% La potencia a partir de las multiplicaciones
potencia(_, 0, 1).
potencia(Base, Exp, R) :-
    Exp > 0,
    Exp1 is Exp - 1,
    potencia(Base, Exp1, R1),
    multiplicar(Base, R1, R).
