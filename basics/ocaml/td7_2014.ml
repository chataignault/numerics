type auto_determ = { initial : int ; terminaux : int list; delta : (int vect) vect};;

type auto_gen = {  initiaux : int list; finaux : int list; Delta : ((int*int) list) vect};;

(*----------------------------------------------------------*)

let rec insere a l = match l with
  | [] -> [a]
  | b::q when a<b -> a::l
  | b::q when a=b -> l
  | b::q -> b::(insere a q);;
 
let rec fusionne l1 l2 = match (l1,l2) with
  | [] , _ -> l2
  | _ , [] -> l1
  | a::q1,b::q2 when a<b -> a::(fusionne q1 l2)
  | a::q1,b::q2 when b<a -> b::(fusionne q2 l1)
  | a::q1,b::q2 -> a::(fusionne q1 q2);;

let rec secoupent l1 l2 = match (l1,l2) with
  | [] , _ -> false
  | _ , [] -> false
  | a::q1,b::q2 when a<b -> secoupent q1 l2
  | a::q1,b::q2 when b<a -> secoupent q2 l1
  | a::q1,b::q2 -> true;;


let rec ajoute a l acc = match l with
  | [] -> acc
  | b::q -> (a,b)::(ajoute a q acc);;

let rec produit l1 l2 = match l1 with
  | [] -> []
  | a::q -> ajoute a l2 (produit q l2);;

(*--------------------------------------------------*)

let appartient mot auto =
  let l=ref mot and q=ref auto.initial in
  while (!q <> -1) && (!l <> []) do
    q := auto.delta.(!q).(hd !l);
    l := tl(!l);
  done;
  if !q = -1 then false else mem !q auto.terminaux;; 

let rec atteignables lis a auto =
  let l=ref lis and ll=ref [] and res=ref [] in 
  while !l<>[] do
    let q=hd(!l) in
    l:=tl(!l);
    ll:=auto.Delta.(q);
    while !ll<>[] do
      let (b,r)=hd(!ll) in
      if b=a then res:= insere r !res;
      ll:=tl(!ll);
    done;
  done;
  !res;;

let appartientgen mot auto =
  let atteints=ref auto.initiaux and l=ref mot in
  while !l<>[] do
    let a = hd(!l) in
    l:=tl(!l);
    atteints:=atteignables !atteints a auto;
  done;
  secoupent !atteints auto.finaux;;

(*--------------------------------------------------*)

type expr_rat = Eps | Lettre of int | Etoile of expr_rat | Concat of expr_rat*expr_rat | Sum of (expr_rat*expr_rat);;

type lang_local = { I : int list; S : int list; F : (int*int) list; vide : bool};;

let linearise expr = 
  let res = ref [] and c = ref 0 in
  let rec aux e = match e with
    | Lettre k -> begin res := k::!res; incr c; Lettre(!c);end
    | Etoile ee -> Etoile(aux ee)
    | Concat (e1,e2) -> let ne1=aux e1 in let ne2=aux e2 in Concat(ne1,ne2)
    | Sum (e1,e2) ->  let ne1=aux e1 in let ne2=aux e2 in Sum(ne1,ne2)
    | Eps -> e;
  in
  let ne = aux expr in (ne,rev (!res),!c);;

let rec calcule_lang_local exprlin = match exprlin with
  | Eps -> {I=[];S=[];F=[];vide=true}
  | Lettre k -> {I=[k];S=[k];F=[];vide=false}
  | Sum (e1,e2) -> let l1=calcule_lang_local e1 and l2=calcule_lang_local e2 in
		   {I=fusionne l1.I l2.I;S=fusionne l1.S l2.S;
		    F=fusionne l1.F l2.F;vide=(l1.vide || l2.vide)}
  | Concat (e1,e2) -> (let l1=calcule_lang_local e1 and l2=calcule_lang_local e2 in
		     match (l1.vide,l2.vide) with
		     | true,true -> {I=fusionne l1.I l2.I;S=fusionne l1.S l2.S;
				     F=fusionne (fusionne l1.F l2.F) (produit l1.S l2.I);
				     vide=(l1.vide && l2.vide)}
		     | true,false -> {I=fusionne l1.I l2.I;S=l2.S;
				     F=fusionne (fusionne l1.F l2.F) (produit l1.S l2.I);
				     vide=(l1.vide && l2.vide)}
		     | false,true -> {I=l1.I;S=fusionne l1.S l2.S;
				     F=fusionne (fusionne l1.F l2.F) (produit l1.S l2.I);
				     vide=(l1.vide && l2.vide)}
		     | _ -> {I=l1.I;S=l2.S;
			     F=fusionne (fusionne l1.F l2.F) (produit l1.S l2.I);
			     vide=(l1.vide && l2.vide)})
  | Etoile e ->  let l = calcule_lang_local e in
	       {I=l.I;S=l.S;F=fusionne l.F (produit l.S l.I); vide=true};;

let calcule_auto_local lang c = 
  let term=ref lang.S in
  if lang.vide then term := 0 :: !term ;
  let auto={initial = 0; terminaux = !term; delta = make_matrix (c+1) c (-1)} in
  let l=ref lang.I in
  while !l<>[] do
    auto.delta.(0).(hd(!l) - 1) <- hd(!l);
    l:=tl(!l);
  done;
  let lf=ref lang.F in
  while !lf<>[] do
    let (a,b) = hd(!lf) in
    auto.delta.(a).(b-1) <- b;
    lf:=tl(!lf);
  done;
  auto;;

let automate expr = 
  let (ne,marque,c)=linearise expr in
  let auto = calcule_auto_local (calcule_lang_local ne) c in
  let table=vect_of_list marque in
  let resultat={initiaux=[0];finaux=auto.terminaux;Delta=make_vect (c+1) []} in
  for i=0 to c do
    for j=0 to c-1 do
      if auto.delta.(i).(j)<>(-1) then 
	resultat.Delta.(i)<-insere (table.(j),auto.delta.(i).(j)) resultat.Delta.(i);
    done;
  done;
  resultat;;

let expression = Concat(Lettre(0),Etoile(Sum(Lettre(0),Lettre(1))));;

let exprlin = let (ne,r,c)=linearise expression in ne;;
calcule_lang_local exprlin;;

automate expression;;


		
