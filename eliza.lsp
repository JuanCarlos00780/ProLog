;;; ==========================================================
;;; VARIABLES GLOBALES Y BASE DE CONOCIMIENTOS
;;; ==========================================================

(defparameter *sintomas-usuario* nil)

;;; --- BASE DE DATOS MÉDICA ---
(defparameter *db-sintomas*
  '((dengue . (fiebre_alta dolor_retroocular dolor_muscular dolor_de_cabeza manchas_rojas nauseas vomitos fatiga perdida_de_apetito sangrado_leve escalofrios))
    (chikunguna . (fiebre_alta dolor_articular_intenso dolor_muscular dolor_de_cabeza erupcion_cutanea fatiga_extrema nauseas malestar_general inflamacion_articular))
    (zika . (fiebre_leve erupcion_con_picazon dolor_muscular dolor_articular dolor_retroocular dolor_de_cabeza fatiga malestar_general conjuntivitis_no_purulenta))
    (diarrea . (heces_liquidas urgencia_para_defecar dolor_abdominal frecuencia_deposiciones))
    (gastroenteritis . (heces_liquidas frecuencia_deposiciones urgencia_para_defecar dolor_abdominal nauseas vomitos fiebre malestar_general))
    (diabetes . (fatiga aumento_de_apetito perdida_de_peso sed_excesiva miccion_frecuente vision_borrosa))
    (hipertiroidismo . (fatiga aumento_de_apetito perdida_de_peso intolerancia_al_calor bocio temblor_en_manos nerviosismo))))

(defparameter *db-contagio*
  '((dengue . "Picadura de mosquito Aedes aegypti.")
    (zika . "Picadura de mosquito o transmision sexual.")
    (chikunguna . "Picadura de mosquitos Aedes infectados.")
    (diarrea . "Agua o alimentos contaminados (fecal-oral).")
    (gastroenteritis . "Contacto con infectados o agua contaminada.")
    (diabetes . "No es contagiosa. Es genetica o por estilo de vida.")
    (hipertiroidismo . "No es contagioso. Es un trastorno de la tiroides.")))

(defparameter *db-medicina*
  '(("Paracetamol e hidratacion. No aspirinas." . dengue)
    ("Reposo, liquidos y paracetamol para fiebre/dolor. Evitar aspirinas hasta descartar dengue." . zika)
    ("Reposo absoluto, hidratacion abundante y paracetamol para el dolor articular." . chikunguna)
    ("Hidratacion constante y dieta blanda (arroz, manzana, pollo hervido)." . diarrea)
    ("Reposo gastrico, hidratacion con suero oral y dieta blanda progresiva." . gastroenteritis)
    ("Insulina o Metformina y dieta." . diabetes)
    ("Antitiroideos o yodo radiactivo." . hipertiroidismo)))

(defparameter *db-especialista*
  '((infectologo . (dengue zika chikunguna))
    (gastroenterologo . (diarrea gastroenteritis))
    (endocrinologo . (diabetes hipertiroidismo))))

;;; --- BASE DE DATOS SOCIAL (FAMILIA Y GOT) ---
(defparameter *db-padres*
  '((lorena esther) (anabel esther) (maria esther) (gabriela esther)
    (areli lorena) (juan lorena)
    (yulisa anabel) (josefina anabel) (carlos anabel)
    (lorena manuel) (anabel manuel) (maria manuel) (gabriela manuel)
    (areli juancarlos) (juan juancarlos)
    (yulisa gerardo) (josefina gerardo) (carlos gerardo)))

(defparameter *db-genero*
  '((hombre . (manuel juancarlos gerardo juan carlos))
    (mujer . (esther lorena anabel maria gabriela areli yulisa josefina))))

(defparameter *db-got*
  '((lema . ((stark . "Winter is Coming") (lannister . "Hear Me Roar") (targaryen . "Fire and Blood")))
    (mato . ((daenerys . jon_snow) (joffrey . olena_tyrell)))
    (casa . ((jon_snow . stark) (daenerys . targaryen) (tyrion . lannister)))))

