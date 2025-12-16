(*ARBRES BINAIRES, PARCOURS EN PROFONDEUR*)
type 'a liste = Listevide | Liste of 'a * ('a liste);;
type 'a arbreb = ArbreVide | Noeud of 'a * ('a arbreb) * ('a arbreb);;

(*ordre prefixe*)
let rec affiche_pre a = match a with
	|ArbreVide -> ()
	|Noeud (e, g, d) -> print_int e; affiche_pre g; affiche_pre d;;
(*ordre postfixe*)
let rec affiche_post a = match a with
	|ArbreVide  -> ()
	|Noeud (e, g, d) -> affiche_post g; affiche_post d; print_int e;;
(*ordre infixe*)
let rec affiche_in a = match a with
	|ArbreVide -> ()
	|Noeud (e, g, d)-> affiche_in g; print_int e; affiche_in d;;

(*ARBRES*)
let rec antec_syrac n p =
		if p = 0 then Noeud (n, ArbreVide, ArbreVide) else 
		begin if (n - 4) mod 6 = 0 
			then Noeud (n, antec_syrac (2*n) (p-1) , antec_syrac ((n-1)/3) (p-1))
			else Noeud (n, antec_syrac (2*n) (p-1) , ArbreVide) end;;
(*ordre perfixe car dans le type on a mis le noeud en premier*)
			
(*Parcours en largeur*)
(*FILE EN IMPERATIF*)   
type 'a file = {mutable avant : 'a list; 
                mutable arriere : 'a list};;

let rec vider l1 l2 = match l1 with
  |[] -> l2
  |h::t -> vider t (h::l2);;
let inversion l = vider l [];;


          
let filevide () = {avant = []; arriere = []};;
let enfile a f = f.arriere <- a::(f.arriere);;
let defile f = match f.avant with 
    |[] -> 
       begin
         match inversion f.arriere with
          |[] -> failwith "file vide"
          |h::t -> f.avant <-t; f.arriere <- [];h
         end
    |h::t -> f.avant <- t; h;;    
    

let liste_en_largeur arbre = 
	let f = filevide() in
	let rec largeur_aux () = (*pas besoin de mettre d'argument car f est deja une variable globale dans la fonction*)
		match defile f with 
			|ArbreVide -> if f = filevide() then [] else largeur_aux ();
			|Noeud(n,g,d) -> enfile g f; enfile d f; n::largeur_aux(); 	
	in
	enfile arbre f;
	largeur_aux ();;
	
let profondeur_min arbre =
	let f = filevide() in
	let rec profondeur_aux n =
		if f = filevide() then n else
		match defile f with
			|ArbreVide -> n - 1;
			|Noeud(m,g,d) -> enfile g f; enfile d f; profondeur_aux(n + 1);
	in
	enfile arbre f;
	profondeur_aux 0;; 
	
let profondeur_min arbre = 
		let f = filevide () in 
		let rec profondeur_aux () = 
			match defile f with 
				| ArbreVide -> if f = filevide() then 0 else profondeur_aux ()
				| Noeud (e,g,d) -> enfile g f; enfile d f; 1 + profondeur_aux (* a tester*)
		in 
		enfile arbre f;
		profondeur_aux f;;
	
(*AVEC STRUCTURE DE PILE*)
type 'a pile = {mutable pile : 'a list};;
let empile a p = p.pile <- a::(p.pile);;
let depile p = match p.pile with
		|[]-> failwith "pilevide"
		|h::t-> p.pile <- t; h;;
let pilevide () = {pile = []};;
let liste_avec_pile a = 
	let p = pilevide() in
	let rec liste_avec_pile_aux () =
		if p = pilevide() then [] else
		match depile p with
			|ArbreVide -> liste_avec_pile_aux ()
			|Noeud(x,g,d) -> empile d p; empile g p; x::liste_avec_pile_aux (); in
	empile a p;
	liste_avec_pile_aux ();;
(*On a avec la structure de pile un ordre prefixe*)

	
(*PARCOURS EN LARGEUR*)

let liste_en_largeur arbre =
   let f = filevide () in
   let rec largeur_aux () =
      if f = filevide() then []
      else
      match defile f with
        |ArbreVide -> largeur_aux ()
        |Noeud (e, g, d) -> enfile g f;
                            enfile d f;
                            e::largeur_aux()
      
   in
   enfile arbre f;
   largeur_aux ();;