let rec facto n = if n < 0 then raise (Failure "facto")
	else match n with
		|0-> 1
		|k-> k * (facto (k - 1))
	;;

exception Non_nul

let est_nul t = 
	try
	
	for k = 0 to (Array.length t) - 1
	do
		if t.(k) != 0 then raise Non_nul
	done;
	true
	
	with Non_nul -> false
	;;
	
exception Trouve

let cherche a t = 
	try
	for k = 0 to (Array.length t) - 1
	do 
		if t.(k) = a then raise Trouve
	done;
	false
	with Trouve -> true
	;;

let rec combien_aux a l c = match l with
	|[]-> c
	|h::t-> match (cherche a h) with 
						|true -> combien_aux a t (c + 1)
						|false -> combien_aux a t c;;
let rec combien a l = combien_aux a l 0;;


(*TRI*)


(*Tri par selection*)
let tri_selec_array t = 
		for k = 0 to (Array.length(t) - 1) do
				let m = ref k and
				a = t.(k) in 
				for i = k  to (Array.length(t) - 1) do
						if t.(i) <= t.(!m) then m := i
						done;
				t.(k)<-t.(!m);
				t.(!m)<-a;
		done;;
(* Au bout de la k ieme etape, les k premieres valeurs du tableux
sont les k plus petites valeurs du tableau rangees dans l'ordre croissant : la fonction est valide
On fait uniquement des boucles iteratives : la fonction termine.
La complexite est quadratique en la longueur du tableau,
en effet on parcourt toute la liste et on fait le meme nombre d'attribution a chaque iteration*)


(*Tri a bulles*)
(* Le nombre de transpositions realisees a chaque etape est strictement decroissant,
ainsi au bout de la k ieme etape, il ne peut rester qu'au pire n - k etapes avec n la longueur du tableau *)
exception Tableau_trie
let tri_bulles_array t =
		for k = 0 to Array.length(t) - 1 do
				let n = ref 0 in 
						for i = 0 to Array.length(t) - 2 do
								if t.(i) > t.(i + 1) then 
									let a = t.(i) in
									t.(i)<- t.(i + 1); t.(i + 1)<- a;
									n:= !n + 1;
						done;
				if !n = 0 then  raise Tableau_trie
		done;;
(*La fontion est composee de boucles iteratives : elle termine.
Au bout de la k ieme etape, les valeurs non-encore triees se sont deplacees de k indices dans une direction, les autres sont triees:
la fonction est valide.
Au mieux le tableau est deja trie, alors la complexite est constante,
au pire le tableau est trie dans l'ordre decroissant et la complexite est quadratique en la longueur du tableau
si on considere le cout en complexite egal pour toutes les operations (attributions, calcul de booleen, additions),
la complexite est un teta de 5*n**2*)


(*Tri par insertion*)
let rec inser_list a l = match l with
		|[]-> [a]
		|h::t-> if a < h then a::h::t else h::(inser_list a t);;
let rec tri_inser_aux l1 l2 = match l1 with
		|[]-> l2
		|h::t-> tri_inser_aux t (inser_list h l2);;
let tri_inser_list l = tri_inser_aux l [];;
(* Au bout de la k ieme etape, les k premieres valeurs de l1 sont rangees dans l'ordre croissant dans l2 : la fonction est valide.
La fonction termine car une liste a un nombre fini d'elements, et a chaque etape la longueurs de la liste a trier diminue de 1.
Pour evaluer la complexite de tri_inser_list on evalue la complexite de tri_inser_aux.
tri_inser_aux est recursive terminale, elle a une complexite lineaire en la longueur de la liste en comptant
par rapport aux nombre d'appels a la fonction inser_list (sans compter les appels recursifs).
La fonction inser_list est au pire lineaire en la longueur de la liste, au mieux constante (si a chaque iteration la 
valeur a inserer est plus petite que la tete).
A chaque iteration la longueur de la nouvelle liste (initialement la liste vide) augmente de 1 et avec elle la complexite.
La complexite au pire de tri_inser_list est de n(n+1)/2, au mieux lineaire (liste deja triee) en comptant par rapport au
nombre d'appels a la fonction inser_list (en comptant ses propres appels recursifs).*)
exception Valeur_triee
let tri_inser_array t = 
	for k = 0 to Array.length(t) - 1 do
		let x = t.(k) in
		try
		for i = 0 to k do
			if t.(i) > t.(k) then
				begin 
				for j = k - 1 downto i do
					t.(j + 1) <- t.(j); (*on fait de la place pour inserer la kieme valeur*)
				done;
				t.(i)<- x; (*on insere*)
				raise Not_found;
				end
		done;
		with Not_found -> ()
	done;;
(* Terminaison : on procede par parcours iteratif.
Validite : au bout de la k ieme etape, les k premieres valeurs du tableau sont triees dans l'ordre croissant.
Complexite : en n**3 (majorant) par rapport a la longueur du tableau dans le cas d'une liste non triee.
Si la liste est triee la complexite est de n(n+1)/2.*)


(*Tri sur place*)
(*Tri par selection s'effectue sur place car on garde uniquement en memoire un indice pour permuter deux valeurs a chaque iteration.
Tri a bulles s'effectue sur place car on fait des transpositions d'elements adjacents en parcourant la liste.
tri_inser_array se fait sur place egalement.
Le tri sur place minimise la complexite spatiale.
tri_inser_list ne se fait pas sur place car elle exploite la structure recursive de liste : on vide la liste dans une autre.
La complexite temporelle est meilleure, au detriment de la complexite spatiale*)


(*Structures triees*)
let recherche_array_trie a t =
		let x = ref 0 and y = ref (Array.length(t) - 1) in 
		try 
		for k = 0 to Array.length(t) - 1 do
				let z = ((!x + !y) / 2) in
				begin 
				if t.(z) <= a then x := z
				else y := z
				end;
				if (!y - !x) = 1 then raise Not_found
		done;
		false
		with Not_found -> ((a = t.(!x)) || (a = t.(!y)));;
(*On ne peut pas modifier la longueur d'un tableau : 
pour inserer une valeur on est oblige de creer un nouveau tableau a moins d'ecraser une autre valeur,
l'utilisation de la dichotomie n'est pas utile.*)
let insertion_array_trie a t =
		let t2 = Array.make(Array.length(t) + 1) t.(0) and i = ref 0 in 
		try 
		for k = 0 to Array.length(t) - 1 do
			if a > t.(k) then t2.(k) <- t.(k);
			i := !i + 1;
			if a <= t.(k) then raise Not_found
		done;
		t2.(Array.length(t)) <- a; t2;
		with Not_found ->
						begin
							t2.(!i + 1) <- a ;
							for k = !i + 1 to Array.length(t) - 1 do
								t2.(k + 1)<- t.(k)
							 done;
						end ; t2;;
let compte_array a t = let n = ref 0 in for k = 0 to Array.length(t) - 1 do if t.(k) = a then n := !n + 1 done; !n;;
let suppression_array_trie a t = let n = (compte_array a t) in let t2 = Array.make (Array.length(t) - n) t.(0) and m = ref 0 in
	for k = 0 to Array.length(t2) - 1 do
			if t.(k) = a then begin while (t.(k + !m) = a) && (k + !m <=Array.length(t2) - 1) do m := !m + 1; done; t2.(k) <- t.(k + !m); end
			else t2.(k) <- t.(k + !m)
	done; t2;;
(* recherche_array_trie a une complexite quasi logarithmique contre lineaire pour un tableau non trie
insertion_array_trie a une complexite lineaire, la fonction n'a pas d'equivalent pour un tableau non trie (on a pas d'indication sur l'emplacement de l'insertion)
suppression_array_trie a une complexite lineaire (on doit recopier le tableau)*)


let rec insertion_list_triee a l = match l with
	|[]-> [a]
	|h::t -> if a < h then a::h::t else h::(insertion_list_triee a t);;
let rec recherche_list_triee a l = match l with
	|[]-> false
	|h::t-> if h = a then true else recherche_list_triee a t;;
let rec suppression_list_triee a l = match l with
	|[]-> []
	|h::t-> if h > a then h::t else (if h = a then (suppression_list_triee a t) else h::(suppression_list_triee a t));;
(* La complexite de insertion est lineaire contre quadratique pour une liste non triee,
la complexite de recherche est au pire lineaire, au mieux constante contre lineaire pour une liste non triee,
la complexite de suppression est au pire lineaire, au mieux constante contre lineaire pour une liste non triee.*)


type 'a pile = {mutable liste : 'a list}
let insertion_pile_triee a p = p.liste <- insertion_list_triee a (p.liste) ; p;;
let recherche_pile_triee a p = recherche_list_triee a p.liste;;
let suppression_pile_triee a p = p.liste <- suppression_list_triee a p.liste; p;;


type 'a file = {avant : 'a list ;arriere : 'a list}
(*L'avant de la file est trie dans l'ordre croissant tandis que l'arriere est trie dans l'ordre decroissant*)
let rec min l = match l with 
	|[]-> failwith "liste vide"
	|[a] -> a
	|h::t-> let m = min t in if h < m then h else m;;
let rec vider l1 l2 = match l1 with
	|[]-> l2
	|h::t-> vider t (h::l2);;
let inversion l = vider l [];;
let insertion_file_triee a f = if min f.avant > a then {avant = f.avant ; arriere = inversion( insertion_list_triee a (inversion f.arriere))}
								else {avant = insertion_list_triee a f.avant; arriere = f.arriere};;
let recherche_file_triee a f = (recherche_list_triee a f.avant) || (recherche_list_triee a (inversion f.arriere));;
let suppression_file_triee a f = {avant = (suppression_list_triee a f.avant); arriere = inversion(suppression_list_triee a (inversion(f.arriere)))};;
