let rec element x l = match l with 
		| [] -> false
		| h::t -> if h = x then true else element x t;;
let rec traitement l f = match l with
		| [] -> []
		| h::t -> (f h)::(traitement t f);;
exception Suivant;;
let tribulles t =
	for k = 0 to Array.length(t) - 1 do
		try 
			let n = ref 0 in 
			for i = 0 to Array.length(t) - 2 do
				if t.(i) > t.(i + 1) then begin
					let x = t.(i + 1) in 
					t.(i + 1) <- t.(i); t.(i) <- x; n := !n + 1; end
			done;
			if !n = 0 then raise Suivant
		with | Suivant -> ()
	done; t;;
let rec divise_aux n l m = match l with
		| [] -> []
		| h::t -> if n = 0 then h::m, t else divise_aux (n-1) t h::m ;;
let rec fusion l1 l2 = match l1,l2 with
		| h1::t1, h2::t2 -> if h1 < h2 then h1::(fusion t1 l2) else h2::(fusion l1 t2)
		| [], h::t -> h::t
		| h::t, [] -> h::t;;
type entiers = int list;;
type triplet = entiers * int * entiers;;
let rec eclater e l = 
		match l with
			| [] -> [], e, []
			| t::q -> 
				let g, v, d = (eclater e q) in 
				if (t <= v) then t::g, v, d
				else g, v, t::d;;
let rec trier l = match l with 
		| [] -> []
		| t::q -> 
			let (g, v, d) = (eclater t q) in 
			((trier g)@(v::(trier d)));;
(*S'AIDER DU TYPAGE AVANT DE COMMENCER A ECRIRE*)
type mot = char list;;
type mots = mot list;;
let distinguer m1 m2 = match m1, m2 with
		| c1::t1 , c2::t2-> c1 < c2
		| _ , _ -> false;;
let rec vider l1 l2 = match l1 with
		| [] -> l2
		| h::t -> vider t (h::l2);;
let inverser l1 = vider l1 [];;
let ajouter mot1 mot2 = vider (inverser mot1) mot2;;
let rec prefixer mot seq = match seq with
		| [] -> []
		| mot1::seq1 -> (ajouter mot mot1)::prefixer mot seq1;;
(*fonction prefixer de complexite lineaire en comptant seulement le nombre d'appel recursif, mais pas tres judicieux comme choix :*)
(*Sinon deux fois la longeueur du mot 'mot' en appels recursifs pour vider, quadratique en (la longueur de mot)*(la longueur de seq), TETA(|mot|*|seq|)*)
type patricia = Noeud of bool * fils and fils = (mot * patricia) list;;
(*arbres Patricia valides car mots ordones strictements => pas deux fois le meme mots, et noeuds terminaux*)
let creer mot = match mot with 
		| [] -> Noeud(true, [])
		| _ -> Noeud (false,[(mot, Noeud (true, []))]);;
let rec compter pat = match pat with
		| Noeud (true, f) -> 1 + compter_fils f
		| Noeud (false, f) -> compter_fils f
	and compter_fils f = match f with
		| [] -> 0
		| (_,pat)::t -> (compter_fils t) + (compter pat);;
(*on utilise une DEFINITION RECURSIVE CROISEE*)
let concatenation l1 l2 = vider (vider l1 []) l2;;
let rec extraire_aux mot pat = match pat with
		| Noeud(true, f) -> mot::(extraire_fils f)
		| Noeud (false, f) -> extraire_fils f
	and extraire_fils f = match f with 
		| [] -> []
		| (mot, pat)::t -> concatenation (extraire_fils t) (prefixer mot (extraire_aux mot pat));;
let extraire pat = extraire_aux [] pat;;
let rec valider_aux pat bol mot = match pat with
		| Noeud(true, f) -> if f = [] then true else valider_fils f mot bol (*Cas d'un noeud terminal*)
		| Noeud (false, f) -> valider_fils f mot bol (*et non terminal*)
	and valider_fils f mot1 bol = match f with 
		| [] -> false (*Le noeud ne devrait pas etre terminal*)
		| [(mot2,pat)] -> valider_aux pat ((distinguer mot1 mot2) && bol) mot2 (*initialisation*)
		| (mot2,pat)::t -> (valider_aux pat ((distinguer mot1 mot2) && bol) mot2)&&(valider_fils t mot1 bol);; 
let valider pat = match pat with
		| Noeud (_, []) -> false (*Cas arbre Patricia vide*)
		| Noeud (_, (mot,_)::t) -> valider_aux pat true mot;;
let accepter mot pat = let seq = extraire pat in 
		let rec accepter_list seq mot = match seq with
				| [] -> false
				| mot1::seq1 -> (accepter_mot mot mot1) || (accepter_list seq1 mot) 
		and accepter_mot mot1 mot2 = match mot1, mot2 with
				| [],[] -> true
				| c1::q1,c2::q2 -> if (distinguer mot1 mot2) || (distinguer mot2 mot1) then false else accepter_mot q1 q2 
				| _, _ -> false in
		if (mot = []) then failwith "pas de mot"
		else
		accepter_list seq mot;;
let tete l = match l with 
		| [] -> failwith "liste vide"
		| h::t -> h;;
let queue l = match l with 
		| [] -> failwith "liste vide"
		| h::t -> t;;
let rec en_commun_aux l mot1 mot2 = if ((tete mot1) = (tete mot2))
									then en_commun_aux ((tete mot1)::l) (queue mot1) (queue mot2)
									else (l, mot1, mot2);;
let en_commun mot1 mot2 = let l, reste1, reste2 = en_commun_aux [] mot1 mot2 in (vider l []), reste1, reste2;; (*On remet dans le bon sens*)
let rec ajouter mot pat = match pat with 
		| Noeud (true, []) -> Noeud (true, [mot, Noeud (true, [])])
		| Noeud (bol,f) -> Noeud (bol, (ajouter_fils mot f))
	and ajouter_fils mot f = match f with
		| [] -> [(mot, Noeud (true, []))]
		| (mot1, Noeud (bol, fils))::t -> if tete mot = tete mot1 then
										let (com, r1, r2) = (en_commun mot mot1) in
										(com, Noeud (bol && false, ajouter_fils r1  (ajouter_fils r2 fils)))::t
										else (mot1, Noeud (bol, fils))::(ajouter_fils mot t);;
let rec fusionner_aux seq a2 = match seq with
		| [] -> a2
		| h::t -> fusionner_aux t (ajouter h a2);;
let fusionner a1 a2 = let l = extraire a1 in fusionner_aux l a2;;

		
