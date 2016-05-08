open cartas

open carta

type carta = string * int

let mazo = [("E",1);("E",2);("E",3);("E",4);("E",5);("E",6);("E",7);("E",8);("E",9)
            ;("E",10);("E",11);("E",12);("B",1);("B",2);("B",3);("B",4);("B",5)
            ;("B",6);("B",7);("B",8);("B",9);("B",10);("B",11);("B",12);("O",1)
            ;("O",2);("O",3);("O",4);("O",5);("O",6);("O",7);("O",8);("O",9)
            ;("O",10);("O",11);("O",12);("C",1);("C",2);("C",3);("C",4);("C",5)
            ;("C",6);("C",7);("C",8);("C",9);("C",10);("C",11);("C",12)];;

(*funcion auxiliar para crear mazo*)
let split list n =
    let rec aux i acc = function
      | [] -> List.rev acc, []
      | h :: t as l -> if i = 0 then List.rev acc, l
                       else aux (i-1) (h :: acc) t  in
    aux n [] list;;

let crear mazo =
  let tu = split mazo 7 in
  match tu with
  |_ -> fst tu
;;



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
    aux [] mazo (List.length mazo)
;;

(*funciones auxiliares para string_a_carta in_of_string()*)
  let rec string_a_lista carta = match carta with
    | "" -> []
    | carta -> (String.get carta 0 ) :: (list_car (String.sub carta 1 ( (String.length carta)-1) ) )
;;

let list_a_string cl = String.concat "" (List.map (String.make 1) cl) ;;

let convertirla lista = 
  let carta = split lista 1 in
  let tipo,numero = carta in
  let tipo = list_a_string(tipo) in
  let numero = int_of_string(list_a_string(numero)) in
  let carta = tipo,numero in
  carta
;;

let cartas_iguales carta1 carta2 =
  let x,y = carta1 in
  let w,z = carta2 in
  let rbool = x = w && y = z in
  rbool
;;

let rec la_carta_esta cartas carta =
  match cartas with
  |[]  -> false
  | x :: cartas -> cartas_iguales x carta  || la_carta_esta cartas carta
;;

let string_a_carta cartas carta =
  let lista = string_a_lista carta in
  let cartaaux = convertirla(lista) in
  (*nose que poner acaaa!!!! :S !!!!!!!! por todo tira bardo*)
  cartaaux
;;

(*auxiliar para sacar carta*)
let rec quitar_elemento cartas elem =
    match cartas with
    | [] -> []
    | carta :: cartas ->
      let nuevalista = quitar_elemento cartas elem in
      if carta = elem then nuevalista else carta :: nuevalista
;;

let rec sacar_cartas cartas cartas2 =
   match cartas2 with
   |[] -> cartas
   | h :: cartas2 -> sacar_cartas(quitar_elemento cartas h) cartas2
;;


let poner_cartas cartas1 cartas2 =
  lista2 @ lista1
;;

let primer_carta cartas =
   match cartas with
   | [] -> raise Not_found
   | h :: cartas -> h
;;
(* auxiliar para imprimir*)
let convertir_carta_a_string carta =
  let x,y = carta in 
  let y = string_of_int y in
  let str = x^y in
  str
;;

let rec imprimir_mazo cartas = 
  match cartas with
  | [] -> ""
  | x :: cartas -> convertir_carta_a_string x ^ " " ^ imprimir_mazo cartas
;;

(*auxiliar para carta_maxima y carta_minima (compara -> carta1 < carta2) *)
let comparar_carta carta1 carta2 = 
  let x,y = carta1 in
  let w,z = carta2 in 
   match carta1 with
   |("e",_) -> w = "e" && y <= z
   |("b",_) -> w = "e" || w = "b" && y <= z          
   |("o",_) -> w = "e" || w = "b" || w = "o" && y <= z
   |("c",_) -> w = "e" || w = "b" || w = "o" || w = "c" && y <= z
;;

let rec carta_maxima cartas =
   match cartas with
   | h :: [] -> h
   | h :: cartas ->
   let aux = carta_maxima cartas in
   if comparar_carta h aux then aux else h
  ;;
 

let rec carta_minima cartas =
   match cartas with
   |h :: [] -> h
   | h :: cartas ->
   let aux = carta_minima cartas in
   if comparar_carta h aux then h else aux
;;
(*funcion auxiliar para cartas_pares*)
let carta_par carta =
    let y = snd carta in
    let par = y mod 2 in
    match par with 
    |0 -> true
    |_ -> false
;;

let rec cartas_pares cartas =
  match cartas with
  |[] -> []
  |x :: cartas ->
   let nuevalista = cartas_pares cartas in
   if carta_par x then x :: nuevalista else cartas
;;

let rec cartas_cantidad cartas =
  match cartas with
  | [] -> 0
  | x :: cartas -> 1 + cartas_cantidad cartas
;;





