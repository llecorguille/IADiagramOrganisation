:-begin_tests(test).

test(permNonCyclique):-
    findall(V2, permNonCyclique([dim1, dim2, dim3], V2), ListDimPermu),
    assertion(ListDimPermu == [[dim1, dim2, dim3], [dim1, dim3, dim2]]).

test(supprimerPermuSymetrique):-
    supprimerPermuSymetriqueInit([[dim1, dim2, dim3], [dim1, dim3, dim2]], Ret),
    assertion(Ret == [[dim1, dim2, dim3]]).

test(aire):-
    aireInit(diag1, [dim1, dim2], Ret),
    assertion(Ret == 0.2).

test(insertFin):-
    insertFin(diag3, [diag1, diag2], Ret),
    assertion(Ret == [diag1, diag2, diag3]).

test(creerKeyValueList):-
    creerKeyValueListInit([[0.1, 0.2]], [diag1, diag2, diag3], Ret),
    assertion(Ret == [[0.1, diag2], [0.2, diag3]]).

test(supprimerKeyList):-
    supprimerKeyListInit([[0.1, diag2], [0.2, diag3]], Ret),
    assertion(Ret == [[diag1], [diag2], [diag3]]).

test(aireEntre2Carac):-
    airePosInit(diag1, [dim1, dim2, dim3], Ret),
    assertion(Ret == [0.1, 0.025, 0.125]).

test(sommeAireEntre2Carac):-
    sommeAirePosInit([diag1, diag2], [dim1, dim2], Ret),
    assertion(Ret == [[0.1, 0.1], [0.375, 0.375]]).

test(differenceAireMult):-
    differenceAireMultInit([[0.1, 0.1], [0.375, 0.375]], [[0.1, 0.1], [0.375, 0.375]], Ret),
    assertion(Ret == [[0.07562500000000001]]).

test(maxAirePermu):-
    maxAirePermu([diag1, diag2], [[dim1, dim2, dim3], [dim1, dim3, dim2]], [], 0, Ret),
    assertion(Ret == [dim1, dim2, dim3]).

test(sommeAire):-
    sommeAireInit([diag1, diag2], [dim1, dim2], Ret),
    assertion(Ret == 0.95).

test(airePos):-
    airePosInit(diag1, [dim1, dim2], Ret),
    assertion(Ret == [0.1, 0.1]).

test(differenceAire):-
    differenceAireInit([0.1, 0.1], [[0.375, 0.375]], RET),
    assertion(RET == [0.07562500000000001]).

test(diffCalcule):-
    diffCalculeInit([0.1, 0.1], [0.375, 0.375], RET),
    assertion(RET == 0.07562500000000001).

:- end_tests(test).
