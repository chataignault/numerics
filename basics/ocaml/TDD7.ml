type auto_det = {initial : int; terminaux : int list ; delta : (int array) array };;
type auto_gen = {initiaux : int list ; finaux : int list ; ddelta : (int*int) list array };;


let rec insere x liste = match liste with
		| [] -> [x]
		| t::q when x<t -> x::liste
		| t::q when x=t -> x::q
		| t::q when x>t -> t::(insere x q);;
		
		
let rec fusionne l1 l2 = match l1,l2 with
		| [],_ -> l2
		| _,[] -> l1
		| t1::q1,t2::q2 when t1 < t2 -> t1::fusionne q1 l2
		| t1::q1,t2::q2 when t1 = t2 -> t1::fusionne q1 q2
		| t1::q1,t2::q2 -> t2::(fusionne l1 q2);;
							
		
let rec commun liste1 liste2 = match liste1 with 
		| [] -> false 
		| t::q -> List.mem t liste2 || commun q liste2 ;;
		
	
		
let rec cart x l res = match l with
		| [] -> res
		| t::q -> cart x q ((x,t)::res);;
		
let rec cartesien liste1 liste2 = match liste1 with 
		| [] -> [] 
		| x1::q1 -> let res = cartesien q1 liste2 in 
					cart x1 liste2 res ;;
					
(*differnce avec : ?*)
		
		
let rec ajoute a l acc = match l with 
		| [] -> acc
		| b::q -> (a,b)::(ajoute a q acc);;
		
let rec produit l1 l2 = match l1 with 
		| [] -> [] 
		| a::q -> ajoute a l2 (produit q l2);;
		
		
		
let reconnait aut mot = 

	let rec aux mot s = match mot with 
		| [] -> commun [s] aut.terminaux
		| t::q -> (aut.delta.(s).(t) <> -1) && (aux q aut.delta.(s).(t)) in
		
	aux mot aut.initial;;
	
	
let appartient mot auto = 
	let l=ref mot and q = ref auto.initial in
	while (!q <> -1) && (!l <> []) do
		q := auto.delta.(!q).(List.hd(!l));
		l := List.tl(!l);
	done;
	if  !q = -1 then false else List.mem !q auto.terminaux ;;
	
	


let atteignables lis a auto = 
	let l = ref lis and l1 = ref [] and res = ref [] in
	while !l <> [] do	
		let q = List.hd(!l) in
		l := List.tl(!l);
		l1 := auto.ddelta.(q);
		while !l1 <> [] do
			let (b,r) = List.hd(!l1) in
			if b = a then res := (insere r !res);
			l1 := List.tl(!l1);
		done;
	done;
	!res;;
	
		
		
let appartientgn mot auto = 
	let atteints = ref auto.initiaux and l = ref mot in
	while !l <> [] do
		let a = List.hd !l in 
		l := List.tl (!l);
		atteints := atteignables !atteints a auto;
	done;
	commun (!atteints) (auto.finaux);;
	
		
type expr_rat = Eps | Lettre of int | Etoile of expr_rat | Concat of expr_rat * expr_rat | Sum of expr_rat * expr_rat ;;
type lang_local = { i : int list; s : int list ; f : (int*int) list; vide : bool };;


let test = Concat ( Lettre(0), Etoile ( Sum (Lettre(0), Lettre(1) ) ) );;


let linearise expr = 
	
	let k = ref 0 in
	let lis = ref [] in 
	let rec aux expression = match expression with 
			| Eps -> expression
			| Lettre(x) -> lis := x::!lis ; incr k ; Lettre(!k)
			| Concat(expr1,expr2) -> Concat(aux expr1, aux expr2)
			| Sum(expr1,expr2) -> Sum(aux expr1, aux expr2) 
			| Etoile(expr) -> Etoile(aux expr) in
	
	let ne = aux expr in (ne,List.rev(!lis),!k);;
	
	
	

