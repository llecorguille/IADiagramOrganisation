## Introduction

Ce projet consiste à développer une aide visuelle à la décision à partir de diagrammes en étoile (en toile d'araignée, radar ou Kiviat).

## Comment lancer le programme ?

Notre solution comporte 2 prédicats principaux :
  
permuEtOrdo\4 : Ce prédicat retourne la permutation optimale et un ordonnancement optimal. Il y a 4 paramètres à donner :

* 1 : Liste des diagrammes (Exemple : [diag1, diag2, diag3])
* 2 : Liste des dimensions (Exemple : [dim1, dim2, dim3, dim4])
* 3 : Liste de retour donnant la permutation optimale (Exemple : RetPermu)
* 4 : Liste de retour donnant un ordonnancement optimal (Exemple : RetOrdo)

permu\3 : Ce prédicat ne retourne que la permutation optimale. Il y a 3 paramètres à donner :

* 1 : Liste des diagrammes (Exemple : [diag1, diag2, diag3])
* 2 : Liste des dimensions (Exemple : [dim1, dim2, dim3, dim4])
* 3 : Liste de retour donnant la permutation optimale (Exemple : RetPermu)

Des tests unitaires sont inclus pour chacun des prédicats, ceux-ci se trouvent dans le fichier test.pl. Pour lancer les tests, il suffit d'écrire "run_tests.".