;;; --- TEMPLATES (PATRONES DE CONVERSACIÓN) ---
(defparameter *templates*
  '(
    ;; SOCIAL
    ((hola mi nombre es s) (Hola 0 Como estas tu ?) (4))
    ((hola s) (Hola como estas tu ?) ()) 
    ((como estas tu ?) (yo estoy bien gracias por preguntar) ())

    ;; GESTIÓN MÉDICA
    ((tengo s y s) (flagAddDosSintomas) (1 3))
    ((tengo s) (flagAddSintoma) (1))
    ((siento s) (flagAddSintoma) (1))
    ((que enfermedades podria tener) (flagSugerirDiagnostico) ())
    ((que probabilidad tengo de s) (flagCalcularProbabilidad) (4))
    ((reporte completo) (flagReporte) ())
    ((limpiar sintomas) (flagClearSintomas) ())
    ((nuevo paciente) (flagClearSintomas) ())
    ((como se contagia la s) (flagContagio) (4))
    ((como se contagia el s) (flagContagio) (4))
    ((que doctor trata la s) (flagEspecialista) (4))
    ((que doctor trata el s) (flagEspecialista) (4))
    ((que tratamiento tiene la s) (flagMedicina) (4))

    ;; FAMILIA
    ((s es hijo de s) (flagFamilia hijo) (0 4))
    ((s es padre de s) (flagFamilia padre) (0 4))
    ((s es madre de s) (flagFamilia madre) (0 4))
    ((s es hermano de s) (flagFamilia hermano) (0 4))
    ((s es abuelo de s) (flagFamilia abuelo) (0 4))
    ((quien es tio de s) (flagFamilia tio) (4))
    ((quien es primo de s) (flagFamilia primo) (4))
    ((cuantos hombres hay en la familia) (flagContarHombres) ())
    ((cuantas mujeres hay en la familia) (flagContarMujeres) ())
    ((quien es s ?) (flagQuienEs) (2))

    ;; GAME OF THRONES
    ((cual es el lema de la casa s) (flagGOT lema) (7))
    ((de que casa es s) (flagGOT casa_de) (4))
    ((quien mato a s) (flagGOT asesino) (3))
    ))

;;; ==========================================================
;;; LÓGICA DE REGLAS E INFERENCIA
;;; ==========================================================

