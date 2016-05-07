open cartas

open carta

type carta = string * int

let mazo = [("E",1) ,("E",2) ,("E",3) ,("E",4) ,("E",5) ,("E",6), ("E",7), ("E",8) ,("E",9) ,("E",10) ,("E",11) ,("E",12),
            ("B",1) ,("B",2) ,("B",3) ,("B",4) ,("B",5) ,("B",6) ,("B",7) ,("B",8) ,("B",9) ,("B",10) ,("B",11) ,("B",12),
            ("O",1) ,("O",2) ,("O",3) ,("O",4) ,("O",5) ,("O",6) ,("O",7) ,("O",8) ,("O",9) ,("O",10) ,("O",11) ,("O",12),
            ("C",1) ,("C",2) ,("C",3) ,("C",4) ,("C",5) ,("C",6) ,("C",7) ,("C",8) ,("C",9) ,("C",10) ,("C",11) ,("C",12),
            (SID), (S,SWAP), (S,MAX), (S,MIN), (S,TOP), (S,PAR)];;

let rec crear mazo = 


let rec mazo_completo lista =
    let rec extraer acc n = function
      | [] -> raise Not_found
      | h :: t -> if n = 0 then (h, acc @ t) else extraer (h::acc) (n-1) t
    in
    let extraer_aleatorio lista len =
      extraer [] (Random.int len) lista
    in
    let rec aux acc lista len =
      if len = 0 then acc else
        let picked, rest = extraer_aleatorio lista len in
        aux (picked :: acc) rest (len-1)
    in
    aux [] lista (List.length lista);;

let string_a_carta (carta) =

let sacar_cartas (cartas cartas2) =

let poner_cartas cartas1 cartas2 =
  lista2 @ lista1
;;

let primer_carta cartas =
   match lista with
   | [] -> raise Not_found
   | h :: lista -> h
;;

let rec imprimir_mazo cartas =  
  let carta_a_string carta =

;;

let rec carta_maxima cartas =

;;

let rec carta_minima cartas =

;;

let rec cartas_pares cartas =

;;


let rec cartas_cantidad cartas =
  match cartas with
  | [] -> 0
  | x :: cartas -> 1 + cartas_cantidad cartas
;;





