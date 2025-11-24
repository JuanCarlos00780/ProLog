% Acertijo
% Cinco investigadores trabajan en un laboratorio de biología molecular.
% Cada uno tiene:
% • una especialidad distinta,
% • un horario distinto,
% • una bebida que prefiere,
% • un equipo de laboratorio distinto,
% • y un país de origen diferente.

% Investigadores
investigadores([ana, bruno, carlos, diana, elisa]).

% Atributos
especialidades([genetica, microbiologia, bioquimica, inmunologia, neurociencia]).
horarios([6, 8, 10, 12, 14]).
bebidas([cafe, te, jugo, mate, agua]).
equipos([microscopio, centrifuga, pcr, espectrometro, incubadora]).
paises([mexico, chile, espana, argentina, peru]).

solucion(Solucion) :-
    % Estructura de la solución: [Nombre, Especialidad, Horario, Bebida, Equipo, Pais]
    Solucion = [
        [ana, AnaEspecialidad, AnaHorario, AnaBebida, AnaEquipo, AnaPais],
        [bruno, BrunoEspecialidad, BrunoHorario, BrunoBebida, BrunoEquipo, BrunoPais],
        [carlos, CarlosEspecialidad, CarlosHorario, CarlosBebida, CarlosEquipo, CarlosPais],
        [diana, DianaEspecialidad, DianaHorario, DianaBebida, DianaEquipo, DianaPais],
        [elisa, ElisaEspecialidad, ElisaHorario, ElisaBebida, ElisaEquipo, ElisaPais]
    ],
    
    especialidades(EspecialidadesLista),
    horarios(HorariosLista),
    bebidas(BebidasLista),
    equipos(EquiposLista),
    paises(PaisesLista),
    
    
    asignar_atributos(Solucion, 1, EspecialidadesLista),
    asignar_atributos(Solucion, 2, HorariosLista),
    asignar_atributos(Solucion, 3, BebidasLista),
    asignar_atributos(Solucion, 4, EquiposLista),
    asignar_atributos(Solucion, 5, PaisesLista),
    
    % Se aplican las reglas al acertijo
    regla1(Solucion),
    regla2(Solucion),
    regla3(Solucion),
    regla4(Solucion),
    regla5(Solucion),
    regla6(Solucion),
    regla7(Solucion),
    regla8(Solucion),
    regla9(Solucion),
    regla10(Solucion),
    regla11(Solucion),
    regla12(Solucion),
    regla13(Solucion),
    regla14(Solucion),
    regla15(Solucion),
    regla16(Solucion),
    regla17(Solucion),
    regla18(Solucion),
    regla19(Solucion),
    regla20(Solucion).


asignar_atributos([], _, _).
asignar_atributos([Persona|Resto], IndiceAtributo, Atributos) :-
    nth1(IndiceAtributo, Persona, Atributo),
    member(Atributo, Atributos),
    asignar_atributos(Resto, IndiceAtributo, Atributos),
    todos_diferentes([Atributo | RestoAtributos]),
    findall(A, (member(P, Resto), nth1(IndiceAtributo, P, A)), RestoAtributos).


todos_diferentes([]).
todos_diferentes([X|Xs]) :-
    \+ member(X, Xs),
    todos_diferentes(Xs).

% Busqueda de persona por atributo
persona_con_especialidad(Solucion, Especialidad, Persona) :-
    member(Persona, Solucion),
    Persona = [_, Especialidad, _, _, _, _].

persona_con_horario(Solucion, Horario, Persona) :-
    member(Persona, Solucion),
    Persona = [_, _, Horario, _, _, _].

persona_con_bebida(Solucion, Bebida, Persona) :-
    member(Persona, Solucion),
    Persona = [_, _, _, Bebida, _, _].

persona_con_equipo(Solucion, Equipo, Persona) :-
    member(Persona, Solucion),
    Persona = [_, _, _, _, Equipo, _].

