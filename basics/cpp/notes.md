# Notes de cours CPP
frederic.boulanger@centralesupelec.fr

> pile -> LIFO

**programme executable** = ecrit en binaire, executable par le processeur

*Python doit etre interprete par CPython puis compile en binaire*

a.cpp , b.cpp ->(compilation) a.o , b.o ->(edition de lien) a.out

C++ est un langage imperatif (attribution de variables) (https://en.wikipedia.org/wiki/Imperative_programming)
Imperative languages : Python, C, Java, Fortran
Declarative languages : SQL, HTML
on programming paradigms : https://www.educative.io/blog/declarative-vs-imperative-programming 
Sur-ensemble du langage C

Type statiquement comme TypeScript
Python, Javascript sont types dynamiquement

Un module n'est pas natif a C, pour en creer un il faut :
- des fichiers .cpp d'implementation
- un fichier d'entete .hpp qui declare les services fournis 

> **Probleme d'inclusion multiple** en appelant plusieurs fois le meme module

--- 