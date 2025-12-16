type 'a arbreb = Arbrevide | Noeud of 'a*('a arbreb)*('a arbreb);;

let coup p c d =
	let n = (Array.length p) - 1 in
	for s = 1 to n-1 do
		begin
		match minimum p c i (i + s) with a,ind -> 
			c.(i).(i+s) <- a;
			d.(i).(i+s) <- ind
			end
		done;
	done;;
	
let rec sol_aux d i j =
	if j <= i + 1 then Arbrevide
	else 
	let ind = d.(i).(j) in
	Noeud(ind, sol_aux d i ind, sol_aux d (ind+1) j);;
	
let solution d = sol_aux d 0 (n-1);;

let vmax_dyn p v pmax =
	let n = Array.length(p) and
	valeur = Array.make_matrix (pmax+1) n 0 in
	for poids = p.(0) to pmax do
		val.(poids).(0) = v.(0)
	done;
	for m = 1 to (n-1) do
		for poids = 1 to pmax do
			if p.(m) > poids
				then vale.(poids).(m) <- vale.(poids).(m-1)
				else vale.(poids).(m) <- max
										(vale.(poids-p.(m)).(m-1) + v.(m))
										vale.(poids).(m-1)
		done;
	done;
	vale.(pmax).(n-1);;


let vmax_dyn p v pmax valeur pris =
	let n = Array.length(p) in
	for poids = p.(0) to pmax do
		val.(poids).(0) = v.(0)
		pris.(poids).(0) = true
	done;
	for m = 1 to (n-1) do
		for poids = 1 to pmax do
			if p.(m) > poids
				then valeur.(poids).(m) <- vale.(poids).(m-1)
				else 
					let a = (valeur.(poids-p.(m)).(m-1) + v.(m))
					and b = valeur.(poids).(m-1) in
					if a > b
						then 
							(valeur.(poids).(m) <- a ;
							pris.(poids).(m) <- true)
					else valeur.(poids).(m) <- b
		done;
	done;
	valeur.(pmax).(n-1);;
	
let objets_pris p v pmax =
	let  = Array.length p in
	let valeur = Array.make_matrix (pmax+1) n 0
	and pris = Array.make_matrix (pmax+1) n false 
	in
	let rec liste_objets poids m =
		if m = -1 then []
		else if d.(poids).(m)
			then m::liste_objets (poids - p.(m)) (m-1)
			else liste_objets (poids) (m-1)
	in
	vmax_dyn p v pmax valeur pris;
	liste_objets pmax (n-1);;
	
	
(*introduction a l'informatique cormen*)
(*poly lolo*)
	