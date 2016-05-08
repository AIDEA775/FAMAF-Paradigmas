open Jugador
open Cartas
open Varios

type mesa = {jugadores : jugador list; mazo : cartas};;

let crear_mesa unit : mesa =
  (* carga y devuelve jugadores y las cartas que sobran *)
  let rec cargar_jugadores (i : int) (cs : cartas) : jugador list * cartas =
    match i with
    | 0 -> ([], cs)
    | _ ->  let nombre = leer_palabra() in
            match nombre with
            | "EXIT" -> ([], cs)
            | _ ->  let j, cs = crear_jugador nombre cs in
                    let js, cs = cargar_jugadores (i-1) cs in
                    (j :: js, cs)
  in
  let js, cs = cargar_jugadores 5 (mazo_completo()) in
  {jugadores = js; mazo = cs};;

(*falta imprimir cosas :P*)
let jugar_ronda (m : mesa) : mesa =
  (* juega una ronda y devuelve los nuevos jugadores y el nuevo mazo *)
  let rec jugar (js : jugador list) (cs : cartas) : jugador list * cartas =
    match js with
    | [] -> ([], cs)
    | x::xs ->  let open Printf in
                printf "Mazo: %d cartas\nRonda:\n" (cartas_cantidad cs);
                List.iter jugador_imprimir_ronda m.jugadores;
                let nuevo_j, cs = jugador_juega x cs in
                let nuevos_js, cs = jugar xs cs in
                (nuevo_j :: nuevos_js, cs)
  in
  let js, c = jugar m.jugadores m.mazo in
  {jugadores = js; mazo = c};;

let ganador_ronda (m : mesa) : mesa =
  (* imprimir que js ganó la ronda*)
  let ganador (j : jugador) : jugador =
    let open Printf in
    printf "El jugador %s gano la ronda." (jugador_nombre j);
    jugador_suma_punto j
  in
  (* actualiza los jugadores sumando un punto al que jugó c y lo imprime*)
  let rec actualizar (js : jugador list) (c : carta) : jugador list =
    match js with
    | [] -> [] (* no, pero si el compilador quiere *)
    | [x] -> [ganador x] (* tiene que ser *)
    | x::xs -> if jugador_carta_jugada x = mazo c then (ganador x) :: xs else x :: (actualizar xs c)
  in
  let cs = List.map jugador_carta_jugada m.jugadores in
  let c = carta_maxima(mazo_lista cs) in
  {m with jugadores = actualizar m.jugadores c};;

let limpiar_mesa (m : mesa) : mesa =
  {m with jugadores = List.map jugador_limpiar_carta  m.jugadores};;

let cantidad_jugadores (m : mesa) : int =
  (*contar la cantidad de jugadores jugando*)
  let rec contar (js : jugador list) : int =
    match js with
    | [] -> 0
    | x::xs -> if jugador_quedan_cartas x then 1 + contar xs else contar xs
  in
  contar m.jugadores;;

let imprimir_resultados (m : mesa) : unit =
    let open Printf in
    printf "hola que hace";;
