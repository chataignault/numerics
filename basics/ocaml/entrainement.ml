type complexe = {re : float ; im : float};;
let somme a b = {re = a.re +. b.re ; im = a.im +. b.im};;
let multiplier a b = {re = a.re *. b.re -. a.im*. b.im; im = a.re*. b.im +. a.im*. b.re};;
let rec puissance_complexe_aux a b n = match n with
		|0-> {re = 1. ; im = 0.}
		|1-> b
		|m-> puissance_complexe_aux a (multiplier a b) (n - 1);;
let puissance_complexe a n = puissance_complexe_aux a a n;;
let rec somme_puiss_aux w p n s = match n with 
		|1-> somme s ({re = 1. ; im = 0.})
		|m-> somme_puiss_aux w p (n-1) (somme s (puissance_complexe w ((n-1)*p)));;
let somme_puiss w p n = somme_puiss_aux w p n {re = 0.; im = 0.};;
let rec maxi l = match l with 
		|[]-> failwith "liste vide"
		|h::t -> let m = maxi t in if h > m then h else m;;
let rec recherche l a = match l with
		|[]-> false 
		|h::t -> h = a || recherche t a;;
let rec recherche2_aux l a b = match l with
		|[]-> b
		|h::t-> recherche2_aux t a (b||h=a);;
let recherche2 l a = recherche2_aux l a false;;
let lmax = 100;;
type 'a file = {tab : 'a array ; mutable longueur : int ; mutable tete : int};;
let filevide a  = {tab = Array.make lmax a; longueur = 0; tete =  0};;
let enfile a l = if l.longueur = lmax then failwith "file pleine"
					else (  (l.tab).((l.tete + l.longueur) mod lmax ) <- a; l.longueur <- l.longueur + 1);;
let rec enfilage n l = if n = 0 then failwith "ok" else enfile (lmax - n) l; enfilage (n - 1) l;;
let defile f = if f.longueur = 0 
		then failwith "file vide"
		else f.longueur <- f.longueur - 1;
			let a = (f.tab).(f.tete) in	
			f.tete <-(f.tete + 1) mod lmax;
			a;;
let rec avant_der l = match l with 
		|[]-> failwith "liste vide"
		|[a] -> failwith "liste trop courte"
		|a::b::[]-> a
		|h::t-> avant_der t;;
let rec il_existe p l = match l with 
	|[]-> false
	|h::t-> (p h)||il_existe p t;;
let rec pour_tout p l = match l with
	|[]-> true
	|h::t-> (p h)&&pour_tout p t;;
type ('a,'b) tablehach = {cellule : (('a*'b) list) array ; fonction : 'a -> int};;
let tablevide n f = {cellule  = Array.make n [] ;  fonction = f};;
let rec recherche_aux k l = match l with 
		|[]-> raise Not_found 
		|(q,c)::t-> if k = q then c else recherche_aux k t;;
let recherche_hach k h = recherche_aux k (h.cellule).(h.fonction k);;
let rec insere_aux k a l = match l with
		|[]-> [(k,a)]
		|(q,b)::t-> if q = k then insere_aux k a t else (q,b)::insere_aux k a t;;
let insere k a h = (h.cellule).(h.fonction k) <- (insere_aux k a ((h.cellule).(h.fonction k)));;

type 'a arbreb = ArbreVide | Noeud of 'a * 'a arbreb * 'a arbreb;;
let estVide a = a = ArbreVide;;
let rec parcourspre a = match a with
		| ArbreVide -> ()
		| Noeud (a,g,d) -> print_int a ; parcourspre(g); parcourspre(d);;
let rec parcourspost a = match a with
		| ArbreVide -> ()
		| Noeud (a,g,d) -> parcourspost g; parcourspost d; print_int a;;
let rec parcoursinf a = match a with
		| ArbreVide -> ()
		| Noeud (a,g,d)-> parcoursinf g; print_int a; parcoursinf d;;
let rec antec_syrac n p = match p with 
		| -1 -> ArbreVide
		| p -> if n mod 6 = 4 then Noeud (n, antec_syrac (2 * n)(p - 1) , antec_syrac ((n-1)/3) (p - 1))
				else Noeud (n, antec_syrac (2*n) (p-1), ArbreVide);;
				
let rec divise l = match l with
		| [] -> [],[]
		| [a] -> l,[]
		| h1::h2::t -> let l1,l2 = divise t in
					h1::l1,h2::l2;;
					
let rec fusion liste1 liste2 = match liste1,liste2 with
		| [], _ -> liste2
		| _, [] -> liste1
		| h1::t1,h2::t2 -> if h1 < h2 then h1::(fusion t1 liste2)
							else h2::(fusion liste1 t2);;
							
let rec trifusion liste = match liste with
		| [] -> liste
		| [a] -> liste
		| _ -> let liste1,liste2 = divise liste in
					fusion (trifusion liste1) (trifusion liste2);;
					
let rec exp x n = if n = 0 then 1 
				else  let y = exp (x*x) (n/2) in 
					if n mod 2 = 0 then y 
						else x*y;;
						
let rec partition pivot liste = match liste with
		| [] -> [],[]
		| h::t -> let liste1,liste2 = partition pivot t in
					if h < pivot then h::liste1,liste2
					else liste1,h::liste2;;
					
let rec trirapide liste = match liste with
		| [] -> []
		| h::t -> let liste1,liste2 = partition h t in
					(trirapide liste1)@h::(trirapide liste2);;
					
					
let rec vider liste1 liste2 =  match liste1,liste2 with
		| [], _ -> liste2
		| _,[] -> liste1
		| h::t,_ -> vider t (h::liste2);;
		
let inverser liste = vider liste [];;

let concatenation liste1 liste2 = vider (inverser liste1) liste2;;
		

let rec trirapide2 liste = match liste with
		| [] -> []
		| h::t -> let liste1,liste2 = partition h t in
					concatenation (trirapide liste1) (h::trirapide liste2);;
					

