printList([]).
printList([X|L1]):-
    write(X),
    printList(L1).

L is [(1,1),(1,8),(1,1),(1,8)].
permutation(L, M).

printList(M).
