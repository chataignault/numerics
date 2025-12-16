let rec suite_rec u0 f n =
  if n = 0 then u0
  else f(suite_rec u0 f (n-1));;

let rec suite_rec_term u0 f n =
  if n = 0 then u0
  else suite_rec (f u0) f (n-1);; 

let rec facto n = if n = 0 then 1
                  else n* facto(n-1);;

let rec facto_aux n m = if n = 1 then m
       else facto_aux (n-1) (n*m);;

let facto_term n = facto_aux n 1;;

let rec longueur = function
      |[] -> 0
      | a :: l -> 1+ longueur l ;;

let rec longueur_aux l n = match l with
      |[] -> n
      |h::t -> longueur_aux t (n+1);;
      
let longueur_term l = longueur_aux l 0;;    
      
(*TYPES SOMMES*)

type couleur = |Vert
               |Bleu
               |Jaune;;
let melange x y = if x = y then x
                 else match x,y with
                 |Bleu,Jaune -> Vert
                 |Jaune,Bleu -> Vert
                 |Vert,c -> c
                 |c,Vert -> c
                 |_,_ -> Vert;;

type nombre = Reel of float | Entier of int;;

let somme x y = match x,y with
      |Reel a, Reel b -> Reel (a+.b)
      |Entier a, Entier b -> Entier (a+b)
      |Reel a, Entier b -> Reel ( a +. float_of_int b)
      |Entier a, Reel b -> Reel ( b +. float_of_int a);;


somme (Reel 2.3) (Entier 4);;

type liste_entiers = |Liste_Vide 
                     |Liste of int*liste_entiers;;
                     
let ajoute a l = Liste (a,l);;

let rec longueur = function
      |Liste_Vide -> 0
      |Liste (a,l)-> 1+ longueur l ;;

type 'a liste = |Liste_Vide 
                |Liste of 'a*('a liste);;

type complexe = {re: float; im: float};;
let i = {re = 0.; im = 1.};;

let somme c1 c2 = {re = c1.re +. c2.re; 
                   im = c1.im +. c2.im};;

type personne = {nom : string; mutable age : int};;

















(*
type 'a pile = ('a list) ref;;


let est_vide p = (!p=[]);;
let empile a p = p := a::!p;;
let depile p = match !p with 
	|[]-> failwith "Pile vide"
	|a::p1 -> p:=p1; a;;*)


(* pour forcer le typage*)
type 'a pile = {mutable liste : 'a list}

let pilevide () = {liste = []};;
let empile a p = p.liste<-a::(p.liste);;
let depile p = match p.liste with 
	|[]-> failwith "Pile vide"
	|a::p1 -> p.liste<-p1;a;;


      


