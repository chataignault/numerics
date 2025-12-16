let rec amplitude e = 
	let n = Array.length(e) and
	min = ref 0 and
	max = ref 0 in 
	for i = 1 to (n - 1) do
		if e.(i) > e.(!max) then max := i
		else ( if e.(i) < e.(!min) then min := i )
	done;
	e.(!max) - e.(!min);;
	
	
let plusgrand t = 
	let n = Array.length(t) in
	let un = ref t.(0) in
	for i = 1 to n-1 do
		if t.(i) > !un then un := t.(i);
	done;
	let ind = ref 0 in
	while t.(!ind) = !un do
		ind := !ind + 1;
	done;
	let deux = ref t.(!ind) in
	for i = 0 to n -1 do
		if t.(i) <> !un && t.(i) > !deux 
			then deux := t.(i);
	done; !un,!deux;;
	 
	
let max_dichot t = 

	let n = Array.length(t) in
	let rec aux i j = match j-i with
		| 1 -> if t.(i) > t.(j) then t.(i),t.(j) else t.(j),t.(i)
		| _ -> begin ( let m = (i+j)/ 2 in 
						let (m1,n1) = aux i m and (m2,n2) = aux (m+1) j in 
						if m1>m2 then (if n1 > m2 then m1,n1 else m1,m2) 
						else (if m1 > n2 then m2,m1 else m2,n2);)
						end; in
						
	aux 0 (n-1);;

		