let rec calcule_lang_local expr_l = match expr_l with 
			| Eps -> { i = [] ; s = [] ; f = [] ; vide = true }
			| Lettre(x) -> { i = [x] ; s = [x] ; f = [] ; vide = false}
			| Sum(e1,e2) -> let l1 = calcule_lang_local e1 and l2 = calcule_lang_local e2 in
								{i = fusionne l1.i l2.i ; s = fusionne l1.s l2.s ; f = fusionne l1.f l2.f ; vide = (l1.vide || l2.vide) }
			| Concat(e1,e2) -> begin let l1 = calcule_lang_local e1 and l2 = calcule_lang_local e2 in
								match (l1.vide,l2.vide) with	
									| true,true -> {i = fusionne l1.i l2.i ; s  = fusionne l1.s l2.s ; f = fusionne (fusionne l1.f l2.f) (produit l1.s l2.i) ; vide = (l1.vide && l2.vide) }
									| true,false -> {i = fusionne l1.i l2.i ; s  = l2.s ; f = fusionne (fusionne l1.f l2.f) (produit l1.s l2.i) ; vide = (l1.vide && l2.vide) }
									| false,true -> {i = l1.i ; s  = fusionne l1.s l2.s ; f = fusionne (fusionne l1.f l2.f) (produit l1.s l2.i) ; vide = (l1.vide && l2.vide) }
									| _,_ ->  {i = l1.i ; s  = l2.s ; f = fusionne (fusionne l1.f l2.f) (produit l1.s l2.i) ; vide = (l1.vide && l2.vide) } end
			| Etoile(e) -> let l = calcule_lang_local e in 
									{ i = l.i ; s = l.s ; f = fusionne l.f (produit l.s l.i) ; vide = true };;
									
	
let calcule_auto_lang_local lang c = 

	let term = ref lang.s in
	if lang.vide then term := 0:: !term ;
	let auto = {initial = 0; terminaux = !term ; delta = Array.make_matrix (c+1) c (-1) } in
	let l = ref lang.i in 
	while !l <> [] do 
		auto.delta.(0).(List.hd(!l) -1) <- List.hd(!l); (*transitions qui parteent etat init*)
		l := List.tl(!l);
	done;
	let lf = ref lang.f in
	while !lf<> [] do (*autres transitions*) 
		let (a,b) = List.hd(!lf) in
		auto.delta.(a).(b-1) <- b;
		lf := List.tl(!lf);
	done;
	
	auto;;
	
	
	

let automate expr = 

	let (ne,marque,c) = linearise expr in 
	let auto = calcule_auto_lang_local (calcule_lang_local ne) c in 
	let table = Array.of_list marque in 
	let resultat = { initiaux = [0] ; finaux = auto.terminaux; ddelta = Array.make (c+1) [] } in
	for i = 0 to c do
		for j = 0 to (c-1) do 
			if auto.delta.(i).(j) <> (-1) then 
				resultat.ddelta.(i) <- insere (table.(j), auto.delta.(i).(j)) resultat.ddelta.(i);
		done;
	done;
	resultat;;
	
let testlin = let (ne,r,c) = linearise test in ne;; 
calcule_lang_local testlin;;

automate test;;
	
	
	
let accessible auto_gen = 
	
	let f = ref [auto_gen.initiaux] in 
	let acc = ref [auto_gen.initiaux] in 
	
	while !f <> [] do
		let partie = List.hd(!f) in 
		f := List.tl(!f) ;
		let lis = ref partie in 
		while !lis <> [] do 
			let x = List.hd(!lis) in 
			lis := List.tl(!lis);
			let adj = ref auto_gen.ddelta.(x) in 
			while !adj <> [] do
				let x = snd (List.hd(!adj)) in
				adj := List.tl(!adj);
				if (not (List.mem x partie)) && (not (List.mem (x::partie) !acc)) then begin
					let l = x::partie in 
					f := l::!f;
					acc := l::!acc; end
			done;
		done;
	done;
	
	acc;;
	
	
(*let calcule_aut_local lang_loc = 
	let init =  ref lang_loc.i in 
	let l = ref [] in 
	
	while !init <> [] do
		let x = List.hd(!init) in 
		init := List.tl !init;
		l := x::!l;
	done;
	if lang_loc.vide then 
	{ initial = 0 ; terminaux = 0::lang_loc.s ; delta = vect_of_list fusionne !l lang_loc.f }
	else 
	{ initial = 0 ; terminaux = lang_loc.s ; delta = vect_of_list fusionne !l lang_loc.f }*)
		
		
type expr = Vide | Eps | L of int | Somme of expr*expr | Etoile of expr | Concat of expr*expr;;

let rec equivalent expr = match expr with 
		| Eps -> Eps
		| Somme (e1,e2) -> begin let ep1 = equivalent e1 and ep2 = equivalent e2 in 
							match ep1, ep2 with 
								| Vide,Vide -> Vide 
								| Vide,_ -> ep2
								| _ , Vide -> ep1 
								| _,_ -> Somme(ep1,ep2) end
		| Concat (e1,e2) -> begin let ep1 = equivalent e1 and ep2 = equivalent e2 in 
							match ep1, ep2 with 
								| Vide,Vide -> Vide 
								| Vide,_ -> Vide
								| _ , Vide -> Vide
								| _,_ -> Concat(ep1,ep2) end 
		| Etoile (e1) -> let ep1 = equivalent e1 in 
								if ep1 = Eps then Vide else Etoile ep1
		| Lettre (k) -> Lettre k
		| Eps -> Eps ;;
		
		
	
		

	
