:-include('data.pl').

/*
Calcule l'aire entre les caract�ristiques d'un diagramme

Param�tre 1 : Le diagramme
Param�tre 2 : La liste de dimensions
Param�tre 3 : R�sultat -> Retourne l'aire du diagramme

Modifications :
900d9f9 QUINQUENEL Nicolas 12/12/2017 Cr�ation de la m�thode pour calculer l'aire
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet afin de prendre en compte les nouvelles listes de dimensions/diagrammes, ex: value(diag, dim, x)

Pr�-Condition : Le param�tre 1 est un diagramme, le param�tre 2 est une liste de dimensions non vide
Post-Condition : Le param�tre 3 est un float
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
Ajoute la premi�re valeur � la fin de la liste initiale dans le but de calculer l'aire de tous les secteurs

Param�tre 1 : Valeur � ajouter
Param�tre 2 : Liste
Param�tre 3 : R�sultat -> Liste avec la valeur ajout� � la fin

Modifications :
f22dc3c QUINQUENEL Nicolas 12/12/2017 Cr�er afin de compl�ter la m�thode de calcule d'aire

Pr�-Condition : Le param�tre 1 est non nul, le param�tre 2 est une liste
Post-Condition : Le param�tre 3 est une liste
*/
insertFin(Val, [], [Val]).

insertFin(Val, [X|L1], [X|L2]):-
    insertFin(Val, L1, L2).

/*
Calcule la somme des aires de tous les diagrammes pour une permutation

Param�tre 1 : Liste des diagrammes
Param�tre 2 : Liste des dimensions
Param�tre 3 : R�sultat -> La somme des aires de tous les diagrammes pour une permutation

Modifications :
900d9f9 QUINQUENEL Nicolas 12/12/2017 Cr�ation de la m�thode
f22dc3c QUINQUENEL Nicolas 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs graphes
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet (jeu de donn�es �crit en dur)

Pr�-Condition : Les param�tres 1 et 2 sont des listes non vides
Post-Condition : Le param�tre 3 est un float
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

Param�tre 1 : Liste des diagrammes
Param�tre 2 : Liste des permutations
Param�tre 3 : La valeur temporaire qui sauvegarde la meilleure permutation
Param�tre 4 : La valeur temporaire qui sauvegarde la plus grande aire
Param�tre 5 : R�sultat -> La meilleure permutation qui maximise la somme des aires des diagrammes

Modifications :
f22dc3c QUINQUENEL Nicolas 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs graphes
27ef782 QUINQUENEL Nicolas 12/12/2017 Meilleure permutation possible pour un diagramme
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet (jeu de donn�es �crit en dur)
49c0b9c QUINQUENEL Nicolas 23/12/2017 Refactorisation du code faite et renvoi de la meilleure permutation possible (corrections)

Pr�-Condition : Le param�tre 2 est une liste de listes non vide, le param�tre 3 est une liste vide, le param�tre 4 est un r�el �gal � 0
Post-Condition : Le param�tre 5 est une liste de dimensions
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
On fait les permutations de 1 � n et on ajoute 0 devant

Param�tre 1 : Liste des permutations
Param�tre 2 : R�sultat -> Liste des permutations sans cycle

Modifications :
1d774fd QUINQUENEL Nicolas 06/01/2018 Cr�ation de l'heuristique permettant de retirer les cycles

Pr�-Condition : Le param�tre 1 est une liste non vide
Post-Condition : Le param�tre 2 est une liste
*/
permNonCyclique([First|Liste], [First|Permu]):-
    permutation(Liste,Permu).

/*
METHODE NON UTILISE CAR RALENTI L'EXECUTION

Permet de supprimer les sym�tries dans une liste

Param�tre 1 : Liste de permutations
Param�tre 2 : R�sultat -> La liste de permutations sans sym�tries

Modifications :
N/D QUINQUENEL Nicolas 07/01/2018 Cr�ation de l'heuristique permettant de retirer les sym�tries

Pr�-Condition : /
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




