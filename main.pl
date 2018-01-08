:-include('aire.pl').
:-include('ordonnancement.pl').

/*
Effectue les permutations et trouve la meilleure permutation (qui
maximise la somme des aires des graphes)

Paramètre 1 : Liste des diagrammes
Paramètre 2 : Liste des dimensions
Paramètre 3 : Résultat -> Meilleure permutation
Paramètre 4 : Résultat -> Un des ordonnancements optimal

Modifications :
37f95e8 QUINQUENEL Nicolas 07/12/2017 Initialisation projet
900d9f9 QUINQUENEL Nicolas 12/12/2017 Ajout de la méthode pour le calcule de l'aire
27ef782 QUINQUENEL Nicolas 12/12/2017 Ajout de la méthode de la meilleure permutation possible pour un diagramme
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet (jeu de données écrit en dur)
d3fb99f QUINQUENEL Nicolas 24/12/2017 Factorisation code inutile

Pré-Condition : Les paramètres 1 et 2 sont des listes non vides
Post-Condition : Les paramètres 3 et 4 sont des listes
*/
permuEtOrdo([Diag], ListDim, RETPermu, RetFinal):-
    findall(V2, permNonCyclique(ListDim, V2), ListDimPermu),
    maxAirePermu([Diag], ListDimPermu, [], 0, RETPermu),
    RetFinal = Diag.

permuEtOrdo(ListDiag, ListDim, RETPermu, RetFinal):-
    findall(V2, permNonCyclique(ListDim, V2), ListDimPermu),
    %supprimerPermuSymetriqueInit(ListDimPermuAvant, ListDimPermu),
    maxAirePermu(ListDiag, ListDimPermu, [], 0, RETPermu),
    sommeAirePosInit(ListDiag, RETPermu, RetList),
    differenceAireMultInit(RetList, RetList, ListTmp),
    creerKeyValueListInit(ListTmp, ListDiag, RetTmp),
    msort(RetTmp, RetFinalTmp),
    supprimerKeyListInit(RetFinalTmp, RetFinal).

permuEtOrdo([], [], RETPermu, RetFinal):-
    RETPermu = [],
    RetFinal = [].

/*
Effectue les permutations et trouve la meilleure permutation (qui
maximise la somme des aires des graphes)

Paramètre 1 : Liste des diagrammes
Paramètre 2 : Liste des dimensions
Paramètre 3 : Résultat -> Meilleure permutation
Paramètre 4 : Résultat -> Un des ordonnancements optimal

Modifications :
37f95e8 QUINQUENEL Nicolas 07/12/2017 Initialisation projet
900d9f9 QUINQUENEL Nicolas 12/12/2017 Ajout de la méthode pour le calcule de l'aire
27ef782 QUINQUENEL Nicolas 12/12/2017 Ajout de la méthode de la meilleure permutation possible pour un diagramme
N/D QUINQUENEL Nicolas 15/12/2017 Restructuration du projet (jeu de données écrit en dur)

Pré-Condition : Les paramètres 1 et 2 sont des listes non vides
Post-Condition : Le paramètre 3 est une liste
*/
permu(ListDiag, ListDim, RETPermu):-
    findall(V2, permNonCyclique(ListDim, V2), ListDimPermu),
    %supprimerPermuSymetriqueInit(ListDimPermuAvant, ListDimPermu),
    maxAirePermu(ListDiag, ListDimPermu, [], 0, RETPermu).




