let rec element x l = match l with
		| [] -> false
		| h::t -> (x = h)||(element x t);;
		
let rec traitement l f = match l with
		| [] -> []
		| h::t -> (f h)::(traitement t f);;
		
let rec vider l1 l2 = match l1 with
		| [] -> l2
		| h::t -> vider t (h::l2);;
		
let inverser l1 = vider l1 [];;

let concatener l1 l2 = vider (inverser l1) l2;;

let ref_false n = n:= !n && false;;

let echange t i j = let a = t.(i) in
		t.(i) <- t.(j); 
		t.(j) <- a;;

exception Tableau_trie;;
		
let tribulles t = 
		for k = 0 to (Array.length(t) - 1) do
			let n = ref true in
			for j = 0 to (Array.length(t) - 2) do 
				if t.(j + 1) <= t.(j) 
					then echange t (j+1) j;
					ref_false n;
				done;
			if !n then raise Tableau_trie
		done;
		t;;

let tri_bulles_iter t =
		let n = Array.length(t) in
		for i = 0 to (n - 2) do
			for j = 0 to (n-i-2) do
				if t.(j+1) < t.(j) then echange t (j+1) j
				done;
			done;
		t;;
		
let tri_bulles2 t = 
		let a = ref false and n = Array.length t in
		while not !a do
			a := true;
			for i = 0 to (n - 2) do
				if t.(i+1) < t.(i) 
				then (echange t (i+1) i; a := false)
			done;
		done;;

let tri_inser t = 
		let n = Array.length t and j = ref 0 in
		for i = 1 to (n-1) do
			j := i;
			while (!j > 0) && (t.(!j-1) > t.(!j)) do
				echange t (!j-1) !j; j := !j-1;
			done;
		done;;
		
let tri_sel t = 
		let n = Array.length t and j = ref 0 in
		for i = 0 to (n-1) do
			j := i;
			for k = i to (n - 1) do 
				if t.(k) < t.(!j) then j := k;
			done;
			if i != !j then echange t i !j;
		done;;

		
		
type ensemble = int list;;

let rec insertion_ens x e = match e with 
		| [] -> [x]
		| h::t -> if h < x then h::(insertion_ens x t)
							else 
							begin if h = x then t
							else x::h::t;o end;;
							
let rec eliminer x e = match e with
		| [] -> []
		| h::t -> if h = x then t else begin
				if h > x then e
				else h::(eliminer x t)
				end;;
			
		
type 'a arbreb = |ArbreVide | Noeud of 'a*('a arbreb)*('a arbreb);;
(*implemetation prefixe*)
let etiquette a = match a with 
	| ArbreVide -> failwith "arbrevide"
	| Noeud (e,_,_) -> e;;
let droit a = match a with 
	| ArbreVide -> failwith "arbrevide"
	| Noeud (_,_,d) -> d;;
	
let rec taille a = match a with 
	| ArbreVide -> 0
	| Noeud (_,g,d) -> 1 + taille g + taille d;;
let rec hauteur a = match a with 
	| ArbreVide -> 0
	| Noeud (_,g,d) -> 1 + max (hauteur d) (hauteur g);;

let max a b = if a < b then b else a;;

let rec nb_feuilles a = match a with 
	| ArbreVide -> 0
	| Noeud(_,ArbreVide,ArbreVide) -> 1
	| Noeud(_,g,d) -> nb_feuilles d + nb_feuilles g;;

let rec recherche x a = match a with
	| ArbreVide -> false
	| Noeud(e,g,d) -> (x = e)||(recherche x g)||(recherche x d);;
let rec recherche_abr x a = match a with
	| ArbreVide -> false 
	| Noeud(e,g,d) -> if e < x then recherche_abr x d 
						else (e=x)||(recherche_abr x g);;
let rec traitement a f = match a with 
	| ArbreVide -> ArbreVide
	| Noeud(e,g,d) -> Noeud(f e, traitement g f, traitement d f);;

type 'a pile = {mutable liste : 'a list};;
let pilevide () = { liste = [] };;
let empile a p = p.liste <- a::p.liste;;
let depile p = match p.liste with 
		| [] -> failwith "pile vide"
		| h::t -> p.liste <- t; h;;
let tete p = match p.liste with 
		| [] -> failwith "pile vide"
		| h::t -> h;;

type 'a liste = ListeVide | Liste of 'a * ('a liste);;
let listevide () = ListeVide;;
let enliste a t = Liste (a,t);;
let queue l = match l with
		| ListeVide -> failwith "liste vide"
		| Liste (h, t)-> t;;

type 'a file = { avant : 'a list ; arriere : 'a list };;
let enfile a f = let f = { avant = a::(f.avant) arriere = f.arriere } in f;;
let filevide () = { avant = [] ; arriere = [] };;
let rec defile f = match f.arriere with 
		| h::t -> f = { avant = f.avant ; arriere = t } ; h
		| [] -> if f.avant = [] then failwith "file vide" 
		else f = { avant = [] ; arriere = inverser f.avant }; defile f;;
type 'a fileimp = { mutable avant : 'a list ; mutable arriere : 'a list};;
type 'a filetab = { tab : 'a array ; mutable tete : int ; mutable longueur : int };;
let filetabvide a = { tab = Array.make lmax a ; tete = 0 ; longueur = 0};;

type ('a,'b) tablehach = { cellule :( ('a*'b) list ) array ; fonction : 'a -> int };;
let tablevide h m = { cellule = Array.make m [] ; fonction = h };;
let rec recherche_aux k l = match l with 
		| [] -> failwith "false" 
		| (c,e)::t -> if c = k then e else recherche_aux k t;;
let recherche k t = recherche_aux  k ((t.cellule).(t.fonction k)) ;;

let liste_en_largeur arbre = 
		let f = filevide() in 
		let rec largeur_aux () = match defile f with
				| ArbreVide -> if f = filevide() then [] else largeur_aux ()
				| Noeud (e, g, d) -> enfile g f; enfile d f; e::(largeur_aux ())
		in
		enfile arbre f ;
		largeur_aux ();;
		
let profondeur_min arbre = 
		let f = filevide () in 
		let rec profondeur_aux () = 
			match defile f with 
				| ArbreVide -> if f = filevide() then 0 else profondeur_aux ()
				| Noeud (e,g,d) -> enfile g f; enfile d f; 1 + profondeur_aux (* a tester*)
		in 
		enfile arbre f;
		profondeur_aux f;;
