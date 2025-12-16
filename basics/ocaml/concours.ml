
(*TRIFUSION*)	
let rec divise liste = match liste with
			| [] -> [],[]
			| h::[] -> liste,[]
			| h1::h2::t -> let l1,l2 = divise t in
					h1::l1,h2::l2;;
					
let rec fusion liste1 liste2 = match liste1,liste2 with
			| [],_ -> liste2
			| _,[] -> liste1
			| h1::t1,h2::t2 -> if h1 < h2 then h1::(fusion t1 liste2) 
								else h2::(fusion liste1 t2);;
								
let rec trifusion liste = match liste with
			| [] -> []
			| [a] -> liste
			| _ -> let l1,l2 = divise liste in
						fusion (trifusion l1) (trifusion l2);;
										

let rec exp x n = if n = 0 then 1
					else let y = exp (x*x) (n/2) in
							if n mod 2 = 0 then y
							else x*y;;
							
let rec exp_imp x n = 
		let z = ref 1 and
		m = ref n and
		y = ref x in
		while !m <> 0 do
			if !m mod 2 = 1 then z := !z * !y;
			m := !m / 2;
			y := !y * !y;
		done; !z;;
		
  
let rec partition pivot liste = match liste with 
		| [] -> [],[]
		| h::t -> let liste1, liste2 = partition pivot t in
					if h < pivot then h::liste1,liste2
					else liste1,h::liste2;;
					
let rec quicksort liste = match liste with 
		| [] -> [] 
		| [a] -> liste
		| x::t -> let liste1,liste2 = partition x t in
					(quicksort liste1) @ x::(quicksort liste2);;
					




				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				