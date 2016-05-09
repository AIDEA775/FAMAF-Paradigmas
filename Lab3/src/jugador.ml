open Cartas
open Varios

type jugador = {nombre : string; puntos : int; mano : carta option; mazo : cartas};;

let crear_jugador (n : string) (c : cartas) : jugador * cartas =
  let m = crear_mazo c in
  ({nombre = n; puntos = 0; mano = None; mazo = m}, (sacar_cartas c m));;

let jugador_puntos (j : jugador) : int = j.puntos;;

let jugador_nombre (j : jugador) : string = j.nombre;;

let jugador_suma_punto (j : jugador) : jugador = {j with puntos = j.puntos + 1};;

let jugar_especial (j : jugador) (cs : cartas) (c : carta) =
  let str = la_carta_especial(c) in 
    match str with
    | "ID" ->  let m = sacar_cartas j.mazo c in
                  let cs, m = robar cs m in
                  jugador_juega{j with mazo = m} cs

    | "SWAP" -> jugador_juega {j with mazo = cs} m

    | "MAX" -> let max = carta_maxima cs in
                 let cs = sacar_cartas cs max in
                 let m = poner_cartas m max in
                 jugador_juega {j with mazo = m} cs

    | "MIN" -> let min = carta_minima j.mazo in
                  let cs = poner_cartas cs min in
                  let c = sacar_cartas cs in
                  let m = poner_cartas j.mazo c in
                  jugador_juega {j with mazo = m} cs

    | "TOP" -> let c = primera_carta cs in
                  let cs = sacar_cartas cs c in
                  let m = poner_cartas j.mazo c in
                  jugador_juega {j with mazo = m} cs

    | "PAR" ->let p = cartas_pares cs in
                  let cs = sacar_cartas cs p in
                  let m = poner_cartas p j.mazo in
                  jugador_juega {j with mazo = m} cs;;

let jugador_imprimir_ronda (j : jugador) : unit =
  let open Printf in
  match j.mano with
  | None -> printf ""
  | Some c -> printf "\t%s  %s\n" (j.nombre) (string_of_carta c);;

let rec jugar (j : jugador) (cs : cartas) : jugador * cartas =
  let s = leer_palabra() in
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
                (cs, m)
  in
  let jugar_comun (j : jugador) (cs : cartas) (c : carta) : jugador * cartas =
    (* tirar carta *)
    let m = sacar_cartas j.mazo [c] in
    (* levantar del mazo general *)
    let cs, m = robar cs m in
    ({j with mano = (Some c); mazo = m}, cs)
  in
    let c = carta_of_string j.mazo s in
    match c with
    | None -> print_string "\t  Vuelve a intentar: ";
              jugar j cs
    | Some c -> jugar_comun j cs c;;
                match r with
                | true -> jugar_especial j cs c
                | false -> jugar j cs;;
  (* juega carta especial y luego juega una comun *)

let jugador_juega (j : jugador) (cs : cartas) : jugador * cartas =
  let open Printf in
  set_pos 0 11;
  printf "\t%s(%d): %s\n\tQue carta vas a jugar %s? "
    (j.nombre) (j.puntos) (string_of_cartas j.mazo) (j.nombre);
  jugar j cs;;

let jugador_carta_jugada (j : jugador) : carta =
  match j.mano with
  | None -> assert false
  | Some c -> c;;

let jugador_quedan_cartas (j : jugador) : bool = (cartas_cantidad j.mazo) != 0;;

let jugador_limpiar_carta (j : jugador) : jugador = {j with mano = None};;
