(defun recorre (lista)
    (when lista
        (let ((elemento (car lista)))
            (format t "¿Tu personaje ~a?~%" (car elemento))
            (setq a (read))
            (if (string-equal a "si")
                (progn
                    (setq b (cadr (assoc (car elemento) lista)))
                    (recorre b)
                )
                (recorre (cdr lista))
            )
        )
    )
)

(defparameter *lista-breaking-bad*
    '(
    ("es de la familia White"
        (("es Walter White"
            (("es químico" (("tiene cáncer" (("es Walter White")))))
             ("usa lentes" (("es Walter White")))))
        ("es Skyler White"
            (("es contadora" (("está embarazada" (("es Skyler White")))))
             ("es hermana de Marie" (("es Skyler White")))))
        ("es Walter White Jr."
            (("usa muletas" (("es Walter White Jr.")))
             ("es adolescente" (("es Walter White Jr.")))))))
    
    ("trabaja con Walter"
        (("es Jesse Pinkman"
            (("es ex-estudiante de Walter" (("es Jesse Pinkman")))
             ("dice 'bitch'" (("es Jesse Pinkman")))
             ("tiene problemas con drogas" (("es Jesse Pinkman")))))
        ("es Gustavo Fring"
            (("es dueño de Los Pollos Hermanos" (("es Gustavo Fring")))
             ("es calmado y calculador" (("es Gustavo Fring")))))
        ("es Mike Ehrmantraut"
            (("es ex-policía" (("es Mike Ehrmantraut")))
             ("es investigador privado" (("es Mike Ehrmantraut")))
             ("es de edad avanzada" (("es Mike Ehrmantraut")))))))
    
    ("es de la DEA"
        (("es Hank Schrader"
            (("es agente de la DEA" (("es Hank Schrader")))
             ("es cuñado de Walter" (("es Hank Schrader")))
             ("colecciona minerales" (("es Hank Schrader")))))
        ("es Steven Gomez"
            (("es compañero de Hank" (("es Steven Gomez")))
             ("es agente de la DEA" (("es Steven Gomez")))))))
    
    ("es familiar de Hank"
        (("es Marie Schrader"
            (("es hermana de Skyler" (("es Marie Schrader")))
             ("le gusta el color morado" (("es Marie Schrader")))
             ("es radióloga" (("es Marie Schrader")))))))
    
    ("es abogado"
        (("es Saul Goodman"
            (("es abogado criminalista" (("es Saul Goodman")))
             ("tiene oficina colorida" (("es Saul Goodman")))
             ("tiene comerciales TV" (("es Saul Goodman")))))))
    
    ("es narcotraficante mexicano"
        (("es Héctor Salamanca"
            (("usa silla de ruedas" (("es Héctor Salamanca")))
             ("se comunica con campanita" (("es Héctor Salamanca")))))
        ("es Tuco Salamanca"
            (("es violento e impredecible" (("es Tuco Salamanca")))
             ("es sobrino de Héctor" (("es Tuco Salamanca")))))
        ("es los primos Salamanca"
            (("son gemelos" (("son los primos Salamanca")))
             ("son sicarios" (("son los primos Salamanca")))))))
    
    ("es socio de Gustavo"
        (("es Gale Boetticher"
            (("es químico puro" (("es Gale Boetticher")))
             ("le gusta la ópera" (("es Gale Boetticher")))))
        ("es Lydia Rodarte-Quayle"
            (("es ejecutiva de Madrigal" (("es Lydia Rodarte-Quayle")))
             ("es muy nerviosa" (("es Lydia Rodarte-Quayle")))))))
    ))