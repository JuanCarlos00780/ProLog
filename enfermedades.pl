:- dynamic sintoma_usuario/1.

% ==========================================================
% MOTOR PRINCIPAL
% ==========================================================
eliza :- 
    retractall(sintoma_usuario(_)),
    writeln('Hola, soy Eliza. Tu ChatBot.'),
    writeln('Ingresa tu consulta (minusculas y sin punto al final):'),
    readln(Input),
    eliza(Input), !.

eliza(Input) :- 
    (Input == [adios]; Input == [chau]; Input == [bye]),
    writeln('Adios. Se han borrado los sintomas. ¡Cuidate!'),
    retractall(sintoma_usuario(_)), !.

eliza(Input) :-
    template(Stim, Resp, IndStim),
    match(Stim, Input),
    replace0(IndStim, Input, 0, Resp, R),
    writeln(R),
    readln(Input1),
    eliza(Input1), !.

% ==========================================================
% 1. TEMPLATES (PATRONES DE CONVERSACION)
% ==========================================================

% --- SOCIAL Y PERSONALIDAD ---
template([hola, mi, nombre, es, s(_),], ['Hola', 0, 'Como', estas, tu, '?'], [4]).
template([hola, _], ['Hola', 'como', estas, tu, '?'], []).
template([como, estas, tu, '?'], [yo, estoy, bien, gracias, por, preguntar, '.'], []).

% --- GESTIÓN MÉDICA ---
template([tengo, s(_), y, s(_)], [flagAddDosSintomas], [1, 3]).
template([tengo, s(_)], [flagAddSintoma], [1]).
template([siento, s(_)], [flagAddSintoma], [1]).
template([que, enfermedades, podria, tener], [flagSugerirDiagnostico], []).
template([que, probabilidad, tengo, de, s(_)], [flagCalcularProbabilidad], [4]).
template([reporte, completo], [flagReporte], []).
template([limpiar, sintomas], [flagClearSintomas], []).
template([nuevo, paciente], [flagClearSintomas], []).
template([como, se, contagia, la, s(_)], [flagContagio], [4]).
template([como, se, contagia, el, s(_)], [flagContagio], [4]).
template([que, doctor, trata, la, s(_)], [flagEspecialista], [4]).
template([que, doctor, trata, el, s(_)], [flagEspecialista], [4]).
template([que, tratamiento, tiene, la, s(_)], [flagMedicina], [4]).

% --- FAMILIA ---
template([s(_), es, hijo, de, s(_)], [flagFamilia, hijo], [0, 4]).
template([s(_), es, padre, de, s(_)], [flagFamilia, padre], [0, 4]).
template([s(_), es, madre, de, s(_)], [flagFamilia, madre], [0, 4]).
template([s(_), es, hermano, de, s(_)], [flagFamilia, hermano], [0, 4]).
template([s(_), es, abuelo, de, s(_)], [flagFamilia, abuelo], [0, 4]).
template([quien, es, tio, de, s(_)], [flagFamilia, tio], [4]).
template([quien, es, primo, de, s(_)], [flagFamilia, primo], [4]).
template([cuantos, hombres, hay, en, la, familia], [flagContarHombres], []).
template([cuantas, mujeres, hay, en, la, familia], [flagContarMujeres], []).
template([quien, es, s(_), '?'], [flagQuienEs], [2]).


% --- GAME OF THRONES ---
template([cual, es, el, lema, de, la, casa, s(_)], [flagGOT, lema], [7]).
template([de, que, casa, es, s(_)], [flagGOT, casa_de], [4]).
template([quien, mato, a, s(_)], [flagGOT, asesino], [3]).

template(_, ['Por', favor, explicame, un, poco, mas, '.'], []).

% ==========================================================
% 2. BASE DE DATOS MÉDICA (SÍNTOMAS COMPLETOS)
% ==========================================================

% DENGUE (11 sintomas)
tiene_sintoma(dengue, fiebre_alta). tiene_sintoma(dengue, dolor_retroocular).
tiene_sintoma(dengue, dolor_muscular). tiene_sintoma(dengue, dolor_de_cabeza).
tiene_sintoma(dengue, manchas_rojas). tiene_sintoma(dengue, nauseas).
tiene_sintoma(dengue, vomitos). tiene_sintoma(dengue, fatiga).
tiene_sintoma(dengue, perdida_de_apetito). tiene_sintoma(dengue, sangrado_leve).
tiene_sintoma(dengue, escalofrios).

