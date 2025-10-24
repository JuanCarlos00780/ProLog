
%Mujeres
mujer(Lorena).
mujer(Maria).
mujer(Anabel).
mujer(Areli).
mujer(Josefina).
mujer(Yulisa).
mujer(Esther).
mujer(Jazmin).
mujer(Gabriela).

%Hombres
hombre(Juan).
hombre(Carlos).
hombre(Gerardo).
hombre(Manuel).
hombre(Henry).
hombre(JuanCarlos).
hombre(Erick).
hombre(Jose).


madre(Esther).
madre(Anabel).
madre(Lorena).
madre(Maria).
madre(Gabriela).

padre(JuanCarlos).
padre(Gerardo).
padre(Manuel).

% madre_de(Madre, Hijo_o_Hija)
madre_de(Lorena, Areli).
madre_de(Lorena, Juan).  
madre_de(Anabel, Yulisa).
madre_de(Anabel, Josefina).
madre_de(Anabel, Carlos).
madre_de(Maria, Henry).
madre_de(Maria, Jose).  
madre_de(Gabriela, Erick). 
madre_de(Esther, Lorena). 
madre_de(Esther, Anabel). 
madre_de(Esther, Maria). 
madre_de(Esther, Gabriela). 

% padre_de(Padre, Hijo_o_Hija)
padre_de(JuanCarlos, Juan).
padre_de(JuanCarlos, Areli).
padre_de(Gerardo, Yulisa).
padre_de(Gerardo, Josefina).
padre_de(Gerardo, Carlos).
padre_de(Manuel, Lorena).
padre_de(Manuel, Anabel).
padre_de(Manuel, Gabriela).
padre_de(Manuel, Maria).


%reglas

hermanos(X, Y) :- madre_de(P, X), madre_de(P, Y), X \== Y.

abuelo_de(X, Z) :- padre_de(X, Y), padre_de(Y, Z).

abuela_de(X, Z) :- madre_de(X, Y), madre_de(Y, Z).

primos(X, Y) :-( padre_de(P, X), padre_de(Q, Y), hermanos(P, Q)
                ; madre_de(R, X), madre_de(S, Y), hermanos(R, S)).
