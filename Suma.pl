lista([1, 2, 3, 4, 5]).
sumar([],0).
sumar([],R):- R = 0.
sumar([X|Y],R):-sumar(Y, R1), R is R1 + X.

%1. sumar([1, 2, 3, 4, 5], R) :- sumar([2, 3, 4, 5], R1), R is R1 + X.

%2. sumar([2, 3, 4, 5], R) :- sumar([3, 4, 5], R1), R is R1 + X.

%3. sumar([3, 4, 5], R) :- sumar([4, 5], R1), R is R1 + X.

%4. sumar([4, 5], R) :- sumar([5], R1), R is R1 + X.

%5. sumar([5], R) :- sumar([], R1), R is R1 + X.

%6. sumar([], 0) :- R = 0;

%7. sumar([5], 5) :- sumar([], 0), R is 0 + 5.

%8. sumar([4, 5], 9) :- sumar([5], 5), R is 5 + 4.

%9. sumar([3, 4, 5], 12) :- sumar([4, 5], 9), R is 9 + 3.

%10. sumar([2, 3, 4, 5], 14) :- sumar([3, 4, 5], 12), R is 12 + 2.

%1. sumar([1, 2, 3, 4, 5], 15) :- sumar([2, 3, 4, 5], 14), R is 14 + 1.