% CHIKUNGUNA (9 sintomas)
tiene_sintoma(chikunguna, fiebre_alta). tiene_sintoma(chikunguna, dolor_articular_intenso).
tiene_sintoma(chikunguna, dolor_muscular). tiene_sintoma(chikunguna, dolor_de_cabeza).
tiene_sintoma(chikunguna, erupcion_cutanea). tiene_sintoma(chikunguna, fatiga_extrema).
tiene_sintoma(chikunguna, nauseas). tiene_sintoma(chikunguna, malestar_general).
tiene_sintoma(chikunguna, inflamacion_articular).

% ZIKA (9 sintomas)
tiene_sintoma(zika, fiebre_leve). tiene_sintoma(zika, erupcion_con_picazon).
tiene_sintoma(zika, dolor_muscular). tiene_sintoma(zika, dolor_articular).
tiene_sintoma(zika, dolor_retroocular). tiene_sintoma(zika, dolor_de_cabeza).
tiene_sintoma(zika, fatiga). tiene_sintoma(zika, malestar_general).
tiene_sintoma(zika, conjuntivitis_no_purulenta).

% DIARREA (4 sintomas)
tiene_sintoma(diarrea, heces_liquidas). tiene_sintoma(diarrea, urgencia_para_defecar).
tiene_sintoma(diarrea, dolor_abdominal). tiene_sintoma(diarrea, frecuencia_deposiciones).

% GASTROENTERITIS (8 sintomas)
tiene_sintoma(gastroenteritis, heces_liquidas). tiene_sintoma(gastroenteritis, frecuencia_deposiciones).
tiene_sintoma(gastroenteritis, urgencia_para_defecar). tiene_sintoma(gastroenteritis, dolor_abdominal).
tiene_sintoma(gastroenteritis, nauseas). tiene_sintoma(gastroenteritis, vomitos).
tiene_sintoma(gastroenteritis, fiebre). tiene_sintoma(gastroenteritis, malestar_general).

% DIABETES MELLITUS
tiene_sintoma(diabetes, fatiga). tiene_sintoma(diabetes, aumento_de_apetito).
tiene_sintoma(diabetes, perdida_de_peso). tiene_sintoma(diabetes, sed_excesiva).
tiene_sintoma(diabetes, miccion_frecuente). tiene_sintoma(diabetes, vision_borrosa).

% HIPERTIROIDISMO
tiene_sintoma(hipertiroidismo, fatiga). tiene_sintoma(hipertiroidismo, aumento_de_apetito).
tiene_sintoma(hipertiroidismo, perdida_de_peso). tiene_sintoma(hipertiroidismo, intolerancia_al_calor).
tiene_sintoma(hipertiroidismo, bocio). tiene_sintoma(hipertiroidismo, temblor_en_manos).
tiene_sintoma(hipertiroidismo, nerviosismo).

% CONTAGIO
contagiode(dengue, 'Picadura de mosquito Aedes aegypti.').
contagiode(zika, 'Picadura de mosquito o transmision sexual.').
contagiode(chikunguna, 'Picadura de mosquitos Aedes infectados.').
contagiode(diarrea, 'Agua o alimentos contaminados (fecal-oral).').
contagiode(gastroenteritis, 'Contacto con infectados o agua contaminada.').
contagiode(diabetes, 'No es contagiosa. Es genetica o por estilo de vida.').
contagiode(hipertiroidismo, 'No es contagioso. Es un trastorno de la tiroides.').

% MEDICINA Y ESPECIALISTA
medicinade('Paracetamol e hidratacion. No aspirinas.', dengue).
medicinade('Reposo, liquidos y paracetamol para fiebre/dolor. Evitar aspirinas hasta descartar dengue.', zika).
medicinade('Reposo absoluto, hidratacion abundante y paracetamol para el dolor articular.', chikunguna).
medicinade('Hidratacion constante y dieta blanda (arroz, manzana, pollo hervido).', diarrea).
medicinade('Reposo gastrico, hidratacion con suero oral y dieta blanda progresiva.', gastroenteritis).
medicinade('Insulina o Metformina y dieta.', diabetes).
medicinade('Antitiroideos o yodo radiactivo.', hipertiroidismo).

especialista_de(infectologo, dengue). 
especialista__de(infectologo, zika). 
especialista_de(infectologo, chikunguna).
especialista_de(gastroenterologo, diarrea). 
especialista_de(gastroenterologo, gastroenteritis).
especialista_de(endocrinologo, diabetes). 
especialista_de(endocrinologo, hipertiroidismo).

