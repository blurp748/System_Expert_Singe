## Système expert fait dans le cadre d'un cours de Master 1
### Quel singe es-tu ?
Ce système permet de dire quel singe es-tu, les règles sont basés sur nos idées.

### Conditions d'utilisation 
Nécessite d'installer sbcl afin d'exécuter le programme Lisp

sbcl --script expert.lsp : pour lancer le programme
sbcl -load expert.lsp : pour rentrer dans le fichier

### Quelques fonctions pour Lisp
FVAL -> méthode
CVAL -> variable

Pour les exemples, op contient l'opérateur +.

    ' -> signifie de ne pas évaluer l'objet. ex : '+ n'évalue pas le +

    setq -> définit une variable ex: (setq op '+) mets + dans op.

    append -> concatene des listes. ex : (append '(a b) '(c d)) renvoie (a b c d)

    apply -> permet d'appliquer une fonction sur une liste de paramètres. ex: (apply op '(3 4 5)) renvoie 12. Il s'agit de cons + eval

    eval -> même chose que apply mais s'applique différement. (utilise une symbolic expression) ex : (eval (cons op '(2 3 4))) renvoie 9

    cons -> permet d'appliquer sans évaluer une fonction sur une liste. ex : (cons op '(2 3 4)) renvoie (+ 2 3 4)

    mapcar -> permet d'appliquer une fonction sur une liste d'arguments. ex : (mapcar op '(2 3 4) '(5 6 7)) renvoie (7 9 11)

    defun -> définit une fonction. ex : (defun premier (l) (car l)) -> (premier '(a b c)) renvoie a

    cond -> équivalent du if. ex : (cond ((null s)) ((atom s) nil) (t))
        dans cet exemple, si s est null, renvoie true, si atom s est true renvoie nil, sinon renvoie t 

    null -> renvoie si le paramètres est null ou non. ex : (null s)

    atom ->  ex : (atom s)

    car -> renvoie le premier element de la liste . ex : (car '(1 2 3)) renvoie 1

    cdr -> renvoie la liste sans son premier element. ex (cdr '(1 2 3)) renvoie (2 3)

    length -> renvoie la taille de la liste. ex : (length '(1 2 3)) renvoie 3

    print -> affiche dans l'output le resultat d'une fonction.

    cadr -> mix de car et cdr qui permet de renvoie le deuxième élément d'une liste. ex : (cadr '(1 2 3)) renvoie 2

    terpri -> retour à la ligne.

    getd -> retourne la FVAL d'un atom.

    ] -> permet de rajouter le nombre de parenthèses nécessaire pour completer la fonction.

    defstruct -> definit un objet. ex : (defstruct personne nom age) 

    membrep s1 s2 -> retourne T (true) si s2, qui doit être une liste contient s1, retourne nil sinon

    defparameter x 10 -> initialise x à 10 ( équivalent à x = 10 )

    equal x y -> true si x == y