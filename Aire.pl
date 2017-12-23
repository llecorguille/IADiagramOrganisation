%Ordonnancement

% @Changelog
% 37f95e8 07/12/2017 Initialisation projet
% 900d9f9 12/12/2017 Calcule de l'aire
% f22dc3c 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs
% graphes
% 27ef782 12/12/2017 Meilleure permutation possible pour un graphe
% N/D 15/12/2017 Restructuration du projet (jeu de données écrit en dur)

max(dim1, 10).
max(dim2, 9).
max(dim3, 8).
max(dim4, 20).

value(diag1, dim1, 5).
value(diag1, dim2, 1).
value(diag1, dim3, 6).
value(diag1, dim4, 16).

value(diag2, dim1, 2).
value(diag2, dim2, 7).
value(diag2, dim3, 3).
value(diag2, dim4, 2).

% Calcule l'aire entre 2 caractéristiques
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

aireInit(Diag,[Dim1|ListDim], RET):-
    insertEnd(Dim1, [Dim1|ListDim], N1),
    aire(Diag,N1,0,RET).

% Ajoute la première valeur à la fin de la liste initiale (pour l'aire)
insertEnd(Val, [], [Val]).

insertEnd(Val, [X|L1], [X|L2]):-
    insertEnd(Val, L1, L2).

% Calcule la somme des aires de tous les graphes pour une permutation
sommeAireInit(ListDiag, ListDim, RET):-
    sommeAire(ListDiag, ListDim, 0, RET).

sommeAire([Diag|ListDiag], ListDim, TmpAire, RET):-
    aireInit(Diag, ListDim, AIRE),
    RET1 is TmpAire + AIRE,
    sommeAire(ListDiag, ListDim, RET1, RET).

sommeAire([Diag], ListDim, TmpAire, RET):-
    aireInit(Diag, ListDim, AIRE),
    RET is TmpAire + AIRE.

% Effectue les permutations et trouve la meilleure permutation (qui
% maximise la somme des aires des graphes)
maxAirePermuInit(ListDiag, ListDim, RETPermu):-
    findall(V2, permut(ListDim, V2), ListDimPermu),
    maxAirePermu(ListDiag, ListDimPermu, [], 0, RETPermu).

maxAirePermu(ListDiag, [ListPermu1|ListPermuAutres], TmpPermu, TmpAire, RET):-
    sommeAireInit(ListDiag, ListPermu1, Aire),
    (   TmpAire < Aire ->
        maxAirePermu(ListDiag, ListPermuAutres, ListPermu1, Aire, RET)
    ;   maxAirePermu(ListDiag, ListPermuAutres, TmpPermu, TmpAire, RET)
    ).

maxAirePermu(ListDiag, [ListPermu1], TmpPermu, TmpAire, RET):-
    sommeAireInit(ListDiag, ListPermu1, Aire),
    (   TmpAire < Aire ->
        RET = ListPermu1
    ;   RET = TmpPermu
    ).

% Toutes les permutations possibles d'une liste
permut(ListDim, RET):-
    permutation(ListDim, ListDimPermu),
    RET = ListDimPermu.










