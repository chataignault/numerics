let biparti adj =
  let n = Array.length adj in
  let f = ref [] in
  let t = Array.make n (-1) in
  let bol = ref true in

  let explore s =
    t.(s) <- 0;
    f := [ s ];
    while !f <> [] && !bol do
      let x = List.hd !f in
      f := List.tl !f;
      let l = ref adj.(x) in
      while !l <> [] do
        let y = List.hd !l in
        l := List.tl !l;
        if t.(y) = -1 then begin
          t.(y) <- 1 - t.(x);
          f := !f @ [ y ]
        end
        else if t.(y) = t.(x) then bol := false
      done
    done
  in

  let i = ref 0 in
  while !i < n && !bol do
    if t.(!i) = -1 then explore !i;
    incr i
  done;

  (!bol, t)

let vet =
  [|
    "cravate";
    "pantalon";
    "ceinture";
    "chaussettes";
    "montre";
    "chaussures";
    "chemise";
    "veste";
    "calecon";
  |]

let adj = [| []; [ 2; 5 ]; []; [ 5 ]; []; []; [ 0; 4; 7 ]; []; [ 1; 2; 4 ] |]

let tri_topologique adj =
  let n = Array.length adj in
  let t = Array.make n false in
  let res = ref [] in

  let rec explore s =
    if not t.(s) then begin
      t.(s) <- true;
      let l = ref adj.(s) in
      while !l <> [] do
        let y = List.hd !l in
        l := List.tl !l;
        explore y
      done;
      res := s :: !res
    end
  in

  for i = 0 to n - 1 do
    explore i
  done;

  !res

let l = ref (tri_topologique adj);;

while !l <> [] do
  print_string vet.(List.hd !l);
  l := List.tl !l;
  print_newline ()
done
;;

let chemins_el adj s t =
  let n = Array.length adj in
  let tab = Array.make n 0 in
  let ancien = Array.of_list (tri_topologique adj) in
  let nouveau = Array.make n 0 in
  for i = 0 to n - 1 do
    ancien.(nouveau.(i)) <- i
  done;
  let sp = nouveau.(s) and tp = nouveau.(t) in
  tab.(tp) <- 1;
  for i = tp - 1 downto sp do
    let l = ref adj.(ancien.(i)) in
    while !l <> [] do
      let x = nouveau.(List.hd !l) in
      l := List.tl !l;
      if x > i && x <= tp then
        (* sert a rien car si x pas dans intervalle tab.(x) vaut 0*)
        tab.(i) <- tab.(i) + tab.(x)
    done
  done
