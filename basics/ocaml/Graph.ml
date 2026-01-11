let couples_en_liste couples n =
  let vect = Array.make n [] in
  let rec aux t =
    match t with
    | [] -> vect
    | (a, b) :: q ->
        vect.(a) <- b :: vect.(a);
        aux q
  in

  aux couples

let vect_adj n lis =
  let adj = Array.make n [] in
  let l = ref lis in

  while !l <> [] do
    let i, j = List.hd !l in
    adj.(i) <- j :: adj.(i);
    l := List.tl !l
  done;

  adj

let vectcoadj vadj =
  let n = Array.length vadj in
  let coadj = Array.make n [] in

  for i = 0 to n - 1 do
    let l = ref vadj.(i) in
    while !l <> [] do
      let j = List.hd !l in
      coadj.(j) <- i :: coadj.(j);
      l := List.tl !l
    done
  done;

  coadj

let rec insere i lis =
  match lis with
  | [] -> [ i ]
  | a :: q when i < a -> i :: lis
  | a :: q when i = a -> lis
  | a :: q -> a :: insere i q

let desoriente vadj =
  let n = Array.length vadj in
  let res = Array.make n [] in

  for i = 0 to n - 1 do
    let l = ref vadj.(i) in
    while !l <> [] do
      let j = List.hd !l in
      insere i res.(j);
      insere j res.(i);
      l := List.tl !l
    done
  done;

  vadj "" "EXERCICE 2" "" ""
    "Xk[i,j] vaut true ssi il existe un chemin de i a j dont les sommets \
     intermediaires sont dans [|0,k|]\n\
     Xn vaut Acc "
    ""

let chemin poids =
  let n = Array.length poids in
  let pm = Array.make_matrix n n 0. in

  for k = 0 to n - 1 do
    for i = 0 to n - 1 do
      if k = i then pm.(k).(k) <- 0. else pm.(k).(i) <- poids.(k).(i)
    done
  done;

  for k = 1 to n - 1 do
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        pm.(i).(j) <- min pm.(i).(j) (pm.(i).(k) + pm.(k).(j))
      done
    done
  done;
  pm

let chemin poids =
  let n = Array.length poids in
  let pm = Array.make_matrix n n 0. and i = Array.make_matrix n n (-1) in

  for k = 0 to n - 1 do
    for i = 0 to n - 1 do
      pm.(k).(i) <- poids.(k).(i)
    done;
    pm.(k).(k) <- 0.
  done;

  for k = 1 to n - 1 do
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        let a = pm.(i).(k) + pm.(k).(j) in
        if a < pm.(i).(j) then pm.(i).(j) <- a;
        i.(i).(j) <- k
      done
    done
  done;

  (pm, i)

let chemin_min poids i j =
  let p, inter = chemin poids in
  let rec aux i j =
    match inter.(i).(j) with -1 -> [ j ] | k -> aux i k @ aux k j
  in
  if p.(i).(j) > 5000000 then failwith "pas de chemin" else i :: aux i j

let chemin_min poids_bis i j =
  let p, inter = chemin poids in
  let res = ref [] in
  let rec aux i j =
    match inter.(i).(j) with
    | -1 -> res := j :: !res
    | k -> begin
        aux k j;
        aux i k
      end
  in
  if p.(i).(j) > 5000000 then failwith "pas de chemin"
  else begin
    aux i j;
    i :: !res
  end

let floyd g =
  let n = Array.length g in
  let acc = Array.make_matrix n n false in

  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      if g.(i).(j) then acc.(i).(j) <- true
    done;
    acc.(i).(i) <- true
  done;

  for k = 0 to n - 1 do
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        acc.(i).(j) <- acc.(i).(j) || (acc.(i).(k) && acc.(k).(j))
      done
    done
  done;

  acc

let floyd_poids g =
  let n = Array.length g in
  let acc = Array.make_matrix n n infinity in

  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      if g.(i).(j) <> infinity then acc.(i).(j) <- g.(i).(j)
    done;
    acc.(i).(i) <- 0.
  done;

  for k = 0 to n - 1 do
    for i = 0 to n - 1 do
      for j = 0 to n - 1 do
        if acc.(i).(j) > acc.(i).(k) +. acc.(k).(j) then
          acc.(i).(j) <- acc.(i).(k) +. acc.(k).(j)
      done
    done
  done;

  acc
