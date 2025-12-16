(*STRUCTURES DE DONNEES*)

type couleur =  | Vert
				| Bleu
				| Jaune
	;;
	
let melange x y =   if x = y then x 
					else match x , y with
						|Bleu , Jaune -> Vert
						|Jaune, Bleu -> Vert 
						|Vert , c -> c
						|c, Vert -> c
						|_, _ -> Jaune
	;;

type nombre = Reel of float | Entier of int ;;

let somme x y = match x , y with
				|Reel a, Reel b -> Reel (a +. b)
				|Entier a, Entier b -> Entier (a + b)
				|Entier a, Reel b -> Reel (b +. float_of_int a)
				|Reel a, Entier b -> Reel (a +. float_of_int b)
	;;
	
type liste_entiers = Liste_Vide | Liste of int*liste_entiers;;

let ajoute a l = Liste(a,l);; (*on a defini les listes comme des produits cartesiens*)

let rec longueur = function
		|Liste_Vide -> 0
		|Liste (a,l) -> 1 + longueur l
	;;

type 'a liste = |Liste_Vide
				|Liste of 'a*('a liste)
	;;
	
type complexe = {re : float ; im : float};;

let i = {re = 0. ; im = 1.};;

let somme c1 c2 = {re = c1.re +. c2.re ; im = c1.im +. c2.im};;


type personne = {nom : string ; mutable age : int};;

let a = {nom = "toto" ; age = 6};;

type 'a pile = ('a list) ref;;

let est_vide p = (!p[]);;
let empile a p = p:= a::!p;;
let depile p = match !p with
				|[] -> failwith "Pile vide"
				|a::l -> p := l ; a 
	;;

type 'a pile = {mutable liste : 'a list};;

let pile_vide () = {liste = []};;
let empile a p = p.liste <- a::(p.liste);;
let depile p = match p.liste with
				|[] -> failwith "pile vide"
				|a::l -> p.liste <- l ; a
	;;
	
