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
    | _ ->  titulo();
            set_pos 0 4;
            printf "\tIngrese el nombre del jugador\n\t EXIT para comenzar el juego:";
            set_pos 12 (12-i);
            let nombre = leer_palabra() in
            match nombre with
            | "EXIT" -> ([], cs)
            | "BETA" -> raise Not_found
            | _ ->  limpiar();
                    set_pos 0 (12-i);
                    printf "  JOIN >>> %s" nombre;
                    let j, cs = crear_jugador nombre cs in
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
            set_pos 0 8;
            printf "\tEs turno de %s." (jugador_nombre (at i js));
            leer_nada();
            limpiar();
            titulo();
            printf "\tMazo: %d cartas\n\tRonda:\n" (cartas_cantidad cs);
            List.iter jugador_imprimir_ronda (List.rev js);
            let j, cs = jugador_juega (at i js) cs in
            jugar (insert j i (remove i js)) cs (i-1)
  in
  limpiar();
  set_pos 0 8;
  print_string "\tEmpieza una nueva ronda.";
  leer_nada();
  let js, c = jugar m.jugadores m.mazo (List.length m.jugadores - 1) in
  {jugadores = js; mazo = c};;

let ganador_ronda (m : mesa) : mesa =
  let carta (c : carta option) : carta  =
    match c with
    | None -> assert false
    | Some c -> c
  in
  let ganador (j : jugador) : jugador =
    limpiar();
    set_pos 0 8;
    printf "\tEl jugador %s gano la ronda." (jugador_nombre j);
    leer_nada();
    jugador_suma_punto j
  in
  let rec actualizar (js : jugador list) (c : carta) : jugador list =
    match js with
    | [] -> []
    | x::xs ->  let cj = jugador_carta_jugada x in
                match cj with
                | None -> x :: (actualizar xs c)
                | Some cj ->  if cj = c then (ganador x) :: xs
                              else x :: (actualizar xs c)
  in
  let c = List.map jugador_carta_jugada m.jugadores in
  let c = List.filter (fun x -> not (x = None)) c in
  let c = List.map carta c in
  let c = carta_maxima c in
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
  let js = List.sort (fun x y -> (jugador_puntos y)-(jugador_puntos x)) m.jugadores in
  limpiar();
  titulo();
  set_pos 0 4;
  printf "\t\tGAME OVER\n\t       Posiciones:\n\n";
  List.iter imprimir js;
  leer_nada();;
