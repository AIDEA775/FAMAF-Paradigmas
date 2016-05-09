type carta = string * int
type cartas = carta list

let mazo = [("E",1);("E",2);("E",3);("E",4);("E",5);("E",6);("E",7);("E",8);("E",9)
           ;("E",10);("E",11);("E",12);("B",1);("B",2);("B",3);("B",4);("B",5)
           ;("B",6);("B",7);("B",8);("B",9);("B",10);("B",11);("B",12);("O",1)
           ;("O",2);("O",3);("O",4);("O",5);("O",6);("O",7);("O",8);("O",9)
           ;("O",10);("O",11);("O",12);("C",1);("C",2);("C",3);("C",4);("C",5)
           ;("C",6);("C",7);("C",8);("C",9);("C",10);("C",11);("C",12)
           ;("S",1);("S",2);("S",3);("S",4);("S",5);("S",6)];;

let crear_mazo (m : cartas) : cartas =
  let rec tomar (m : cartas) (i : int) : cartas =
    match i with
    | 0 -> []
    | _ ->  match m with
            | [] -> []
            | x::xs -> x :: tomar xs (i-1)
  in
  tomar m 7;;

let rec mazo_completo unit =
  let rec extraer acc n = function
    | [] -> raise Not_found
    | h :: t -> if n = 0 then (h, acc @ t) else extraer (h::acc) (n-1) t
  in
  let extraer_aleatorio mazo len =
    extraer [] (Random.int len) mazo
  in
  let rec aux acc mazo len =
    if len = 0 then acc else
      let picked, rest = extraer_aleatorio mazo len in
      aux (picked :: acc) rest (len-1)
  in
  aux [] mazo (List.length mazo);;

let carta_of_string (cs : cartas) (s : string) : carta option =
  let especial (s : string) : int =
    match s with
    | "ID"   -> 6
    | "SWAP" -> 5
    | "MAX"  -> 4
    | "MIN"  -> 3
    | "TOP"  -> 2
    | "PAR"  -> 1
    | _      -> 0
  in
  let ct = String.sub s 0 1 in
  if String.length s < 2 || not (List.exists (fun (t,_) -> t = ct) cs)
    then None
  else
    begin
      let n = String.sub s 1 ((String.length s) - 1) in
      if ct = "S" then
        let n = especial n in
        if not (List.exists (fun (t,i) -> t = ct && i = n) cs) then None
        else Some (ct, n)
      else
        try
          let n = int_of_string n in
          if not (List.exists (fun (t,i) -> t = ct && i = n) cs) then None
          else Some (ct, n)
        with
          | Failure "int_of_string" -> None
    end;;

let string_of_carta (c : carta) : string =
  let especial (n : int) : string =
    match n with
    | 6 -> "ID"
    | 5 -> "SWAP"
    | 4 -> "MAX"
    | 3 -> "MIN"
    | 2 -> "TOP"
    | 1 -> "PAR"
    | _ -> assert false
  in
  let x, y = c in
  if x = "S" then x ^ (especial y)
  else x ^ (string_of_int y);;

let rec string_of_cartas (cs : cartas) : string =
  match cs with
  | [] -> ""
  | c::cs -> string_of_carta c ^ " " ^ string_of_cartas cs;;

let rec sacar_cartas (cs : cartas) (sacar : cartas) =
   List.filter (fun x -> not (List.mem x sacar)) cs;;

let poner_cartas (cs1 : cartas) (cs2 : cartas) = cs1 @ cs2;;

let primera_carta (c : cartas) : carta option =
  match c with
  | [] -> None
  | c::cs -> Some c;;

let comparar_carta (c: carta) (t : carta) : bool =
  let valor_carta (c : carta) : int =
    let t,n = c in
    match t with
    | "E" -> 2173 * n
    | "B" -> 181 * n
    | "O" -> 15 * n
    | "C" -> 1 * n
    | _ -> 0
  in
  valor_carta c < valor_carta t;;

let rec carta_maxima (cs :cartas) : carta option  =
  match cs with
  | [] -> None
  | [c] -> Some c
  | c::(s::cs) when fst c = "S" -> carta_maxima (s::cs)
  | c::(s::cs) when fst s = "S" -> carta_maxima (c::cs)
  | c::(s::cs) -> if comparar_carta c s then carta_maxima (s::cs) else carta_maxima (c::cs);;

let rec carta_minima (cs :cartas) : carta option =
  match cs with
  | [] -> None
  | [c] -> Some c
  | c::(s::cs) when fst c = "S" -> carta_minima (s::cs)
  | c::(s::cs) when fst s = "S" -> carta_minima (c::cs)
  | c::(s::cs) -> if comparar_carta c s then carta_minima (c::cs) else carta_minima (s::cs);;

let rec cartas_pares (cs : cartas) =
  List.filter (fun (t, n) -> t != "S" && n mod 2 = 0) cs;;

let cartas_cantidad (cs : cartas) = List.length cs;;

let es_especial (c : carta) = (fst c = "S");;
