type arbgen = R of int*arbgen list;;
type arbbin = Nil | Noeud of int*arbbin*arbbin;;

let a = R(1,[R(2,[R(3,[])]);R(5,[R(7,[]);R(6,[])]);R(4,[])]);;
let b = Noeud(1,Noeud(5,Noeud(4,Nil,Nil),Nil),Noeud(2,Nil,Nil));;

let rec preordre a = match a with 
	| [] -> []
	| R(x,t)::q -> let ls = preordre q in x::preordre t @ls;;

	
let prefixe arbre = 
	let res = ref [] in
	let rec explore arbre = match arbre with 
		| [] -> ()
		| R(x,ff)::q -> begin 
					explore q;
					explore ff;
					res := x::!res;
					end;
		in
	explore [arbre];
	!res;;
		
					
let postfixe arbre = 
	let res = ref [] in
	let rec explore arbre = match arbre with 
		| [] -> ()
		| R(x,ff)::q -> begin 
					explore q;
					res := x::!res;
					explore ff;
					end;
		in
	explore [arbre];
	!res;;
	
let rec dans a x = match a with 
	| [] -> false
	| R(y,f)::q -> if x = y then true else (dans f x) || (dans q x);;
	
(*indice de la foret dans laquelle se trouve l'elt*)


let adresse x a = 

	let rec explore a ind res = match a with 
		| []-> false,[]
		| R(y,f)::q -> if x = y then true,ind::res else 
					begin let ls = ref f and k = ref 0 in
						if (fst(explore q (ind+1) res) = true) then snd(explore q (ind+1) res)
						else 
						(while !ls <> [] do 
							let b = List.hd(!ls) in 
							ls := List.tl(!ls);
							explore [b] !k (ind::res);
							incr k;
						done;)
					end;
	in
	explore [a] 0 [];;
							
							
let trouve arbre x = 
	let rec present f = match f with 
		| [] -> false,[]
		| R(a,ff)::q -> if x = a then (true,[0])
						else let (bff,adff) = present ff in 
						if bff then (true,0::adff)
						else let (bq,adqq) = present q in 
						if bq then (true,(List.hd(adqq)+1)::List.tl(adqq))
						else false,[];
					in 
	let (b,ad) = present [arbre] in (b,List.tl(ad));;
	
	
					
					
let qui arbre adresse = 
	let ad = ref adresse in 
	let a = ref arbre in 
	while !ad <> [] do
		let k = List.hd(!ad) in 
		ad := List.tl(!ad);
		while !k <> 0 do 
			if !a = [] then failwith "mauvaise adresse"
			else a := List.tl(!a);
		done;
		match !a with 
			|[]-> failwith "mauvaise adresse"
			|R(x,f)::q -> a := f;
	done;
	match !a with 
			|[]-> failwith "mauvaise adresse"
			|R(x,f)::q -> x;;
			
(*let valeur arbre ad = 
	let rec etiquette f ad = match ad with 
		| [] -> failwith "pb";
		| [0] -> if f = [] then failwith "pb" else (let R(x,ff) = (List.hd f) in x);
		| 0::q -> if f = [] then failwith "pb" else let R(x,ff) = List.hd f in etiquette ff;
		| n::q -> etiquette (List.tl f) ((n-1)::q);
		in
		etiquette [arbre] (0::ad);;*)
		
		
let c = R(1,[R(2,[]);R(3,[R(4,[])]);R(5,[])]);;
let d = R(6,[R(7,[])]);;

let rec transforme foret = match foret with 
	| [] -> Nil
	| R(x,f)::q -> Noeud(x,transforme f, transforme q);;
	
let rec taf a = match a with 
	| Nil -> [] 
	| Noeud(x,u,v) -> R(x,taf u)::taf v;;c
		
let rec vider l1 l2 = match l1 with
	|[] -> l2
	|t::q -> vider q (t::l2);;
	
let inv l = vider l [];;


	
	
					

	