open Cartas
open Varios

type jugador = {nombre : string; puntos : int; mano : carta option; mazo : cartas};;

let crear_jugador (n : string) (c : cartas) : jugador * cartas =
  let m = crear_mazo c in
  ({nombre = n; puntos = 0; mano = None; mazo = m}, (sacar_cartas c m));;

let jugador_puntos (j : jugador) : int = j.puntos;;

let jugador_nombre (j : jugador) : string = j.nombre;;

let jugador_suma_punto (j : jugador) : jugador = {j with puntos = j.puntos + 1};;

let jugador_imprimir_ronda (j : jugador) : unit =
  let open Printf in
  match j.mano with
  | None -> printf ""
  | Some c -> printf "\t%s  %s\n" (j.nombre) (string_of_carta c);;


(* sacar carta del mazo cs y guardar en el mazo del jugador
    mazo general -> mazo del jugador -> general * jugador *)
let robar (cs : cartas) (m : cartas): cartas * cartas =
  let c = primera_carta cs in (* ver carta del mazo general *)
  match c with
  | None -> (cs, m)
  | Some c -> (* quitar la carta del mazo genera*)
              let cs = sacar_cartas cs [c] in
              (* guardarla en el mazo del jugador *)
              let m = poner_cartas m [c] in
              (cs, m);;

let jugar_comun (j : jugador) (cs : cartas) (c : carta) : jugador * cartas =
  (* tirar carta *)
  let m = sacar_cartas j.mazo [c] in
  (* levantar del mazo general *)
  let cs, m = robar cs m in
  ({j with mano = (Some c); mazo = m}, cs);;

let imprimir_estado (j : jugador) : unit =
  limpiar_linea 0 11;
  Printf.printf "\t%s(%d): %s\n"
    (j.nombre) (j.puntos) (string_of_cartas j.mazo);;

let rec jugar (j : jugador) (cs : cartas) : jugador * cartas =
  limpiar_linea 0 11;
  imprimir_estado j;
  limpiar_linea 0 13;
  print_string "\t>>>       <<<";
  set_pos 13 13;
  let s = leer_palabra() in
  let c = carta_of_string j.mazo s in
  match c with
  | None -> limpiar_linea 0 12;
            print_string "\tVuelve a intentar.";
            jugar j cs
  | Some c -> if es_especial c then jugar_especial j cs c
              else jugar_comun j cs c
and jugar_especial (j : jugador) (cs : cartas) (c : carta) : jugador * cartas =
  let s = string_of_carta c in
  let m = sacar_cartas j.mazo [c] in
  limpiar_linea 0 12;
  print_string "\tJugaste una especial!";
  match s with
  | "SID" -> let cs, m = robar cs m in
            jugar {j with mazo = m} cs

  | "SSWAP" -> let cs, m = robar m cs in (* m es el nuevo mazo general *)
              jugar {j with mazo = m} cs

  | "SMAX" -> let max = carta_maxima cs in
             (match max with
             | None -> jugar j cs (* no quedan cartas en el mazo general *)
             | Some max -> let cs = sacar_cartas cs [max] in
                           let m = poner_cartas m [max] in
                           jugar {j with mazo = m} cs)

  | "SMIN" ->  let min = carta_minima m in
              (match min with
              | None -> jugar j cs (* no le quedan mas cartas comunes *)
              | Some min -> let cs = poner_cartas cs [min] in
                            let cs, m = robar cs m in
                            jugar {j with mazo = m} cs)

  | "STOP" ->  let cs, m = robar cs m in
              let cs, m = robar cs m in
              jugar {j with mazo = m} cs

  | "SPAR" ->  let p = cartas_pares cs in
              let cs = sacar_cartas cs p in
              let m = poner_cartas m p in
              jugar {j with mazo = m} cs
  | _ -> assert false;;

let jugador_juega (j : jugador) (cs : cartas) : jugador * cartas =
  imprimir_estado j;
  Printf.printf "\tQue carta vas a jugar %s? " (j.nombre);
  jugar j cs;;

let jugador_carta_jugada (j : jugador) : carta =
  match j.mano with
  | None -> assert false
  | Some c -> c;;

let jugador_quedan_cartas (j : jugador) : bool = (cartas_cantidad j.mazo) != 0;;

let jugador_limpiar_carta (j : jugador) : jugador = {j with mano = None};;