% ==========================================================
% 3. BASE DE DATOS SOCIAL (FAMILIA Y GOT)
% ==========================================================

% FAMILIA
madre_de(esther, lorena). madre_de(esther, anabel). madre_de(esther, maria). madre_de(esther, gabriela).
madre_de(lorena, areli). madre_de(lorena, juan).
madre_de(anabel, yulisa). madre_de(anabel, josefina). madre_de(anabel, carlos).
padre_de(manuel, lorena). padre_de(manuel, anabel). padre_de(manuel, maria). padre_de(manuel, gabriela).
padre_de(juancarlos, areli). padre_de(juancarlos, juan).
padre_de(gerardo, yulisa). padre_de(gerardo, josefina). padre_de(gerardo, carlos).
hombre(manuel). hombre(juancarlos). hombre(gerardo). hombre(juan). hombre(carlos).
mujer(esther). mujer(lorena). mujer(anabel). mujer(maria). mujer(gabriela). mujer(areli). mujer(yulisa). mujer(josefina).

% GAME OF THRONES
lema(stark, 'Winter is Coming'). lema(lannister, 'Hear Me Roar'). lema(targaryen, 'Fire and Blood').
mato(daenerys, jon_snow). mato(joffrey, olena_tyrell).
casa(jon_snow, stark). casa(daenerys, targaryen). casa(tyrion, lannister).

% ==========================================================
% 4. LOGICA DE REGLAS E INFERENCIA
% ==========================================================

% Reglas Parentesco
hermano(X, Y) :- (padre_de(P, X), padre_de(P, Y) ; madre_de(M, X), madre_de(M, Y)), X \= Y.
hijo(X, Y) :- padre_de(Y, X); madre_de(Y, X).
abuelo(X, Z) :- (padre_de(X, Y) ; madre_de(X, Y)), (padre_de(Y, Z) ; madre_de(Y, Z)).
tio(X, Y) :- hermano(X, P), (padre_de(P, Y) ; madre_de(P, Y)).
primo(X, Y) :- (padre_de(P1, X) ; madre_de(M1, X)), (padre_de(P2, Y) ; madre_de(M2, Y)), hermano(P1, P2), X \= Y.

% ==========================================================
% 5. LÓGICA DE REEMPLAZO (FLAGS)
% ==========================================================

% REGISTRO
replace0([I], Input, _, [flagAddSintoma], R) :- nth0(I, Input, S), assertz(sintoma_usuario(S)), R = [registrado, S].
replace0([I, J], Input, _, [flagAddDosSintomas], R) :- nth0(I, Input, S1), nth0(J, Input, S2), assertz(sintoma_usuario(S1)), assertz(sintoma_usuario(S2)), R = [registrados, S1, y, S2].

% DIAGNÓSTICO
replace0([], _, _, [flagSugerirDiagnostico], R) :- findall(E, (sintoma_usuario(S), tiene_sintoma(E, S)), LT), sort(LT, P), R = [podrias, tener, P].
replace0([I], Input, _, [flagCalcularProbabilidad], R) :-
    nth0(I, Input, Enf), findall(S, tiene_sintoma(Enf, S), TS), length(TS, T),
    findall(S2, (tiene_sintoma(Enf, S2), sintoma_usuario(S2)), Conf), sort(Conf, U), length(U, C),
    (T > 0 -> Porc is (C / T) * 100 ; Porc is 0), format(atom(PStr), '~2f', [Porc]),
    (Porc =:= 100.00 -> medicinade(M, Enf), R = [diagnostico, definitivo, de, Enf, '.', tratamiento, ':', M]; R = [probabilidad, de, Enf, ':', PStr, '%']).
replace0([], _, _, [flagReporte], R) :- 
    findall(S, sintoma_usuario(S), Lista),
    (Lista \= [] -> 
        R = [resumen, de, tus, sintomas, actuales, son, ':', Lista] ; 
        R = [el, expediente, esta, vacio, ',', no, he, registrado, sintomas, aun]
    ).
replace0([], _, _, [flagClearSintomas], R) :- 
    retractall(sintoma_usuario(_)), 
    R = [memoria, limpia, '.', todos, los, sintomas, han, sido, borrados, '.', listo, para, un, nuevo, diagnostico].

