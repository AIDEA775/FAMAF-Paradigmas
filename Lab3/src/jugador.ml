open Cartas

type jugador = {nombre : string; puntos : int; mano : carta; mazo : cartas};;

let crear_jugador (n : string) (c : cartas) : jugador * cartas =
  let m = crear_mazo c in
  ({nombre=n ; carta=None; mazo=m}, (sacar_cartas c m));;

let jugador_puntos (j : jugador) : int = j.puntos;;

let jugador_suma_punto (j : jugador) : jugador = {j with puntos=j.puntos+1};;

let jugador_imprimir_ronda (j : jugador) : unit =
  let open Printf in
  if j.mano != None then printf "%s: %s\n" (j.nombre) (imprimir_mazo [j.carta]);;

let jugador_imprimir_estado (j : jugador) : unit =
  let open Printf in
  printf "%s(%d): %s\n" (j.nombre) (j.puntos) (imprimir_mazo [j.mazo]);;

let jugador_juega (j : jugador) (c : cartas) : jugador * cartas =

let jugador_carta_jugada (j : jugador) : carta = j.mano;;

let jugador_quedan_cartas (j : jugador) : bool = cartas_cantidad j.mazo != 0;;

let jugador_limpiar_carta (j : jugador) : jugador = {j with mano=None};;
