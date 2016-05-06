type numero = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12;;
type tipo = E | B | O | C;;
type especial = ID | SWAP | MAX | MIN | TOP | PAR;;

let mazo = [E1 ,E2 ,E3 ,E4 ,E5 ,E6 ,E7 ,E8 ,E9 ,E10 ,E11 ,E12,
            B1 ,B2 ,B3 ,B4 ,B5 ,B6 ,B7 ,B8 ,B9 ,B10 ,B11 ,B12,
            O1 ,O2 ,O3 ,O4 ,O5 ,O6 ,O7 ,O8 ,O9 ,O10 ,O11 ,O12,
            C1 ,C2 ,C3 ,C4 ,C5 ,C6 ,C7 ,C8 ,C9 ,C 10 ,C11 ,C12,
            S ID, S SWAP, S MAX, S MIN, S TOP, S PAR];;



(* 48 cartas normales*)
type cartas =
            tipo * numero
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