% MÉDICO EXTRA
replace0([I], Input, _, [flagContagio], R) :- nth0(I, Input, E), (contagiode(E, Info) -> R = [Info]; R = [no, se]).
replace0([I], Input, _, [flagEspecialista], R) :- nth0(I, Input, E), (especialista_de(Esp, E) -> R = [ve, con, el, Esp]; R = [no, se]).
replace0([I], Input, _, [flagMedicina], R) :- nth0(I, Input, E), (medicinade(M, E) -> R = [tratamiento, ':', M]; R = [no, se]).

% FAMILIA FLAGS
replace0([I1, I2], Input, _, [flagFamilia, hijo], R) :- nth0(I1, Input, A), nth0(I2, Input, B), ((madre_de(B, A); padre_de(B, A)) -> R = [si, A, es, hijo, de, B]; R = [no]).
replace0([I1, I2], Input, _, [flagFamilia, padre], R) :- nth0(I1, Input, A), nth0(I2, Input, B), (padre_de(A, B) -> R = [si, A, es, padre, de, B]; R = [no]).
replace0([I1, I2], Input, _, [flagFamilia, madre], R) :- nth0(I1, Input, A), nth0(I2, Input, B), (madre_de(A, B) -> R = [si, A, es, madre, de, B]; R = [no]).
replace0([I1, I2], Input, _, [flagFamilia, hermano], R) :- nth0(I1, Input, A), nth0(I2, Input, B), (hermano(A, B) -> R = [si, A, es, hermano, de, B]; R = [no]).
replace0([I1, I2], Input, _, [flagFamilia, abuelo], R) :- nth0(I1, Input, A), nth0(I2, Input, B), (abuelo(A, B) -> R = [si, A, es, abuelo, de, B]; R = [no]).
replace0([I], Input, _, [flagFamilia, tio], R) :- nth0(I, Input, S), findall(T, tio(T, S), Tios), R = [tios, de, S, ':', Tios].
replace0([I], Input, _, [flagFamilia, primo], R) :- nth0(I, Input, S), findall(P, primo(P, S), Primos), R = [primos, de, S, ':', Primos].
% Lógica para contar géneros
replace0([], _, _, [flagContarHombres], R) :- 
    findall(H, hombre(H), L), length(L, N), 
    R = [hay, N, hombres, en, la, familia, son, ':', L].

replace0([], _, _, [flagContarMujeres], R) :- 
    findall(M, mujer(M), L), length(L, N), 
    R = [hay, N, mujeres, en, la, familia, son, ':', L].

% Lógica para "quien es X ?" (Biografía resumida)
replace0([I], Input, _, [flagQuienEs], R) :- 
    nth0(I, Input, P),
    (madre_de(Mad, P) -> M_inf = [hijo, de, Mad] ; M_inf = []),
    (padre_de(Pad, P) -> P_inf = [y, de, Pad] ; P_inf = []),
    findall(Hj, hijo(Hj, P), Hijos),
    findall(Hr, hermano(Hr, P), Hermanos),
    (Hijos \= [] -> H_msg = [padre_o_madre, de, Hijos] ; H_msg = [no, tiene, hijos]),
    R = [P, es, M_inf, P_inf, ',', H_msg, ',', hermano_de, Hermanos].

% Auxiliar para la biografía
hijo(H, P) :- madre_de(P, H); padre_de(P, H).

% GOT FLAGS
replace0([I], Input, _, [flagGOT, lema], R) :- nth0(I, Input, C), (lema(C, L) -> R = [lema, es, L]; R = [no, se]).
replace0([I], Input, _, [flagGOT, casa_de], R) :- nth0(I, Input, P), (casa(P, C) -> R = [casa, C]; R = [no, se]).
replace0([I], Input, _, [flagGOT, asesino], R) :- nth0(I, Input, V), (mato(A, V) -> R = [asesino, es, A]; R = [no, se]).

% REGLAS ESTÁNDAR
replace0([I|Index], Input, N, Resp, R):- length(Index, M), M =:= 0, nth0(I, Input, Atom), select(N, Resp, Atom, R1), append(R1, [], R),!.
replace0([I|Index], Input, N, Resp, R):- nth0(I, Input, Atom), length(Index, M), M > 0, select(N, Resp, Atom, R1), N1 is N + 1, replace0(Index, Input, N1, R1, R),!.
replace0([], _, _, Resp, Resp) :- !.

% MOTOR
match([],[]). match([], _).
match([S|Stim],[I|Input]) :- atom(S), S == I, match(Stim, Input),!.
match([S|Stim],[_|Input]) :- \+atom(S), match(Stim, Input),!.