; --- Base de faits ---
; ---------------------

(princ "Entrez votre nom : ")
(finish-output)
(defparameter nom (string-upcase (read-line)))

(defparameter genreSinge nil)
(defparameter age -1)
(defparameter color nil)
(defparameter pesto nil)

; Variable pour la base de règles
(defparameter ruleList ())

; Variable pour le moteur d'inférences
(defparameter correctRules ())
(defparameter ruleToExecute nil)

; --- Condition d'arrêt ---
; -------------------------

(defparameter CA '(not (null genreSinge)))

; --- Fonctions ---
; -----------------

;string : string dans lequelle on doit trouver la lettre
;letter : lettre à trouver dans le string
;indice : indice auquel on recherche si la lettre est dans le string, pour parcourir tout le string mettre 0
(defun contains (string letter indice)
    (cond 
        ((not (< indice (length string))) nil)
        ((equal (char string indice) (char letter 0)) t)
        (t (contains string letter (+ indice 1)))
    )
)

;string : string dans lequelle on doit compter les voyelles
;indice : indice auquel on recherche si la lettre est dans le string, pour parcourir tout le string mettre 0
;nbVoyelle : nombre de voyelle dans le string, mettre 0 au début
(defun voyelle (string indice nbVoyelle)
    (cond 
        ((not (< indice (length string))) nbVoyelle)
        ((equal (char string indice) (char "A" 0)) (voyelle string (+ indice 1) (+ nbVoyelle 1)))
        ((equal (char string indice) (char "I" 0)) (voyelle string (+ indice 1) (+ nbVoyelle 1)))
        ((equal (char string indice) (char "U" 0)) (voyelle string (+ indice 1) (+ nbVoyelle 1)))
        ((equal (char string indice) (char "E" 0)) (voyelle string (+ indice 1) (+ nbVoyelle 1)))
        ((equal (char string indice) (char "O" 0)) (voyelle string (+ indice 1) (+ nbVoyelle 1)))
        ((equal (char string indice) (char "Y" 0)) (voyelle string (+ indice 1) (+ nbVoyelle 1)))
        (t (voyelle string (+ indice 1) nbVoyelle))
    )
)

;string : string dans lequelle on doit compter les consonnes, on part du principe qu'il n'y a pas de caractère spéciaux
(defun consonne (string)
  (- (length string) (voyelle string 0 0))
)

; renvoie true ou nil pour une liste de regles donné
(defun test-rules (liste)
    (cond
        ((atom liste) nil)
        ((not (eval (car liste))) nil)
        ((null (cdr liste)) t)
        (t (test-rules (cdr liste)))
    )
)

; definit une nouvelle regle
(defun newRule (nom poids conditions executions)
    (setf (get nom 'conditions) conditions)
    (setf (get nom 'poids) poids)
    (setf (get nom 'executions) executions)
    (setq ruleList (cons nom ruleList))
)

; Parcours toutes les regles de la liste de règle et renvoie la liste de règle ou toutes ses regles sont bonnes 
(defun parcours-regles (liste listeSortie)
    (cond
        ((atom liste) listeSortie)
        ((test-rules (get (car liste) 'conditions)) (parcours-regles (cdr liste) (cons (car liste) listeSortie)))
        ((null (cdr liste)) listeSortie)
        (t (parcours-regles (cdr liste) listeSortie))
    )
)

; Parcours une liste de règle et retourne celui ayant le plus grand cout
(defun parcours-couts (listeSinge rule)
    (cond
        ((atom listeSinge) rule)
        ((> (get (car listeSinge) 'poids) (get rule 'poids)) (parcours-couts (cdr listeSinge) (car listeSinge)))
        ((null (cdr listeSinge)) rule)
        (t (parcours-couts (cdr listeSinge) rule))
    )
)

(defun exec-rule (executionsList)
    (cond
        ((null (car executionsList)) nil)
        (t (eval (car executionsList)) (exec-rule (cdr executionsList)))
    )
)

(defun askAge ()
    (princ "Entrez votre age : ")
    (finish-output)
    (setq age (read))   
)

(defun askColor ()
    (princ "Couleur favorite : ")
    (finish-output)
    (setq color (string-upcase (read-line)))  
)

(defun askPesto ()
    (princ "Pesto Rouge ou Vert?(R/V): ")
    (finish-output)
    (setq pesto (string-upcase (read-line)))  
)

(defun inference ()
    (setq correctRules (parcours-regles ruleList ()))
    (setq ruleToExecute (parcours-couts correctRules (car correctRules)))
    (exec-rule (get ruleToExecute 'executions))
    (setq ruleList (remove ruleToExecute ruleList))
    (cond
        ( (eval CA) (print genreSinge) )
        ( (null ruleToExecute) (print "Error") )
        ( t (inference) )
    )
)

; --- Base de règles ---
; ----------------------

(defun baseDeRegles ()
    (newRule 'askAge '0.5
        '( t )
        '( (askAge) )
    )
    (newRule 'askColor '0.5
        '( t )
        '( (askColor) )
    )
    (newRule 'askPesto '0.5
        '( t )
        '( (askPesto) )
    )
    (newRule 'volodia '0.8
        '( (string-equal nom "volodia") )
        '( (setq genreSinge "orang-outan") )
    )
    (newRule 'antoine '0.8
        '( (string-equal nom "antoine") )
        '( (setq genreSinge "gorille") )
    )
    (newRule 'irilind '0.8
        '( (string-equal nom "irilind") )
        '( (setq genreSinge "singe-elfe") )
    )
    (newRule 'mathis '0.8
        '( (string-equal nom "mathis") )
        '( (setq genreSinge "rhinopitheque") )
    )
    (newRule 'mandrille '0.1
        '( t )
        '( (setq genreSinge "mandrille") )
    )
    (newRule 'babouin '0.3
        '( (> age 29) )
        '( (setq genreSinge "babouin") )
    )
    (newRule 'singe-araignee '0.2
        '( (> (consonne nom) 5) )
        '( (setq genreSinge "singe-araignee") )
    )
    (newRule 'gibbons '0.6
        '( (> (voyelle nom 0 0) 4) (string-equal color "JAUNE") )
        '( (setq genreSinge "gibbons") )
    )
    (newRule 'nasique '0.8
        '( (contains nom "H" 0) (> age 49) )
        '( (setq genreSinge "nasique") )
    )
    (newRule 'rhinopitheque '0.4
        '( (string= color "BLEU") )
        '( (setq genreSinge "rhinopitheque") )
    )
    (newRule 'ouistiti '0.2
        '( (= (voyelle nom 0 0) (consonne nom)) )
        '( (setq genreSinge "ouistiti") )
    )
    (newRule 'macaque '0.9
        '( (string-equal pesto "V") (string-equal color "VERT") )
        '( (setq genreSinge "macaque") )
    )
    (newRule 'chimpanze '0.3
        '( (< age 8) )
        '( (setq genreSinge "chimpanze") )
    )
    (newRule 'gorille '0.7
        '( (contains nom "R" 0) (string-equal color "VIOLET") )
        '( (setq genreSinge "gorille") )
    )
    (newRule 'orang-outan '1
        '( (contains nom "O" 0) (string-equal color "ORANGE") (string-equal pesto "R") )
        '( (setq genreSinge "orang-outan") )
    )
    (newRule 'homo-sapiens '0.3
        '( (= (voyelle color 0 0) (consonne nom)) )
        '( (setq genreSinge "homo-sapiens") )
    )
    (newRule 'saimiri '0.6
        '( (string-equal pesto "R") (string-equal color "ROUGE") )
        '( (setq genreSinge "saimiri") )
    )
    (newRule 'tamarin '0.8
        '( (string-equal nom "marty") )
        '( (setq genreSinge "tamarin") )
    )
)

; --- Moteur d'inférences ---
; ---------------------------

(terpri)

(baseDeRegles)

(inference)

(terpri)