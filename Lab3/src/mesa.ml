open Jugadores
open Cartas

type mesa = {jugadores : jugador list; mazo : cartas};;

let crear_mesa unit : mesa =
  (* carga y devuelve jugadores y las cartas que sobran *)
  let rec cargar_jugadores (i : int) (c : cartas) : jugador list * cartas =
    match i with
    | 0 -> []
    | _ ->  let nombre = leer_palabra() in
            match nombre with
            | "EXIT" -> []
            | _ ->  let j, c = crear_jugador nombre c in
                    let js, c = cargar_jugadores (i-1) c in
                    (j :: js, c)
  in
  let j, c = cargar_jugadores 5 mazo_completo() in
  {jugadores = j; mazo = c};;

(*falta imprimir cosas :P*)
let jugar_ronda (m : mesa) : mesa =
  (* juega una ronda y devuelve los nuevos jugadores y el nuevo mazo *)
  let rec jugar (js : jugador list) (cs : cartas) : jugador list * cartas =
    match js with
    | [] -> ([], cs)
    | x::xs ->  let nuevo_j, cs = jugador_juega x cs in
                let nuevos_js, cs = jugar xs cs in
                (nuevo_j :: nuevos_js, cs)
  in
  let js, c = jugar m.jugadores m.mazo in
  {m with jugadores = js; mazo = c};;

let ganador_ronda (m : mesa) : mesa * jugador =
  (* crear lista de cartas jugadas *)
  let rec cartas_jugadas (js : jugador list) : cartas =
    match js with
    | [] -> []
    | x::xs -> (jugador_carta_jugada x) :: cartas_jugadas xs
  in
  (* devuelve el jugador que jugó esa carta*)
  let rec buscar_jugador (js : jugador list) (carta : carta) : jugador =
    match js with
    | [x] -> x (* tiene que ser *)
    | x::xs -> if (jugador_carta_jugada x) = carta then x else buscar_jugador xs carta
  in
  (* actualiza los jugadores sumando un punto a j*)
  let rec actualizar (js : jugador list) (j : jugador) : jugador list =
    match js with
    | [x] -> jugador_suma_punto x (*tiene que ser*)
    | x::xs -> if x = j then (jugador_suma_punto x) :: xs else x :: (actualizar js j)
  in
  let carta = carta_maxima (cartas_jugadas m.jugadores) in
  let j = buscar_jugador m.jugadores carta in
  ({m with jugadores = actualizar m.jugadores j}, (jugador_suma_punto j));;

let limpiar_mesa (m : mesa) : mesa =
  (*quitar carta jugada*)
  let rec limpiar (js : jugador list) : jugador list =
    match js with
    | [] -> []
    | x::xs -> (jugador_limpiar_carta x) :: limpiar xs
  in
  {m with jugadores = limpiar m.jugadores};;

let cantidad_jugadores (m : mesa) : int =
  (*contar la cantidad de jugadores jugando*)
  let rec contar (js : jugadores list) : int =
    match js with
    | [] -> 0
    | x::xs -> if jugador_quedan_cartas x then 1 + contar xs else contar xs
  in
  contar m.jugadores;;

let () =
  let m = crear_mesa;;
