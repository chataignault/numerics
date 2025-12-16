(*Au bout de la kieme etape,
les ind premieres valeurs du tableau sont inferieures strictement au pivot 
et les valeurs de ind a k sont plus grandes que pivot*)

let echange t i j = 
		let a = t.(i) in 
		t.(i)<- t.(j);
		t.(j)<- a;;
		
let incr r = r := !r + 1;;

let arrange t debut fin = 
		let pivot = t.(debut)
		and ind = ref debut in
		for k = (debut + 1) to fin 
			do
				if t.(k) < pivot then	
					begin 
						incr ind;
						echange t !ind k
					end
			done;
		echange t debut !ind;
		!ind;;
	
let rec tri t i j = 
		if i >= j then () (*i=j pas suffisant car p ex si m = i on fait appel i -> i - 1 ce que est impossible*)
		else 
		let m = arrange t i j in
		tri t i (m - 1); 
		tri t (m + 1) j;; (*car le pivot est deja trie*)
		
let tri_quicksort t = tri t 0 (Array.length(t) - 1);;



(*let em_aux t i j = 
	if i = j then true, t.(i)
	else let k =  (i + j) /2 in 
	match em_aux t i k, em_aux t k j with
		|(false,_),(false,_) -> false, t.(0)
		|(true,e),(false,_) -> if verifier t e i j then true,e else false,t.(0)
		|(false,_),(true,c) -> if verifier t e i j then true,e else false,t.(0)
		|(true,a),(true,b) -> if verifier t e i j*)

let verification t a i j = 
		let m = ref 0 
		and n = (j - i) in
		for k = i to j
			do
			if t.(k) = a
				then incr m
			done;
		!m > (n/2);;

let rec elem_maj1_aux t i j = 
		if i = j then true,t.(i)
		else 
		begin  
		let m = (i + j)/2 in
		match elem_maj1_aux t i m, elem_maj1_aux t (m+1) j with
				|(false,_),(false,_) -> false,t.(0)
				|(true,e),(false,_) -> if verification t e i j then true,e else false,t.(0)
				|(false,_),(true,e) -> if verification t e i j then true,e else false,t.(0)
				|(true,e),(true,f) ->( if(verification t e i j) then true,e 
										else 
											begin
											if (verification t f i j) then true,f else false,t.(0)
											end )
		end;;
		
let elem_maj1 t = elem_maj1_aux t 0 (Array.length(t) - 1);;

(*etape de regne : si on a pluieurs elements majoritaires dans les sous
tableaux on doit tester les deux valeurs
si aucun elt maj false 
si deux memes true*)
(*etape diviser triviale comme trirapide*)

let rec em_maj2_aux t i j =
		if j = (i + 1) then (t.(i) = t.(j)),t.(i)
		else (if i = j then false,t.(i) else
		let k = (i+j)/2 in
		match em_maj2_aux t i k, em_maj2_aux t k j with
				|(false,_),(false,_) -> false,t.(0)
				|(true,e),(false,_) -> true,e
				|(false,_),(true,e) -> true,e
				|(true,e),(true,f) -> if verification t e i j then true,e else 
										begin 
										if verification t f i j then true,f else false,t.(0)
										end);;
(*ne marche pas*)
let em_maj2 t = em_maj2_aux t 0 (Array.length(t) - 1);;