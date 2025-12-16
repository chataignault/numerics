(*TABLES DE HACHAGE*)
type 'a contenu = Nil|Valeur of 'a;;
type 'a dico = {assoc : 'a contenu array};;
let n = 10;;
let dicovide () = {assoc = Array.make n Nil};;
let recherche d k = match (d.assoc).(k) with
		|Nil -> failwith "non trouve"
		|Valeur e -> e;;
let insere d k e  = (d.assoc).(k) <- Valeur e;;
let supprime d k = (d.assoc).(k) <- Nil;;

type ('a,'b) tablehach = {cellule : (('a*'b) list) array; fonction : 'a -> int};;

let tablevide m h = {cellule = Array.make m [] ; fonction = h};;
let rec recherche_aux k l = 
	 match l with
		|[]-> raise Not_found
		|(j,b)::t -> if k = j then b else recherche_aux k t;;
let recherche k t = recherche_aux k (t.cellule).((t.fonction) k);;
let rec supprime_aux k l = match l with
	|[]-> []
	|(j,a)::t-> if j = k then t else (j,a)::(supprime_aux k t);;
let rec insere_aux k a l = 
	match l with
		|[]-> [(k,a)]
		|(i,c)::t -> if i = k then (k,a)::t else (i,c)::(insere_aux k a t);;
let insere k a t = (t.cellule).(t.fonction k) <- insere_aux k a ((t.cellule).((t.fonction) k));;
let supprime k t = (t.cellule).(t.fonction k) <- supprime_aux k ((t.cellule).((t.fonction) k));;

(*Application a la memoïsation*)
let rec fibo1_aux n = if n = 0 then (1,1) else match fibo1_aux (n-1) with (a,b) -> (b,a+b);;
let fibo1 n = match fibo1_aux n with (a,b)-> a;;
let rec fibo2_aux n (a,b) = if n = 0 then (a,b) else fibo2_aux (n-1) (b,a+b);;
let fibo2 n = match fibo2_aux n (1,1) with (a,b) -> a;;
let m = 17;;
let h x = x mod 17;;
let t = tablevide m h;;
let rec fibo3 n = try recherche n t with 
		|Not_found -> (t.cellule).(h n) <- (n,fibo2 n)::(t.cellule).(h n); fibo2 n
		|_ -> recherche n t;; 
let rec combinaison n p = if n = p or p = 0 then 1 else combinaison (n-1) (p-1) + combinaison (n-1) p;;
let g (n,p) = n + p mod 17;;
let t2 = tablevide m g;;
let rec combinaison2 n p = if n = p || p = 0 then 1 else try recherche (n,p) t2 with 
	|Not_found -> (t2.cellule).(g (n,p) ) <-((n,p),(combinaison2 (n-1) (p-1)) + (combinaison2 (n-1) p))::(t2.cellule).(g (n,p)); recherche (n,p) t2
	|_-> recherche (n,p) t2;; 
	

