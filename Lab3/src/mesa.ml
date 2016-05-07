open Jugadores
open Cartas

type mesa = {jugadores : jugador list; mazo : cartas list};;

let rec cargar_jugadores (i : int) : jugador list =
  match i with
  | 0 -> []
  | _ ->  let nombre = leer_palabra() in
          match nombre with
          | "EXIT" -> []
          | _ ->  let j = crear_jugador nombre in
                  j :: cargar_jugadores (i-1);;


let crear_mesa unit : mesa =
  let j = cargar_jugadores 5 in
  let c = mazo_completo() in
  {jugadores=j; mazo=c};;

let jugar_ronda (m : mesa) : mesa =;;

let ganador_ronda (m : mesa) : jugador =
  ;;

let limpiar_mesa (m : mesa) : mesa =
  (*quitar carta jugada*)
  let rec limpiar (js : jugador list) : jugador list = function
    | [] -> []
    | x::xs -> (jugador_limpiar_carta x) :: limpiar xs;;
  {m with jugadores=limpiar m.jugadores};;

let cantidad_jugadores (m : mesa) : int =
  (*contar la cantidad de jugadores jugando*)
  let rec contar (js : jugadores list) : int = function
    | [] -> 0
    | x::xs -> if jugador_quedan_cartas x then 1 + contar xs else contar xs;;
  contar m.jugadores;;

let () =
  let m = crear_mesa;;
