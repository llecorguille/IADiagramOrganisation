%Ordonnancement

% @Changelog
% 37f95e8 07/12/2017 Initialisation projet
% 900d9f9 12/12/2017 Calcule de l'aire
% f22dc3c 12/12/2017 Calcule de l'aire la plus grande parmi plusieurs
% graphes

aire([X1,X2], [Y1,Y2], Tmp, RET):-
    RET is ((1/2*(X1/Y1)*(X2/Y2))) + Tmp.

aire([X1,X2|L1], [Y1,Y2|L2], Tmp, RET):-
    RET1 is ((1/2*(X1/Y1)*(X2/Y2))) + Tmp,
    aire([X2|L1], [Y2|L2], RET1, RET).

aireInit([X1|L1],[X2|L2], RET):-
    insertEnd(X1, [X1|L1], N1),
    insertEnd(X2, [X2|L2], N2),
    aire(N1,N2,0,RET).

insertEnd(Val, [], [Val]).

insertEnd(Val, [X|L1], [X|L2]):-
    insertEnd(Val, L1, L2).

maxAirePermu(L1, L2, RET):-
    permuter(L1, N1),
    permuter(L2, N2),
    maxAireInit(N1, N2, RES),
    RET = RES.

permuter(A,L):-findall(X,permutation(A,X),L).

maxAireInit(L1,L2,RET):-
    maxAire(L1,L2,0,[],RET).

maxAire([X1|L1], [Y1|L2], TmpAire, TmpPermu, RET):-
    aireInit(X1, Y1, AIRE),
    (   TmpAire < AIRE ->
        maxAire(L1, L2, AIRE, X1, RET)
    ;   maxAire(L1, L2, TmpAire, TmpPermu, RET)
    ).

maxAire([X1], [Y1], TmpAire, TmpPermu, RET):-
    aireInit(X1, Y1, AIRE),
    (   TmpAire < AIRE ->
        RET = X1
    ;   RET = TmpPermu
    ).














