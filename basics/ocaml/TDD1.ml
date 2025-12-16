let rec bitfaible x = match x with
		| 0 -> []
		| _ -> (x mod 2)::bitfaible (x/2);;
							
let rec vider l1 l2 = match l1,l2 with
		| [] ,_ -> l2
		| _, [] -> l1
		| h1::t1 , _ -> vider t1 (h1::l2);;
		
let inverser liste = vider liste [];;

let concatenation liste1 liste2 = vider (inverser liste1) liste2;;

let bit2 x = (inverser (bitfaible x));;

let bitfort n = 
		let res = ref [] and
		q = ref n in
		while !q <> 0 do
			res := (!q mod 2)::!res;
			q := !q/2;
			done;
		!res;;

(*let rec inser e liste = match inverser liste with
		| [] -> [e]
		| h::t -> if e < h then h::(inser e t)
				else e::liste;;		
		
		
let rec triinser liste = match liste with
		| [] -> []
		| h::t -> let l = triinser t in
						inser h l;*)
		
let rec insere a lis = match lis with
		| [] -> [a]
		| b::q when (a <= b)-> a::lis
		| b::q -> b::(insere a q);;
		
let rec tri_insert lis = match lis with
		| [] -> []
		| a::q -> insere a (tri_insert q);;
		
		
let tri_insert_vect v = 
		let n = Array.length(v) - 1 in
		for i = 1 to n - 1 do
			let a = ref v.(i) in
			let m = ref (i - 1) in
			while !m <> 0 && !a < v.(!m) do (*attention a l'ordre d'evaluation*)
				m := !m - 1;
			done;
			for k = i-1 downto !m do
				v.(k+1) <- v.(k);
			done;
			v.(!m) <- !a;
		done;; (*type unit ne renvoie rien*)
		
let tri_vect v = 
	for i = 1 to (Array.length v) - 1 do
		let aux = v.(i) and k = ref (i-1) in
		while !k >= 0 && v.(!k) > aux do
			v.(!k + 1) <- v.(!k);
			decr k;
			done;
		v.(!k + 1) <- aux;
	done;;

	
let miroir u = 
	let n = Array.length u in
	let res = Array.make n 0 in
	for i = 0 to n - 1 do
		res.(i) <- u.(n-1-i);
	done;
	res;;
	
let palindrome u = ( (miroir u) = u);;

let croissance liste = match liste with
	| [] -> true
	| h::t -> let rec cr_aux x l = match l with
				| [] -> true
				| h::t -> (h >= x)&&(cr_aux h t) in
			cr_aux h t;;
			
exception Non;;
exception Oui;;

let croissance_imp liste = 
	match liste with |[] -> true | h::t -> 
	let l = ref t and el = ref h in
	try
	while !l <> [] do
		match !l with
			| [] -> raise Oui
			| h1::t1 -> if h1 < !el then raise Non
					else el := h1; l := t1;
	done; true;
	with |Oui -> true |Non -> false;;
	
let applique_liste_imp f l = 
		let liste = ref l and liste2 = ref [] in
		while !liste <> [] do
			match !liste with |[] -> () | h::t -> liste := t; liste2 := (f h)::!liste2;
		done;
		!liste2;;(*renvoie la liste a l'envers *)

let tete liste = match liste with
			|[] -> failwith "listevide"
			| h::t -> h;;
			
let rec sing_cart x l = match l with 
						| [] -> [] 
						| h::t -> (x,h)::sing_cart x t;;

let rec produit liste1 liste2 = match liste1 with
			| [] -> []
			| [a] -> (sing_cart a liste2)
			| h::t -> concatenation (sing_cart h liste2) (produit t liste2);;
		

	