persona_con_pais(Solucion, Pais, Persona) :-
    member(Persona, Solucion),
    Persona = [_, _, _, _, _, Pais].

% REGLAS

% 1. El investigador de Genética llega a las 6am.
regla1(Solucion) :-
    persona_con_especialidad(Solucion, genetica, Persona),
    Persona = [_, _, 6, _, _, _].

% 2. Ana no trabaja ni en Genética ni en Neurociencia.
regla2(Solucion) :-
    member([ana, AnaEspecialidad, _, _, _, _], Solucion),
    AnaEspecialidad \= genetica,
    AnaEspecialidad \= neurociencia.

% 3. La persona que usa la Centrífuga bebe Té.
regla3(Solucion) :-
    persona_con_equipo(Solucion, centrifuga, Persona),
    Persona = [_, _, _, te, _, _].

% 4. La investigadora de Perú llega a las 10am.
regla4(Solucion) :-
    persona_con_pais(Solucion, peru, Persona),
    Persona = [_, _, 10, _, _, _].

% 5. Carlos usa el Espectrómetro.
regla5(Solucion) :-
    member([carlos, _, _, _, espectrometro, _], Solucion).

% 6. Quien bebe Café llega dos horas antes que quien bebe Jugo.
regla6(Solucion) :-
    persona_con_bebida(Solucion, cafe, PersonaCafe),
    persona_con_bebida(Solucion, jugo, PersonaJugo),
    PersonaCafe = [_, _, HorarioCafe, _, _, _],
    PersonaJugo = [_, _, HorarioJugo, _, _, _],
    HorarioJugo is HorarioCafe + 2.

% 7. La persona que trabaja en Inmunología usa PCR.
regla7(Solucion) :-
    persona_con_especialidad(Solucion, inmunologia, Persona),
    Persona = [_, _, _, _, pcr, _].

% 8. La especialista en Bioquímica es de Chile.
regla8(Solucion) :-
    persona_con_especialidad(Solucion, bioquimica, Persona),
    Persona = [_, _, _, _, _, chile].

% 9. La Incubadora es utilizada por alguien que llega a las 14pm.
regla9(Solucion) :-
    persona_con_equipo(Solucion, incubadora, Persona),
    Persona = [_, _, 14, _, _, _].

% 10. El investigador de Argentina bebe Mate.
regla10(Solucion) :-
    persona_con_pais(Solucion, argentina, Persona),
    Persona = [_, _, _, mate, _, _].

% 11. Elisa no bebe Té ni Café.
regla11(Solucion) :-
    member([elisa, _, _, ElisaBebida, _, _], Solucion),
    ElisaBebida \= te,
    ElisaBebida \= cafe.

% 12. Diana trabaja en Microbiología.
regla12(Solucion) :-
    member([diana, microbiologia, _, _, _, _], Solucion).

% 13. El que llega a las 8am usa el Microscopio.
regla13(Solucion) :-
    persona_con_horario(Solucion, 8, Persona),
    Persona = [_, _, _, _, microscopio, _].

% 14. Bruno no es de México.
regla14(Solucion) :-
    member([bruno, _, _, _, _, BrunoPais], Solucion),
    BrunoPais \= mexico.

% 15. La persona de España trabaja en Neurociencia.
regla15(Solucion) :-
    persona_con_pais(Solucion, espana, Persona),
    Persona = [_, neurociencia, _, _, _, _].

% 16. El usuario del equipo PCR llega después que el especialista en Microbiología.
regla16(Solucion) :-
    persona_con_equipo(Solucion, pcr, PersonaPCR),
    persona_con_especialidad(Solucion, microbiologia, PersonaMicro),
    PersonaPCR = [_, _, HorarioPCR, _, _, _],
    PersonaMicro = [_, _, HorarioMicro, _, _, _],
    HorarioPCR > HorarioMicro.