(defun es-padre-o-madre (hijo padre)
  (find (list hijo padre) *db-padres* :test #'equal))

(defun obtener-padres (persona)
  (mapcar #'cadr (remove-if-not (lambda (x) (eq (car x) persona)) *db-padres*)))

(defun son-hermanos (p1 p2)
  (and (not (eq p1 p2))
       (intersection (obtener-padres p1) (obtener-padres p2))))

(defun es-abuelo (abuelo nieto)
  (let ((padres-nieto (obtener-padres nieto)))
    (some (lambda (p) (es-padre-o-madre p abuelo)) padres-nieto)))

(defun obtener-hermanos (persona)
  (let ((padres (obtener-padres persona))
        (hermanos nil))
    (dolist (p padres)
      (dolist (pair *db-padres*)
        (when (and (eq (cadr pair) p) (not (eq (car pair) persona)))
          (pushnew (car pair) hermanos))))
    hermanos))

(defun es-tio (tio sobrino)
  (let ((padres (obtener-padres sobrino)))
    (some (lambda (p) (son-hermanos p tio)) padres)))

(defun obtener-tios (sobrino)
  (let ((padres (obtener-padres sobrino))
        (tios nil))
    (dolist (p padres)
      (let ((hermanos-p (obtener-hermanos p)))
        (dolist (h hermanos-p)
          (pushnew h tios))))
    tios))

(defun obtener-primos (persona)
  (let ((tios (obtener-tios persona))
        (primos nil))
    (dolist (tio tios)
      (dolist (pair *db-padres*)
        (when (eq (cadr pair) tio)
          (pushnew (car pair) primos))))
    primos))

;;; ==========================================================
;;; MOTOR DE PROCESAMIENTO (FLAGS)
;;; ==========================================================

(defun procesar-flag (flag inputs capture-indices)
  (let* ((captured (mapcar (lambda (i) (nth i inputs)) capture-indices))
         (arg1 (first captured))
         (arg2 (second captured)))
    
    (cond
      ;; --- REGISTRO SINTOMAS ---
      ((eq (car flag) 'flagAddSintoma)
       (push arg1 *sintomas-usuario*)
       (list 'registrado arg1))

      ((eq (car flag) 'flagAddDosSintomas)
       (push arg1 *sintomas-usuario*)
       (push arg2 *sintomas-usuario*)
       (list 'registrados arg1 'y arg2))

      ;; --- DIAGNÓSTICO ---
      ((eq (car flag) 'flagSugerirDiagnostico)
       (let ((posibles nil))
         (dolist (db *db-sintomas*)
           (let ((enf (car db))
                 (sints (cdr db)))
             (dolist (us *sintomas-usuario*)
               (when (member us sints)
                 (pushnew enf posibles)))))
         (if posibles
             (append '(podrias tener) (sort posibles #'string<))
             '(no tengo suficiente informacion))))

      ((eq (car flag) 'flagCalcularProbabilidad)
       (let* ((enf arg1)
              (sints-enf (cdr (assoc enf *db-sintomas*)))
              (total (length sints-enf))
              (encontrados (remove-if-not (lambda (s) (member s *sintomas-usuario*)) sints-enf))
              (count (length encontrados))
              (porcentaje (if (> total 0) (* (/ count total) 100.0) 0)))
         (if (= porcentaje 100.0)
             (let ((trata (car (find-if (lambda (x) (eq (cdr x) enf)) *db-medicina*))))
               (list 'diagnostico 'definitivo 'de enf "." 'tratamiento ': trata))
             (list 'probabilidad 'de enf ': (format nil "~,2f%" porcentaje)))))

      ((eq (car flag) 'flagReporte)
       (if *sintomas-usuario*
           (append '(resumen de tus sintomas actuales son :) *sintomas-usuario*)
           '(el expediente esta vacio "," no he registrado sintomas aun)))

      ((eq (car flag) 'flagClearSintomas)
       (setf *sintomas-usuario* nil)
       '(memoria limpia "." todos los sintomas han sido borrados "." listo para un nuevo diagnostico))

      ;; --- MEDICO EXTRA ---
      ((eq (car flag) 'flagContagio)
       (let ((info (cdr (assoc arg1 *db-contagio*))))
         (if info (list info) '(no se))))

      ((eq (car flag) 'flagEspecialista)
       (let ((esp (car (find-if (lambda (pair) (member arg1 (cdr pair))) *db-especialista*))))
         (if esp (list 've 'con 'el esp) '(no se))))

      ((eq (car flag) 'flagMedicina)
       (let ((med (car (find-if (lambda (pair) (eq (cdr pair) arg1)) *db-medicina*))))
         (if med (list 'tratamiento ': med) '(no se))))

      ;; --- FAMILIA ---
      ((equal flag '(flagFamilia hijo))
       (if (es-padre-o-madre arg1 arg2) (list 'si arg1 'es 'hijo 'de arg2) '(no)))
      
      ((equal flag '(flagFamilia padre))
       (if (and (member arg1 (cdr (assoc 'hombre *db-genero*))) (es-padre-o-madre arg2 arg1))
           (list 'si arg1 'es 'padre 'de arg2) '(no)))
      
      ((equal flag '(flagFamilia madre))
       (if (and (member arg1 (cdr (assoc 'mujer *db-genero*))) (es-padre-o-madre arg2 arg1))
           (list 'si arg1 'es 'madre 'de arg2) '(no)))

      ((equal flag '(flagFamilia hermano))
       (if (son-hermanos arg1 arg2) (list 'si arg1 'es 'hermano 'de arg2) '(no)))

      ((equal flag '(flagFamilia abuelo))
       (if (es-abuelo arg1 arg2) (list 'si arg1 'es 'abuelo 'de arg2) '(no)))

      ((equal flag '(flagFamilia tio))
       (let ((tios (obtener-tios arg1)))
         (append (list 'tios 'de arg1 ':) tios)))

      ((equal flag '(flagFamilia primo))
       (let ((primos (obtener-primos arg1)))
         (append (list 'primos 'de arg1 ':) primos)))

      ((eq (car flag) 'flagContarHombres)
       (let ((h (cdr (assoc 'hombre *db-genero*))))
         (append (list 'hay (length h) 'hombres 'en 'la 'familia 'son ':) h)))

      ((eq (car flag) 'flagContarMujeres)
       (let ((m (cdr (assoc 'mujer *db-genero*))))
         (append (list 'hay (length m) 'mujeres 'en 'la 'familia 'son ':) m)))

      ((eq (car flag) 'flagQuienEs)
       (let* ((p arg1)
              (madre (car (remove-if-not (lambda (pair) (and (eq (car pair) p) (member (cadr pair) (cdr (assoc 'mujer *db-genero*))))) *db-padres*)))
              (padre (car (remove-if-not (lambda (pair) (and (eq (car pair) p) (member (cadr pair) (cdr (assoc 'hombre *db-genero*))))) *db-padres*)))
              (hijos (mapcar #'car (remove-if-not (lambda (pair) (eq (cadr pair) p)) *db-padres*)))
              (hermanos (obtener-hermanos p)))
         (append (list p 'es)
                 (if madre (list 'hijo 'de (cadr madre)) nil)
                 (if padre (list 'y 'de (cadr padre)) nil)
                 (list ",")
                 (if hijos (append '(padre_o_madre de) hijos) '(no tiene hijos))
                 (list "," 'hermano_de)
                 hermanos)))

      ;; --- GAME OF THRONES ---
      ((equal flag '(flagGOT lema))
       (let ((res (cdr (assoc arg1 (cdr (assoc 'lema *db-got*))))))
         (if res (list 'lema 'es res) '(no se))))

      ((equal flag '(flagGOT casa_de))
       (let ((res (cdr (assoc arg1 (cdr (assoc 'casa *db-got*))))))
         (if res (list 'casa res) '(no se))))

      ((equal flag '(flagGOT asesino))
       (let ((res (car (find-if (lambda (pair) (eq (cdr pair) arg1)) (cdr (assoc 'mato *db-got*))))))
         (if res (list 'asesino 'es res) '(no se))))

      ;; --- DEFAULT ---
      (t '(Error interno en procesamiento de flag)))))

;;; ==========================================================
;;; MATCHING Y GENERACIÓN DE RESPUESTA
;;; ==========================================================

(defun limpiar-y-leer (str)
  ;; Removemos puntos y comas de la entrada del usuario para evitar errores de lectura
  (let ((limpio (remove-if (lambda (c) (find c ".,;?")) (string-downcase str))))
    (if (string= limpio "")
        nil
        (with-input-from-string (s (concatenate 'string "(" limpio ")"))
          (read s)))))

(defun coincide-patron (patron input)
  (cond
    ((and (null patron) (null input)) t)
    ((or (null patron) (null input)) nil)
    ((or (eq (car patron) 's) (equal (car patron) '_)) 
     (coincide-patron (cdr patron) (cdr input)))
    ((eq (car patron) (car input))
     (coincide-patron (cdr patron) (cdr input)))
    (t nil)))

(defun construir-respuesta (template input)
  (let ((patron (first template))
        (resp-raw (second template))
        (indices (third template)))
    
    (if (symbolp (car resp-raw))
        (if (string= (symbol-name (car resp-raw)) "FLAG" :end1 4)
             (procesar-flag resp-raw input indices)
             (generar-texto-simple resp-raw input indices))
        resp-raw)))

(defun generar-texto-simple (resp-lista input indices)
  (let ((resultado nil))
    (dolist (item resp-lista)
      (if (numberp item)
          (push (nth item input) resultado)
          (push item resultado)))
    (reverse resultado)))

(defun buscar-match (input)
  (let ((found (find-if (lambda (tpl) (coincide-patron (car tpl) input)) *templates*)))
    (if found
        (construir-respuesta found input)
        '(Por favor explicame un poco mas))))

;;; ==========================================================
;;; MOTOR PRINCIPAL (ELIZA LOOP)
;;; ==========================================================

(defun imprimir-lista (lista)
  (format t "~{~a~^ ~}~%" lista))

(defun eliza ()
  (setf *sintomas-usuario* nil)
  (format t "Hola, soy Eliza. Tu ChatBot.~%")
  (format t "Ingresa tu consulta (minusculas y sin punto al final):~%")
  (loop
    (format t "> ")
    (force-output)
    (let* ((linea (read-line))
           (input (limpiar-y-leer linea)))
      
      (cond
        ((or (equal input '(adios)) (equal input '(chau)) (equal input '(bye)))
         (format t "Adios. Se han borrado los sintomas. ¡Cuidate!~%")
         (setf *sintomas-usuario* nil)
         (return))
        
        (t
         (let ((respuesta (buscar-match input)))
           (imprimir-lista respuesta)))))))