type 'a pile = {mutable liste : 'a list}
let pilevide () = {liste = []};;
let empile a p = p.liste<-a::(p.liste);;
let depile p = match p.liste with 
	|[] -> failwith "pile vide"
	|h::t -> p .liste<-t;h;;
	
(*3.2*)

type eap_elt = Nb of float|Op of (float->float->float)|Fct of (float->float);;
let eval t = let n = Array.length(t) and p = pilevide () in
		for k=0 to (n - 1) do
			match t.(k) with
				|Nb x -> empile x p
				|Op x -> empile (x (depile p) (depile p)) p
				|Fct x -> empile (x (depile p)) p
			done;
		depile p
	;;

(*il suffit de rendre le type polymorphe:*)

type 'a elt = Nb2 of 'a|Op2 of ('a->'a->'a)|Fct2 of ('a->'a)
let eval_poly t = let n = Array.length(t) and p = pilevide () in
		for k=0 to n-1 do
			match t.(k) with
				|Nb2 x -> empile x p
				|Op2 x -> empile (x (depile p) (depile p)) p (*attention a l'ordre d'evalutaion a tester*)
				|Fct2 x -> empile (x (depile p)) p
			done;
		depile p
	;;

(*3.3*)
let rec vider l1 l2 = match l1 with
	|[] -> l2
	|h::t -> vider t (h::l2);;
let inverse l = vider l [];; 
type 'a file = {avant : 'a list ; arriere : 'a list};;
let filevide = {avant = [] ; arriere = []};;
let enfile a f = {avant = f.avant ; arriere = a::(f.arriere)};;
let defile f = match f.avant with 
			|[]-> begin 
				match inverse f.arriere with
					|[]-> failwith "file vide"
					|h::t -> {avant = []; arriere = inverse t }
				end
			|h::t -> {avant = t; arriere = f.arriere}
	;;

let tete f = match f.arriere with 
	|[] -> begin 
		match inverse f.avant with
			|[] -> failwith "file vide"
			|h::t-> h
		end
	|h::t-> h;;

(*3.4*)
type 'a fileimp = {mutable avant : 'a list ; mutable arriere : 'a list};;
let filevideimp () = {avant = [] ; arriere = []};;
let enfileimp a f = match f.arriere with
	|[]-> f.arriere<-[a]
	|h::t-> f.arriere<-a::h::t;;
let defileimp f = match f.avant with 
	|[]-> begin
		match inverse f.arriere with
			|[] -> failwith "liste vide"
			|h::t-> f.arriere<-inverse t; h
		end
	|h::t-> f.avant<-t; h;;
let teteimp f = match f.arriere with 
	|[]-> begin 
		match inverse f.avant with
			|[] -> failwith "file vide"
			|h::t-> h
		end
	|h::t-> h;;


(*3.5*)

type 'a pile = {mutable liste : 'a list}
let pilevide () = {liste = []};;
let empile a p = p.liste <- a::(p.liste);;
let depile p = match p.liste with
		|[]-> failwith "pile vide"
		|h::t -> p.liste <- t; h;;
let tete p = match p.liste with 
		|[]-> []
		|h::t-> h;;
let rec vider l1 l2 = match l1 with 
				|[]-> l2
				|h::t-> vider t (h::l2);;
let inverse l = vider l [];;
let queue p = match (inverse (p.liste)) with 
		|[]-> []
		|h::t -> h;;
let rec min = function
			|[]-> failwith "liste vide"
			|[a] -> a
			|h::t -> let m = min t in if h < m then h else m;;
let rec suppr x l = match l with 
			|[]-> []
			|h::t-> if h = x then suppr x t else h::(suppr x t)
	;;

let hamming n = 
		let h2 = pilevide() in
		let h3 = pilevide() in
		let h5 = pilevide() in
		empile 1 h2;
		empile 1 h3;
		empile 1 h5;
		let ham = ref [] in
			for k = 0 to (n-1) 
				do
				let a = (queue h2) in
				let b = (queue h3) in 
				let c = (queue h5) in
				let x = min [a;b;c] in
					h2.liste <- (suppr x h2.liste);
					h3.liste <- (suppr x h3.liste);
					h5.liste <- (suppr x h5.liste);
				ham := x::(!ham);
				empile (2*x) h2;
				empile (3*x) h3;
				empile (5*x) h5;
				done ;
	!ham;;

(*(*EXEMPLES DE COURS*)

(*Type somme*)	
type liste_entiers = Listevide | Liste of int*liste_entiers;;
let ajoute a l = Liste (a,l);;
let rec longueur = function
	|Listevide -> 0
	|Liste (a*t) -> 1 + longueur t;;
(*Avec du polymorphisme*)
type 'a liste = Listevide | Liste of 'a*('a liste);;

(*Type produit*)
type complexe = {re : float ; im : float}
let i = {re = 0. ; im = 1.};;
let somme c1 c2 = {re = c1.re +. c2.re ; c1.im +. c2.im};;
type personne = {nom : string ; mutable age : int};;
let a = {nom = toto ; age = 6}
a.age <- a.age + 1;;

(*Files, structure imperative*)
let lmax = 100;;
type 'a file = {tab: 'a array ; mutable tete: int ; mutable longueur : int};;
let filevide a = {tab = Array.make lmax a ; tete = 0 ; longueur = 0};;
let enfile e f = if f.longueur = lmax
		then failwith "liste saturee"
		else begin (f.tab).((f.tete + f.longueur) mod lmax ) <- e;
			f.longueur <- (f.longueur + 1) end;;
let defile f = if f.longueur = 0
		then failwith "file vide"
		else begin let a = (f.tab).(f.tete) in 
			f.tete <- (f.tete + 1) mod lmax;
			f.longueur <- f.longueur - 1;
			a
	end;;
*)