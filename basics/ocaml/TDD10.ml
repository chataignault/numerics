type arb = V|N of int*arb*arb;;

let numerote a = 
	let rec aux a n = match a with
		|V -> V
		|N(x,ag,ad) -> N(n,aux ag (2*n),aux ad (2*n +1)) in
	aux a 1;;
	
(*complexite qui s'applique aux sous arbres gauche et droit donc s'execute en O de la taille de l'arbre*)
(*c'est un parcours postfixe*)
	
let rec est_abr a = match a with 
	| V -> true
	| N(x,ag,ad) -> match ag,ad with 
					| V,V-> true
					| V,N(z,adg,add)-> (x<=z) && est_abr adg && est_abr add 
					| N(y,agg,agd),V -> (y<=x) && est_abr agg && est_abr agd 
					| N(y,agg,agd),N(z,adg,add) -> (x<=z) && (y<=x) && est_abr adg && est_abr add && est_abr agg && est_abr agd ;;
(* marche pas on doit chercher min et max comparer les racines ne suffit pas*)



let estabr a = 
	let rec aux ar = match ar with
		| V -> (true,15,55)
		| N(x,V,V)-> (true,x,x)
		| N(x,ag,V)-> let (bg,ming,maxg) = aux ag in (bg && (maxg<=x),ming,x)
		| N(x,V,ad)-> let (bd,mind,maxd) = aux ad in (bd && (x<=mind),x,maxd)
		| N(x,ag,ad) -> let (bd,mind,maxd) = aux ad and (bg,ming,maxg) = aux ag in 
							(bg && bd &&(x<=mind) && (maxg<=x),ming,maxd) 
				in
		let (b,_,_) = aux a in b;;
		
(*on peut aussi faire un parcours infixe et regarder si les noeuds sont ranges dans l'ordre croissant*)

let rec est_tas a = match a with 
	| V -> true
	| N(x,ag,ad) -> match ag,ad with 
					| V,V-> true
					| V,N(z,adg,add)-> (x>=z) && est_abr adg && est_abr add 
					| N(y,agg,agd),V -> (y<=x) && est_abr agg && est_abr agd 
					| N(y,agg,agd),N(z,adg,add) -> (x>=z) && (y<=x) && est_abr adg && est_abr add && est_abr agg && est_abr agd ;;
					
					
let esttas a = 
	let rec aux ar = match ar with
		| V -> (true,-1)
		| N(x,ag,ad) -> let (bg,vg) = aux ag and (bd,vd) = aux ad in 
						(bg && bd && (x>=vg) && (x >= vd),x)
		in fst(aux a );;
		
let recherche a c = 
	let lis = ref [] in 
	let rec aux ar = match ar with 
		| V -> false 
		| N(x,ag,ad) when x = c -> true
		| N(x,ag,ad) when x < c -> (lis := x::!lis ; aux ad)
		| N(x,ag,ad) -> (lis := x::!lis ; aux ag) in
	let b = aux a in if b then b,!lis else b,[];;
	
	
let rec recherche a c = match a with 
	| V -> []
	| N(x,ag,ad) when x<c -> let resd = recherche ad c in if resd = [] then [] else x::resd;
	| N(x,ag,ad) when x > c -> let resg = recherche ag c in if resg = [] then [] else x::resg;
	| N(x,ag,ad) -> [x];;
	
(*coomplexite en O de la hauteur de l'arbre*)

let rec insere x a = match a with 
	| V -> N(x,V,V)
	| N(y,ag,ad) when x<= y -> N(y,insere x ag,ad)
	| N(y,ag,ad) -> N(y,ag,insere x ad);;
	
	
let rec construit l = match l with 
	| [] -> V
	| x::q -> insere x (construit q);;
	

let rec pinfixe a acc = match a with 
	| V -> acc
	| N(x,ag,ad) -> let ld = (pinfixe ad acc) in (pinfixe ag x::ld);;
	
let infixe a = pinfixe a [];;	
	
let tri liste = let a = construit liste in infixe a;;



let collecte a =
	let res = ref [] in
	let rec aux a = match a with 
		| V -> ()
		| N(x,ag,ad) -> begin aux ad; res := x::(!res); aux ag; end
	in aux a; !res;; 

let rec fusionne a1 a2 = match a1,a2 with
	| a,V -> a1
	| V,a -> a2
	| N(x1,ag1,ad1),_ -> N(x,a1g,fusionne ad1 a2);; (*quand on le reapplique l'hypothese est toujours validee*)
(*complexite en O de la hauteur de a1*)
	
let rec extraire supprime a c = match a with 
	| V -> V
	| N(x,ag,ad) when c>x -> N(x,ag,supprime ad c)
	| N(x,ag,ad) when c<x -> N(x,supprime ag c,ad)
	| N(x,ag,ad) -> fusionne ag ad;;
	
(*nouvelle fonction supprimer de meme complexite*)

let rg a = match a with 
	| V -> a
	| N(x,_,V)-> a
	| N(p,a,N(q,b,c)) -> N(q,N(p,a,b),c);;


	
	
