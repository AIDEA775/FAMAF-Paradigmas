type numero = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12;;
type tipo = E | B | O | C;;
type especial = ID | SWAP | MAX | MIN | TOP | PAR;;

(* 48 cartas normales*)
type cartas =
            | tipo * numero
            | S especial;;


let es_par (x) = x mod 2 = 0;;

let rec sacar_carta lista_cart carta =
  match lista_cart with
  | [] -> []
  | elem :: lista_cart ->
    let new_l = sacar_carta lista_cart carta in
    if elem = carta then new_l else elem :: new_l;;

let rec tomar_pares lista_mazo =
  match lista_mazo with
  |[]->[]
  | elem :: lista_mazo ->
    let nueva_lista = tomar_pares lista_mazo in
    if es_par elem then elem :: nueva_lista else nueva_lista;;

let top lista_mazo lista_jugador =
  match lista_mazo with
  | [] -> lista_jugador
  | x :: lista_mazo -> x ::lista_jugador;;

let min lista_mazo lista_jugador =
