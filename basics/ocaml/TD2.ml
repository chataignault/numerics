(*RECURSIVITE ET LISTES*)

(*Fonction d'Ackermann*)

let rec ackermann n p =
	if n = 0 then p + 1
		else if p = 0 then ackermann (n-1) 1
			else ackermann (n-1) (ackermann n (p - 1))
	;;

(*
A(0,p) = p + 1
A(1,0) = 2
A(1,p) = 2 + p
A(2,0) = 3
A(2,p) = 3 + 2p
A(3,0) = 5
A(3,p) = 2**p
A(4,0) = 2**3
A(4,p) = (2↑↑p)**3

Terminaison : 
pour calculer A en (n,p), on fait un appel recursif en (n-1,A(n,p-1))
pour demontrer le terminaison, on peut se ramener a l'ordre dans N
On utilise l'ordre lexicographique.
*)


(*Rappel sur les listes*)


let tete l = match l with
  |[] -> failwith "tete"
  |h::t -> h;;
let tete2 = function 
	|[] -> failwith "tete2"
	|h::t -> h;;
  
let queue l = match l with
  |[] -> failwith "queue"
  |h::t -> t;;
let queue2 = function 
	|[] -> failwith "queue"
	|h::t -> t;;

let rec longueur l = match l with
  |[] -> 0
  |h::t -> 1 + longueur t;;
let longueur2 = function 
	|[] -> 0
	|h::t -> longueur t + 1;;

let rec maximum l = match l with
  |[] -> failwith "maximum"
  |[a] -> a
  |h::t -> let m = maximum t in
           if h > m then h else m
	;;
let rec maximum2 = function
	|[] -> failwith "maximum2"
	|[a] -> a
	|h::t -> let m = maximum2 t in if h > m then h else m;;

let rec element l n =  match l with
  |[] -> failwith "element"
  |h::t -> if n = 1 then h else element t (n-1);;
let rec element2 l n = match l with
	|[] -> failwith "element2"
	|h::t -> if n = 1 then h else element2 t (n-1);;

let rec vider l1 l2 = match l1 with
  |[] -> l2
  |h::t -> vider t (h::l2);;

let concatenation l1 l2 = vider (vider l1 []) l2;;



(*Polynomes creux*)

let rec degre p = match p with
  |[] -> 0
  |(a,n)::t-> let d = degre t in
              if d < n && a != 0. then n else d
	;;
let rec degre2 = function
	|[] -> 0
	|(a,n)::t -> let d = degre t in if n > d then n else d;; (*dans le cas ou aucun coefficient n'est nul*)
	

(*puissances croissantes*) 
let rec degre p = match p with
  |[] -> 0
  |[(a,n)] -> n
  |(a,n)::t-> degre t;;
(*puissances decroissantes*)
let degre p = match p with
  |[] -> 0
  |(a,n)::t-> n;;

let rec recherche l x = match l with
  |[] -> false
  |a::t -> (a = x) || recherche t x;;
(* on utilise l'ordre d'evaluation de l'operateur || *)

let rec coefficient p i = match p with
  |[] -> 0.
  |(a,n)::t -> if n = i then a 
                        else coefficient t i;;

let rec somme_elem c p = match c,p with
  |_,[] -> [c]
  |(a,n),(b,m)::t -> 
      if n = m then (a+.b,n)::t
               else (b,m)::somme_elem c t
	;;

let rec somme p1 p2 = match p1 with
  |[] -> p2
  |c::t -> somme t (somme_elem c p2);;

let rec produit_elem c p = match c,p with
	|_,[] -> []
	|(a,n),(b,m)::t -> (a *. b, n + m)::produit_elem c t;;
	
let rec produit p q = match p with
	|[] -> []
	|(a,n)::t -> somme (produit_elem (a,n) q) (produit t q);;
	

(*Polynomes sous forme Hörner*)

let rec degreH = function 
	|[] -> 0
	|a::p -> 1 + degreH p;;
	
let rec coefficientH n p = match p with 
	|[] -> failwith "coefficientH"
	|a::t -> if n = 1 then a else coefficientH (n-1) t;;
	
let rec sommeH p q = match p,q with 
	|[],_ -> q
	|_,[] -> p
	|a::t, b::l -> (a +. b)::sommeH t l;;
	
(*let rec produitH p q = match p,q with
	|[],_ -> []
	|_,[] -> []
	|a::t,b::l -> (a *. b)::produit *)