% 17. El de México usa el equipo que NO es Microscopio ni Incubadora.
regla17(Solucion) :-
    persona_con_pais(Solucion, mexico, Persona),
    Persona = [_, _, _, _, EquipoMexico, _],
    EquipoMexico \= microscopio,
    EquipoMexico \= incubadora.

% 18. La persona que bebe Agua no usa ni PCR ni Espectrómetro.
regla18(Solucion) :-
    persona_con_bebida(Solucion, agua, Persona),
    Persona = [_, _, _, _, EquipoAgua, _],
    EquipoAgua \= pcr,
    EquipoAgua \= espectrometro.

% 19. El especialista en Neurociencia llega después de la persona que bebe Jugo.
regla19(Solucion) :-
    persona_con_especialidad(Solucion, neurociencia, PersonaNeuro),
    persona_con_bebida(Solucion, jugo, PersonaJugo),
    PersonaNeuro = [_, _, HorarioNeuro, _, _, _],
    PersonaJugo = [_, _, HorarioJugo, _, _, _],
    HorarioNeuro > HorarioJugo.

% 20. El de Perú NO bebe Agua.
regla20(Solucion) :-
    persona_con_pais(Solucion, peru, Persona),
    Persona = [_, _, _, BebidaPeru, _, _],
    BebidaPeru \= agua.

% Resultados:
mostrar_resultados(Solucion) :-
    nl, write('=== SOLUCIÓN DEL ACERTIJO ==='), nl, nl,
    write('RESPUESTAS A LAS PREGUNTAS:'), nl, nl,
    
    write('1. ¿A qué hora llega cada investigador?'), nl,
    mostrar_horarios(Solucion), nl,
    
    write('2. ¿Qué especialidad tiene cada uno?'), nl,
    mostrar_especialidades(Solucion), nl,
    
    write('3. ¿Qué bebida prefiere cada investigador?'), nl,
    mostrar_bebidas(Solucion), nl,
    
    write('4. ¿Qué equipo usa cada quien?'), nl,
    mostrar_equipos(Solucion), nl,
    
    write('5. ¿De qué país es cada uno?'), nl,
    mostrar_paises(Solucion), nl,
    
    write('=== TABLA COMPLETA ==='), nl,
    mostrar_tabla_completa(Solucion).

mostrar_horarios(Solucion) :-
    forall(member([Nombre, _, Horario, _, _, _], Solucion),
           format('   ~w llega a las ~w:00~n', [Nombre, Horario])).

mostrar_especialidades(Solucion) :-
    forall(member([Nombre, Especialidad, _, _, _, _], Solucion),
           format('   ~w: ~w~n', [Nombre, Especialidad])).

mostrar_bebidas(Solucion) :-
    forall(member([Nombre, _, _, Bebida, _, _], Solucion),
           format('   ~w: ~w~n', [Nombre, Bebida])).

mostrar_equipos(Solucion) :-
    forall(member([Nombre, _, _, _, Equipo, _], Solucion),
           format('   ~w: ~w~n', [Nombre, Equipo])).

mostrar_paises(Solucion) :-
    forall(member([Nombre, _, _, _, _, Pais], Solucion),
           format('   ~w: ~w~n', [Nombre, Pais])).

mostrar_tabla_completa(Solucion) :-
    format('~t~w~t~15+~t~w~t~15+~t~w~t~10+~t~w~t~10+~t~w~t~15+~t~w~t~12+~n', 
           ['Nombre', 'Especialidad', 'Horario', 'Bebida', 'Equipo', 'País']),
    format('~t~`=~t~75|~n'),
    forall(member([Nombre, Especialidad, Horario, Bebida, Equipo, Pais], Solucion),
           format('~t~w~t~15+~t~w~t~15+~t~w~t~10+~t~w~t~10+~t~w~t~15+~t~w~t~12+~n', 
                  [Nombre, Especialidad, Horario, Bebida, Equipo, Pais])).


resolver :-
    solucion(S),
    mostrar_resultados(S).  