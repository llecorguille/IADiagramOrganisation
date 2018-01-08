:-include('data.pl').

/*
Calcule l'aire entre les caractéristiques d'un diagramme

Paramètre 1 : Le diagramme
Paramètre 2 : La liste de dimensions
Paramètre 3 : Résultat -> Retourne l'aire du diagramme

Modifications :
900d9f9 QUINQUENEL Nicolas 12/12/2017 Création de la méthode pour calculer l'aire
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet afin de prendre en compte les nouvelles listes de dimensions/diagrammes, ex: value(diag, dim, x)

Pré-Condition : Le paramètre 1 est un diagramme, le paramètre 2 est une liste de dimensions non vide
Post-Condition : Le paramètre 3 est un float
*/
aireInit(Diag,[Dim1|ListDim], RET):-
    insertFin(Dim1, [Dim1|ListDim], N1),
    aire(Diag,N1,0,RET).

aire(Diag, [Dim1, Dim2], Tmp, RET):-
    value(Diag, Dim1, X1),
    value(Diag, Dim2, X2),
    max(Dim1, Y1),
    max(Dim2, Y2),
    RET is ((1/2*(X1/Y1)*(X2/Y2))) + Tmp.

aire(Diag, [Dim1, Dim2|ListDim], Tmp, RET):-
    value(Diag, Dim1, X1),
    value(Diag, Dim2, X2),
    max(Dim1, Y1),
    max(Dim2, Y2),
    RET1 is ((1/2*(X1/Y1)*(X2/Y2))) + Tmp,
    aire(Diag, [Dim2|ListDim], RET1, RET).

/*
Ajoute la première valeur à la fin de la liste initiale dans le but de calculer l'aire de tous les secteurs

Paramètre 1 : Valeur à ajouter
Paramètre 2 : Liste
Paramètre 3 : Résultat -> Liste avec la valeur ajouté à la fin

Modifications :
f22dc3c QUINQUENEL Nicolas 12/12/2017 Créer afin de compléter la méthode de calcule d'aire

Pré-Condition : Le paramètre 1 est non nul, le paramètre 2 est une liste
Post-Condition : Le paramètre 3 est une liste
*/
insertFin(Val, [], [Val]).

insertFin(Val, [X|L1], [X|L2]):-
    insertFin(Val, L1, L2).

/*
Calcule la somme des aires de tous les diagrammes pour une permutation

Paramètre 1 : Liste des diagrammes
Paramètre 2 : Liste des dimensions
Paramètre 3 : Résultat -> La somme des aires de tous les diagrammes pour une permutation

Modifications :
900d9f9 QUINQUENEL Nicolas 12/12/2017 Création de la méthode
f22dc3c QUINQUENEL Nicolas 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs graphes
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet (jeu de données écrit en dur)

Pré-Condition : Les paramètres 1 et 2 sont des listes non vides
Post-Condition : Le paramètre 3 est un float
*/
sommeAireInit(ListDiag, ListDim, RET):-
    sommeAire(ListDiag, ListDim, 0, RET).

sommeAire([Diag], ListDim, TmpAire, RET):-
    aireInit(Diag, ListDim, AIRE),
    RET is TmpAire + AIRE.

sommeAire([Diag|ListDiag], ListDim, TmpAire, RET):-
    aireInit(Diag, ListDim, AIRE),
    RET1 is TmpAire + AIRE,
    sommeAire(ListDiag, ListDim, RET1, RET).

/*
Permet de trouver la meilleure permutation qui maximise la somme des aires des diagrammes

Paramètre 1 : Liste des diagrammes
Paramètre 2 : Liste des permutations
Paramètre 3 : La valeur temporaire qui sauvegarde la meilleure permutation
Paramètre 4 : La valeur temporaire qui sauvegarde la plus grande aire
Paramètre 5 : Résultat -> La meilleure permutation qui maximise la somme des aires des diagrammes

Modifications :
f22dc3c QUINQUENEL Nicolas 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs graphes
27ef782 QUINQUENEL Nicolas 12/12/2017 Meilleure permutation possible pour un diagramme
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet (jeu de données écrit en dur)
49c0b9c QUINQUENEL Nicolas 23/12/2017 Refactorisation du code faite et renvoi de la meilleure permutation possible (corrections)

Pré-Condition : Le paramètre 2 est une liste de listes non vide, le paramètre 3 est une liste vide, le paramètre 4 est un réel égal à 0
Post-Condition : Le paramètre 5 est une liste de dimensions
*/
maxAirePermu(ListDiag, [ListPermu1], TmpPermu, TmpAire, RET):-
    sommeAireInit(ListDiag, ListPermu1, Aire),
    (   TmpAire < Aire ->
        RET = ListPermu1
    ;   RET = TmpPermu
    ).

maxAirePermu(ListDiag, [ListPermu1|ListPermuAutres], TmpPermu, TmpAire, RET):-
    sommeAireInit(ListDiag, ListPermu1, Aire),
    (   TmpAire < Aire ->
        maxAirePermu(ListDiag, ListPermuAutres, ListPermu1, Aire, RET)
    ;   maxAirePermu(ListDiag, ListPermuAutres, TmpPermu, TmpAire, RET)
    ).

/*
Permet de supprimer les cycles dans une liste
On fait les permutations de 1 à n et on ajoute 0 devant

Paramètre 1 : Liste des permutations
Paramètre 2 : Résultat -> Liste des permutations sans cycle

Modifications :
1d774fd QUINQUENEL Nicolas 06/01/2018 Création de l'heuristique permettant de retirer les cycles

Pré-Condition : Le paramètre 1 est une liste non vide
Post-Condition : Le paramètre 2 est une liste
*/
permNonCyclique([First|Liste], [First|Permu]):-
    permutation(Liste,Permu).

/*
METHODE NON UTILISE CAR RALENTI L'EXECUTION

Permet de supprimer les symétries dans une liste

Paramètre 1 : Liste de permutations
Paramètre 2 : Résultat -> La liste de permutations sans symétries

Modifications :
N/D QUINQUENEL Nicolas 07/01/2018 Création de l'heuristique permettant de retirer les symétries

Pré-Condition : /
Post-Condition : /
*/
supprimerPermuSymetriqueInit(List, Ret):-
    supprimerPermuSymetrique(List, [], Ret).

supprimerPermuSymetrique([[First,Second|List]|ListTotal], Tmp, Ret):-
    reverse(List, [RevFirst|_]),
    index(Second, I1),
    index(RevFirst, I2),
    (   I1 < I2 ->
        insertFin([First,Second|List], Tmp, NewTmp),
        supprimerPermuSymetrique(ListTotal, NewTmp, Ret)
    ;   supprimerPermuSymetrique(ListTotal, Tmp, Ret)
    ).

supprimerPermuSymetrique([[First,Second|List]], Tmp, Ret):-
    reverse(List, [RevFirst|_]),
    index(Second, I1),
    index(RevFirst, I2),
    (   I1 < I2 ->
        insertFin([First,Second|List], Tmp, NewTmp),
        Ret = NewTmp
    ;   Ret = Tmp
    ).




