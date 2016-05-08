open Jugador
open Cartas
open Varios
open Printf

type mesa = {jugadores : jugador list; mazo : cartas};;

let crear_mesa unit : mesa =
  (* carga y devuelve jugadores y las cartas que sobran *)
  let rec cargar_jugadores (i : int) (cs : cartas) : jugador list * cartas =
    match i with
    | 0 -> ([], cs)
    | _ ->  limpiar();
            printf "  Ingrese el nombre del jugador o EXIT para comenzar el juego:\n\n\t";
            let nombre = leer_palabra() in
            match nombre with
            | "EXIT" -> ([], cs)
            | _ ->  let j, cs = crear_jugador nombre cs in
                    let js, cs = cargar_jugadores (i-1) cs in
                    (List.append js [j], cs)
  in
  let js, cs = cargar_jugadores 5 (mazo_completo()) in
  {jugadores = js; mazo = cs};;

let jugar_ronda (m : mesa) : mesa =
  (* juega una ronda y devuelve los nuevos jugadores y el nuevo mazo *)
  let rec jugar (js : jugador list) (cs : cartas) (i : int) : jugador list * cartas =
    match i with
    | -1 -> (js, cs)
    | _ ->  limpiar();
            printf "\tMazo: %d cartas\n\tRonda:\n" (cartas_cantidad cs);
            List.iter jugador_imprimir_ronda (List.rev js);
            let j, cs = jugador_juega (at i js) cs in
            jugar (insert j i (remove i js)) cs (i-1)
  in
  let js, c = jugar m.jugadores m.mazo (List.length m.jugadores - 1) in
  {jugadores = js; mazo = c};;

let ganador_ronda (m : mesa) : mesa =
  let ganador (j : jugador) : jugador =
    limpiar();
    printf "\tEl jugador %s gano la ronda.\n\n\n\n" (jugador_nombre j);
    leer_nada();
    jugador_suma_punto j
  in
  let rec actualizar (js : jugador list) (c : carta) : jugador list =
    match js with
    | [] -> []
    | x::xs ->  if jugador_carta_jugada x = c then (ganador x) :: xs
                else x :: (actualizar xs c)
  in
  let c = List.map jugador_carta_jugada m.jugadores in
  let c = carta_maxima(c) in
  match c with
  | None -> assert false
  | Some c -> {m with jugadores = actualizar m.jugadores c};;

let limpiar_mesa (m : mesa) : mesa =
  {m with jugadores = List.map jugador_limpiar_carta  m.jugadores};;

let cantidad_jugadores (m : mesa) : int =
  let rec contar (js : jugador list) : int =
    match js with
    | [] -> 0
    | x::xs -> if jugador_quedan_cartas x then 1 + contar xs else contar xs
  in
  contar m.jugadores;;

let imprimir_resultados (m : mesa) : unit =
  let imprimir (j : jugador) : unit =
    printf "\t\t%s  %d\n\n" (jugador_nombre j) (jugador_puntos j)
  in
  let js = List.sort (fun x y -> (jugador_puntos x) - (jugador_puntos y)) m.jugadores in
  printf "\t\tGAME OVER\n\t\tPosiciones:\n\n";
  List.iter imprimir js;
  leer_nada();
  printf ":)"
  ;;
