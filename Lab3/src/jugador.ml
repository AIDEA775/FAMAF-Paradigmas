open Cartas
open Varios

type jugador = {nombre : string; puntos : int; mano : carta; mazo : cartas};;

let crear_jugador (n : string) (c : cartas) : jugador * cartas =
  let m = crear_mazo c in
  ({nombre=n ; mano=None; mazo=m}, (sacar_cartas c m));;

let jugador_puntos (j : jugador) : int = j.puntos;;

let jugador_suma_punto (j : jugador) : jugador = {j with puntos=j.puntos+1};;

let jugador_imprimir_ronda (j : jugador) : unit =
  let open Printf in
  if j.mano != None then printf "%s: %s\n" (j.nombre) (imprimir_mazo [j.carta]);;

let rec jugador_juega (j : jugador) (cs : cartas) : jugador * cartas =
  (* imprime por stdout "<Nombre>(<Puntos>): <Cartas disponibles>/n<Pregunta>" *)
  let imprimir_estado unit : unit =
    let open Printf in
    printf "%s(%d): %s\nQue carta vas a jugar Ti? " (j.nombre) (j.puntos) (imprimir_mazo j.mazo)
  in
  imprimir_estado();
  let s = leer_palabra() in
  let c = string_a_carta j.mazo c in
  (* sacar carta del mazo cs y guardar en el mazo del jugador
      mazo general -> mazo del jugador -> general * jugador *)
  let robar (cs : cartas) (m : cartas): cartas * cartas =
    let c = primer_carta cs in (* ver carta del mazo general *)
    let cs = sacar_cartas cs [c] in (* quitar la carta del mazo genera*)
    let m = poner_cartas m [c] in (* guardarla en el mazo del jugador *)
    (cs, m)
  in
  let jugar_comun (j : jugador) (cs : cartas) : jugador * cartas =
    let m = sacar_cartas j.mazo [c] in (* tirar carta *)
    let cs, m = robar cs m in (* levantar del mazo general *)
    ({j with mano = c; mazo = m}, cs)
  in
  if c = [] then
    jugador_juega j cs
  else jugar_comun();;

  (* juega carta especial y luego juega una comun *)
  (*let jugar_especial : jugador * cartas =
    match s with
    | "SID" ->  let m = sacar_cartas j.mazo c in
                let cs, m = robar cs m in
                jugar_comun {j with mazo = m} cs
  in
    | "SWAP" -> jugar_comun {j with mazo = cs} m
    | "SMAX" -> let max = carta_maxima cs in
                let cs = sacar_cartas [max] in
                let m = poner_cartas m [max] in
                jugar_comun {j with mazo = m} cs
    | "SMIN" -> let min = carta_minima m in
    | "STOP" -> expr2
    | "SPAR" -> expr2;*)

let jugador_carta_jugada (j : jugador) : carta = j.mano;;

let jugador_quedan_cartas (j : jugador) : bool = cartas_cantidad j.mazo != 0;;

let jugador_limpiar_carta (j : jugador) : jugador = {j with mano=[]};;
