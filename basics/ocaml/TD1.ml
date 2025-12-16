(*VERS LA PROGRAMMATION RECURSIVE*)

let a = ref 0 in
	for i = 1 to 30 
		do
		a := !a + i*i*i
	done;
	!a;;
	
let a = ref 2. in
	for i = 1 to 40 do
		a := (!a -. 1.)/. 2. +. 1. 
	done;
	!a ;;
	
let suite_u n =
	let u = ref 3. in
	for i = 0 to n do
		u := (!u -. 1.)*.(!u -. 1.)
	done;
	!u;;
	
let moyenne3 x y z = 
	(x +. y +. z)/. 3.;;
	
let hypothenuse x y =
	sqrt( x*.x +. y*.y);;
	
let divise a b =
	b mod a = 0;;
	
let factorielle n = 
	let a = ref 1 in
	for k = 1 to n do
			a := !a * k
		done;
	if n = 0
		then 1
	else
		!a
	;;

let premier n =
	let a = ref false in
	for k = 2 to n - 1 do
		a := !a || n mod k = 0 ;
	done;
	not !a;;
	
let racines a b c =
	let d = ref (b *. b -. 4. *. a *. c) in
		if !d < 0. then
			false, 0., 0.
		else 
			true, (-1.*.b -. sqrt(!d))/. 2.*.a,  (-1.*.b +. sqrt(!d))/. 2.*.a
	;;


(* Tableaux *)

let somme t =
	let s = ref 0 in
	for k = 0 to (Array.length t) - 1 do
		s := !s + t.(k)
	done;
	!s;;

let ppe t =
	let a = ref 0 in 
	for k = 0 to (Array.length t) - 1 do
		if t.(!a) > t.(k) 
			then a := k
	done;
	t.(!a);;
	
let permute1 t a =
	let n = Array.length t in
	let b = Array.make n t.(0) in (* en mettant t.(0) on fait du polyorphisme*)
	for k = 0 to n - 1 do
		b.( (k + a) mod n) <- t.(k)
	done,
	for k = 0 to  n - 1 do
		t.(k) <- b.(k)
		done;;



(*Programmation fonctionnelle et imperative*)


let rec somme n = if n = 0 then 0 else somme (n - 1) + n * n ;;
	
let puissance a n =
	let b = ref a in 
	for k = 1 to n - 1 do
		b := !b * a
	done;
	!b;;
	
let rec puissance_rec a n = if n = 0 then 1 else puissance_rec a (n - 1) * a ;;

let rec factorielle_rec n=
	if n = 0
		then 1
	else factorielle_rec (n - 1) * n;;
		
let rec suite_rec u u0 n =
	if n = 0
		then u0
	else suite_rec u u0 (n - 1) + u n;;
	
	
(*Reconnaissance de motifs*)

let multiple_2_3 x = 
	match (x mod 2,x mod 3) with
	|(0,0) -> "multiple de 2 et 3"
	|(0,m) -> "pair"
	|(n,0) -> "multiple de 3"
	|(n,m) -> "impair non multiple de 3"
	;;

let egalite m n = 
	match m - n with
	| 0 -> true
	| x -> false
	;;
	
let val_abs x = (*ne marche pas*)
	match x -. sqrt(x ** 2.) with
	| 0. -> x
	| a -> sqrt(x ** 2.)
	;;

let test m n =
	match (m - n, n) with 
	|(0,0) -> 1
	|(0,y) -> 0
	|(x,y) -> m + n
	;;

let rec somme_m n = match n with 
	| 0 -> 0
	| _ -> somme_m (n-1) + n*n ;;

let rec puissance_m a n = match n with
	| 0 -> 1
	| _ -> a * puissance_m a (n-1);;

let rec factorielle_m n = match n with
	| 0 -> 1
	| _ -> n * factorielle_m (n - 1);;

let rec suite_m u u0 n = match n with 
	| 0 -> u0
	| _ -> u(suite_m u u0 (n - 1));;
	
(*Suivi de recursivite*)

let rec fibo n = match n with 
	| 0 -> 1
	| 1 -> 1
	| _ -> fibo (n - 1) + fibo (n - 2);;

(*let rec fibo2 n = function  
	| 0 -> 1
	| 1 -> 1
	| _ -> fibo2 (n - 1), (fibo2 (n - 1) + fibo2 (n - 2)) ;;*)

(*Implementation des polynomes par des tableaux*)

let polynome nul p = 
		let n = ref Array.length p in;
		let bol = ref true in;
		for i = 0 to !n do
			bol := !bol && p.(i) = 0;
		done;
	!bol;;


(*let a = ref 0 in
for k = 1 to 30 
  do
    a := !a + k*k*k  
  done;
!a;;

(* commentaires *)

let suite_u n =
  let a = ref 3. in 
  for k = 1 to n
    do
    a := ( !a -. 1. ) ** 2.
    done;
  !a;;

let factorielle n = 
  let a = ref 1 in
  for k = 1 to n
    do
    a := !a * k
    done;
  !a;;

let moyenne a b c = 
  (a +. b +. c) /. 3. ;;

let divise a b = b mod a = 0 ;;

let premier n = 
  let m = ref 2 in
  while n mod !m != 0 && !m * !m < n
    do
    m := !m + 1
    done;
  !m * !m > n;;

let permute2 t k =
  let n = Array.length t in
  let t1 = Array.make n t.(0) in
  for i = 0 to n-1 
    do
      t1.((i+k)mod n) <- t.(i)
    done;
  t1;;
  
 let permute1 t k =
  let n = Array.length t in
  let t1 = Array.make n t.(0) in
  for i = 0 to n-1 
    do
      t1.((i+k)mod n) <- t.(i)
    done;
  for i = 0 to n-1 
    do
      t.(i) <- t1.(i)
    done;; 

let puissance a n =
  let x = ref 1. in
  for k = 1 to n 
  do
    x := !x *. a
  done;
  !x;;

let rec puissance a n =
  if n = 0 then 1.
  else a *. puissance a (n-1);;

*)
