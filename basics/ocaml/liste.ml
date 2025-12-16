(*OPERATIONS FONDAMENTALES SUR LES LISTES*)

let rec ppe l = match l with 
	| [] -> failwith "liste vide"
	| [a] -> a
	| h::t -> let m = ppe t in if m < h then m else h;;
	
let tete = function 
	| [] -> failwith "liste vide"
	| h::t -> h;;
	
let queue = function 
	| [] -> failwith "liste vide"
	| h::t -> t;; 
	
let rec parcours traitement = function
	| [] -> []
	| a::l -> (traitement a):: parcours traitement l;;
	
let rec longueur = function 
	| [] -> 0
	| a::l -> 1 + longueur l;;
	
let rec maxi = function 
	| [] -> failwith "liste vide"
	| [a] -> a
	| a::l -> let b = maxi l in if a >= b then a else b;;
	
let rec element n = function 
	| [] -> failwith "liste trop courte"
	| a::l -> if n = 1 then a else element (n - 1) l;;
	
let rec suppr x = function 
	| [] -> []
	| a::l -> if a = x then suppr x l else a::suppr x l ;;
	
let rec insere x n l = if n = 1 then x::l else (*insere avant le n-ieme element*)
		match l with 
	| [] -> failwith "liste trop courte"
	| a::l -> a::insere x (n - 1) l;;
	
let rec insere_triee x = function
	| [] -> [x]
	| a::l -> if a > x then x::a::l else a::insere_triee x l;; 
	
(*Fonction avec gestion des appels recursifs couteuse:*)
let rec concatenation l1 l2 = match l1 with
	| [] -> l2
	| a::l -> a::concatenation l l2;;

(*Utilisation du @*)
let rec inversion_arobas = function
	| [] -> []
	| a::l -> inversion_arobas l @ [a];;
	
(*Bon point de vue*)
let rec vider l1 l2 = match l1 with
	| [] -> l2
	| a::l -> vider l (a::l2);;

let inversion l = vider l []

let rec concatenation l1 l2 = vider (inversion l1) l2;;