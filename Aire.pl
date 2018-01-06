%Ordonnancement

% @Changelog
% 37f95e8 07/12/2017 Initialisation projet
% 900d9f9 12/12/2017 Calcule de l'aire
% f22dc3c 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs
% graphes
% 27ef782 12/12/2017 Meilleure permutation possible pour un graphe
% N/D 15/12/2017 Restructuration du projet (jeu de données écrit en dur)
% 49c0b9c 23/12/2017 Refactorisation du code faite et renvoi de la
% meilleure permutation possible
% d3fb99f 24/12/2017 Factorisation code inutile
% 9866c62 27/12/2017 Méthode calcule aire entre chaque dimensions
% (ordonnancement)
% a7f8318 28/12/2017 Méthode pour calculer la différence entre les
% graphes (ordonnancement)
% d0067cc 28/12/2017 Ajout de dimensions pour les tests
% c6ca7e8 30/12/2017 Ajout des dernières méthodes pour l'ordonnancement

:-include('data.pl').

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
permuEtOrdo(ListDiag, ListDim, RETPermu, RetFinal):-
    findall(V2, permNotCyclic(ListDim, V2), ListDimPermu),
    maxAirePermu(ListDiag, ListDimPermu, [], 0, RETPermu),
    sommeAirePosInit(ListDiag, RETPermu, RetList),
    differenceAireMultInit(RetList, RetList, ListTmp),
    createKeyValueListInit(ListTmp, ListDiag, RetTmp),
    msort(RetTmp, RetFinalTmp),
    removeKeyListInit(RetFinalTmp, RetFinal).

permuOnly(ListDiag, ListDim, RETPermu):-
    findall(V2, permNotCyclic(ListDim, V2), ListDimPermu),
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
        write(Aire),
        RET = ListPermu1
    ;   write(TmpAire),
        RET = TmpPermu
    ).

% Calcule l'aire entre 2 caractéristiques et la met dans une liste
airePos(Diag, [Dim1, Dim2], TmpArray, RET):-
    value(Diag, Dim1, X1),
    value(Diag, Dim2, X2),
    max(Dim1, Y1),
    max(Dim2, Y2),
    Tmp2 is ((1/2*(X1/Y1)*(X2/Y2))),
    insertEnd(Tmp2, TmpArray, RET).

airePos(Diag, [Dim1, Dim2|ListDim], TmpArray, RET):-
    value(Diag, Dim1, X1),
    value(Diag, Dim2, X2),
    max(Dim1, Y1),
    max(Dim2, Y2),
    RET1 is ((1/2*(X1/Y1)*(X2/Y2))),
    insertEnd(RET1, TmpArray, TmpArray2),
    airePos(Diag, [Dim2|ListDim], TmpArray2, RET).

airePosInit(Diag,[Dim1|ListDim], RET):-
    insertEnd(Dim1, [Dim1|ListDim], N1),
    airePos(Diag, N1, [], RET).

% Ajoute la liste des aires entre 2 caractéristiques de tous les graphes
% dans une liste globale
sommeAirePosInit(ListDiag, ListDim, RET):-
    sommeAirePos(ListDiag, ListDim, [], RET).

sommeAirePos([Diag|ListDiag], ListDim, TmpArray, RET):-
    airePosInit(Diag, ListDim, ListAire),
    insertEnd(ListAire, TmpArray, TmpArray2),
    sommeAirePos(ListDiag, ListDim, TmpArray2, RET).

sommeAirePos([Diag], ListDim, TmpArray, RET):-
    airePosInit(Diag, ListDim, ListAire),
    insertEnd(ListAire, TmpArray, RET).

% Parcours toutes les liste d'aires et calcule la différence avec les
% autres listes d'aires
differenceAireMultInit(ListAireBase, ListAire, ListRet):-
    differenceAireMult(ListAireBase, ListAire, [], ListRet).

differenceAireMult([AireBase|ListAireBase], [_|ListAire], TmpRet, ListRet):-
    differenceAireInit(AireBase, ListAire, Ret),
    insertEnd(Ret, TmpRet, TmpRet2),
    differenceAireMult(ListAireBase, ListAire, TmpRet2, ListRet).

differenceAireMult([_|_], _, TmpRet, ListRet):-
    ListRet = TmpRet.

% Pour une liste d'aire, on va la comparer à toutes les autres listes
% d'aires (liste d'aire 1 va voir les listes 2, 3, 4, etc. et la 2eme ne
% verra que la 3, 4 etc mais pas celle d'avant)
differenceAireInit(AireBase, ListAire, ListRet):-
    differenceAire(AireBase, ListAire, [], ListRet).

differenceAire(AireBase, [List|ListAire], TmpRet, ListRet):-
    diffCalculeInit(AireBase, List, Ret),
    insertEnd(Ret, TmpRet, TmpRet2),
    differenceAire(AireBase, ListAire, TmpRet2, ListRet).

differenceAire(AireBase, [List], TmpRet, ListRet):-
    diffCalculeInit(AireBase, List, Ret),
    insertEnd(Ret, TmpRet, ListRet).

% Calcule la différence entre chaque dimension pour les 2 listes d'aires
diffCalculeInit(AireBase, ListAire, Ret):-
    diffCalcule(AireBase, ListAire, 0, Ret).

diffCalcule([ValBase|AireBase], [ValAire|ListAire], TmpRet, Ret):-
    Tmp1 is (((ValBase - ValAire)*(ValBase - ValAire)) + TmpRet),
    diffCalcule(AireBase, ListAire, Tmp1, Ret).

diffCalcule([_], [_], TmpRet, Ret):-
    Ret = TmpRet.

% Créer une liste [value, diag] entre un diagramme et la valeur
% correspondant a la différence d'air du diagramme 1 et un diagramme
% suivant. Permet de trier en gardant la correspondance par la suite.
createKeyValueListInit([List1|_], [_|ListDiag], Ret):-
    createKeyValueList(List1, ListDiag, [], [], Ret).

createKeyValueList([Value|List], [Diag|ListDiag], EmptyArray, RetTmp, Ret):-
    insertEnd(Value, EmptyArray, New),
    insertEnd(Diag, New, RetTmp2),
    insertEnd(RetTmp2, RetTmp, NewRet),
    createKeyValueList(List, ListDiag, [], NewRet, Ret).

createKeyValueList(_, _, _, RetTmp, Ret):-
    Ret = RetTmp.

% Enlève les valeurs des tuples afin de retourner seulement
% l'ordonnancement des diagrammes
removeKeyListInit(List, Ret):-
    TmpArray = [],
    insertEnd([diag1], TmpArray, Array),
    removeKeyList(List, Array, Ret).

removeKeyList([[_|Value]|List], TmpList, Ret):-
    insertEnd(Value, TmpList, TmpRet),
    removeKeyList(List, TmpRet, Ret).

removeKeyList(_, TmpList, Ret):-
    Ret = TmpList.

permutNonCycleInit(List, Ret):-
    permutNonCycle(List, [], Ret).

permutNonCycle([Elem|List], Tmp, Ret):-
    permutNonCycle(List, [Elem|Tmp], Ret).

permutNonCycle(Elem, Tmp, Ret):-
    Ret = [Elem|Tmp].

permNotCyclic([First|Liste],[First|Permu]):-
    permutation(Liste,Permu).


