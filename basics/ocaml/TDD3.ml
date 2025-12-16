let profit l p n = 
	let r = Array.make (n+1) 0 in
	for i = 1 to (n - 1) do
		let j = ref 0 in
		while !j < (Array.length l) && l.(!j) <= i do
			r.(i) <- max r.(i) (p.(i) + r.(i-l.(!j)));
			j := !j + 1;
		done;
	done;
	r.(n);;
	
let profit_opt l p n = 
	let r = Array.make (n+1) 0 and d = Array.make (n+1) (-1) in
	for i = 1 to n - 1 do
		let j = ref 0 in
		while !j < (Array.length l) && l.(!j) <= i do
			let a = (p.(i) + r.(i-l.(!j))) in
			if a > r.(i) then begin r.(i) <- a; d.(i) <- !j; end;
			j := !j + 1;
		done;
	done;
	let res = Array.make (Array.length l) 0 and q = ref n in 
	while d.(!q) <> -1 do
		res.(d.(!q)) <- res.(d.(!q)) + 1;
		q := !q - l.(d.(!q)) ;
	done;
	res;; (* on remonte le tableau en conservant combinaison optimale contenue dans la suite d*)
	
	
type point = {x : float ; y : float};;

let longueur polygone i j = if (j = i + 1) then 0. else sqrt ( (polygone.(i).x -. polygone.(j).x)**2. +. (polygone.(i).y -. polygone.(j).y)**2.);;


let triangulation polygone = 

	let n = Array.length polygone in
	let c = Array.make_matrix n n 0. in
	let ks = Array.make_matrix n n 0 in
	
	for i =  n - 2 downto 0 do
		for j = i+1  to (n - 1) do
		
			if j >= i+2 then begin
				let cout_min = ref 0. and meilleur_indice = ref i in
			
				for k = i to j - 1 do
					let a = c.(i).(k) +. c.(k + 1).(j) +. longueur polygone (i-1) k +. longueur polygone k j in
					if a < !cout_min then cout_min := a ; meilleur_indice := k;
				done;
				c.(i).(j) <- !cout_min; ks.(i).(j) <- !meilleur_indice;
				end;
		done;
	done;
	ks;;
	(*let rec remplit i j =
		if i = j + 1 || i = j then []
		else (i,ks.(i).(j))::(ks.(i).(j),j)::remplit i ks.(i).(j) @ remplit ks.(i).(j) j 
		in
	remplit 0 (n-1);;*)
	
let polygone = [|{x=0.;y=0.};{x=1.;y=0.};{x=1.5;y=0.5};{x=1.;y=1.};{x=0.;y=1.}|];;

let ordonnance temps prix = 
	let n = Array.length prix in
	let qui = Array.make n (-1) and 
	combien = Array.make n 0 in
	combien.(0) <- prix.(0);
	for i = 1 to n-1 do
		let (a,b) = temps.(i) in
		let j = ref (n-1) in
		while fst temps.(!j) > a && !j > 0 do
			j:= !j-1;
		done;
		if snd temps.(i) <= a then begin
			let x = prix.(i) + combien.(!j) in
			if x > combien.(i-1) then qui.(i) <- !j; combien.(i) <- x;
			end
	done;
	let q = ref (n-1) in
	let liste_clients = ref [] in
	while !q >= 0 && qui.(!q) = -1 do q := !q - 1 done;
	let gain = combien.(!q) in
	while !q >= 0 do
		liste_clients:= qui.(!q)::!liste_clients;
		q := qui.(!q);
	done;
	liste_clients,gain;;
	

	
(*let convives c h = 
	let n = Array.length(h) in
	let conv = Array.make n 0 in
	conv.(1) <- c.(i)
	for k = 2 to n-1 do
		let maxi = aux i in
		let a = max conv.(i-1) (c.(i) + maxi) in*)
		
	
			    
			