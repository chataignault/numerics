
let comp a b = (if a<b then 1 else (if a>b then -1 else 0));;

let echange a i j = 
	let x = a.(i) and y = a.(j) in
	a.(i) <- y; a.(j) <- x;;
	
let rec entasser i a = 
	let n = a.(0) in
	let l = 2*i and r = 2*i +1 and max = ref i in
	if (l <= n) && (comp a.(l) a.(!max) = -1) then max := l
	else 
	(if (r <= n) && (comp a.(r) a.(!max) = -1) then max := r
	else (if !max <> i then echange a i !max; entasser !max a));;
	
	
let construiretas a = 
	for k = (a.(0) / 2) downto 1 do
		entasser k a;
	done;;  
	
		
let tri v = 
	let n = (Array.length v) -1 in
	v.(0) <- n;
	construiretas v;
	for i = n downto 2 do
		echange v i 1;
		v.(0) <- v.(0) - 1;
		entasser 1 v;
	done;;
	
let priomax f = if f.(0) = 0 then failwith "impossible" else f.(1);;

let retiremax f = if f.(0) = 0 then failwith "impossible" else 
	begin
		let x = f.(1) in
		f.(1) <- f.(f.(0));
		f.(0) <- f.(0) -1;
		entasser 1 f;
		x;
	end;;
	
	
let inserer x t = if t.(0) = Array.length(t) then failwith "plein"
	else (
	t.(0) <- t.(0) +1;
	t.(t.(0)) <- x;
	construiretas t;;
	
 
	
	