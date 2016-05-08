type carta = string * int
type cartas = carta list

let mazo = [("E",1);("E",2);("E",3);("E",4);("E",5);("E",6);("E",7);("E",8);("E",9)
           ;("E",10);("E",11);("E",12);("B",1);("B",2);("B",3);("B",4);("B",5)
           ;("B",6);("B",7);("B",8);("B",9);("B",10);("B",11);("B",12);("O",1)
           ;("O",2);("O",3);("O",4);("O",5);("O",6);("O",7);("O",8);("O",9)
           ;("O",10);("O",11);("O",12);("C",1);("C",2);("C",3);("C",4);("C",5)
           ;("C",6);("C",7);("C",8);("C",9);("C",10);("C",11);("C",12)];;

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
  if String.length s < 2 || not (List.exists (fun (t,n) -> t = (String.sub s 0 1)) cs)
    then None
  else
    try
      let n = String.sub s 1 ((String.length s) - 1) in
      let n = int_of_string n in
      if not (List.exists (fun (t,i) -> i = n) cs) then None else Some (String.sub s 0 1, n)
    with
      | Failure "int_of_string" -> None;;

let string_of_carta (c : carta) : string =
  let x, y = c in
  let y = string_of_int y in
  x ^ y;;

let rec string_of_cartas (cs : cartas) : string =
  match cs with
  | [] -> ""
  | c::cs -> string_of_carta c ^ " " ^ string_of_cartas cs;;



(*auxiliar para sacar carta*)
let rec quitar_elemento cartas elem =
    match cartas with
    | [] -> []
    | carta :: cartas ->
      let nuevalista = quitar_elemento cartas elem in
      if carta = elem then nuevalista else carta :: nuevalista;;

let rec sacar_cartas cartas cartas2 =
   match cartas2 with
   | [] -> cartas
   | h :: cartas2 -> sacar_cartas(quitar_elemento cartas h) cartas2;;

let poner_cartas cartas1 cartas2 =
  let cartas = cartas1 @ cartas2 in
  cartas;;

let primera_carta (c : cartas) : carta option =
  match c with
  | [] -> None
  | c::cs -> Some c;;

let comparar_carta (c: carta) (t : carta) : bool =
  let valor_carta (c : carta) : int =
    let t,n = c in
    match t with
    | "E" -> 1000 * n
    | "B" -> 100 * n
    | "O" -> 10 * n
    | "C" -> 1 * n
    | _ -> 0
  in
  valor_carta c < valor_carta t;;

let rec carta_maxima (cartas :cartas) : carta option  =
   match cartas with
   |[] -> None
   | h :: [] -> h
   | h :: cartas ->
   let aux = carta_maxima cartas in
   if comparar_carta h aux then aux else h;;


let rec carta_minima cartas =
   match cartas with
   |h :: [] -> h
   | h :: cartas ->
   let aux = carta_minima cartas in
   if comparar_carta h aux then h else aux;;

(*funcion auxiliar para cartas_pares*)
let carta_par carta =
    let y = snd carta in
    let par = y mod 2 in
    match par with
    |0 -> true
    |_ -> false;;

let rec cartas_pares cartas =
  match cartas with
  |[] -> []
  |x :: cartas ->
   let nuevalista = cartas_pares cartas in
   if carta_par x then x :: nuevalista else cartas;;

let rec cartas_cantidad cartas =
  match cartas with
  | [] -> 0
  | x :: cartas -> 1 + cartas_cantidad cartas;;
