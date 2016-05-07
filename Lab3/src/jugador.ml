open Cartas
open Varios

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


(* en realidad, hace muchas cosas
lee la stdin la opcion del usuario
se fija si es una carta valida
si no es así vuelve a empezar
si es valida, se fija la clase de carta
si es comun la pone en la mano, la quita de su mazo, y devuelve el jugador y el nuevo mazo general
si es especial, se fija que hace, lo hace, y vuelve a empezar === despues borrá esto*)
let rec jugador_juega (j : jugador) (cs : cartas) : jugador * cartas =
  (* sacar carta del mazo cs y guardar en el mazo del jugador
      mazo general -> mazo del jugador -> general * jugador *)
  let robar (cs : cartas) (m : cartas): cartas * cartas =
    let c = primer_carta cs in
    let cs = sacar_cartas cs [c] in
    let m = poner_cartas m [c] in
    (cs, m)
  in
  let s = leer_palabra() in
  let c = string_a_carta c in
  if c = None then jugador_juega j cs
  else
    begin
      let cs, m = robar cs j.mazo in
      if not es_especial c then
        begin
          ({j with mano = c; mazo = m}, cs)
        end
      else
        match s with
        | "SID" -> jugador_juega {j with mazo = m} cs
        | "SWAP" -> jugador_juega {j with mazo = cs} m
        | "SMAX" -> let max = carta_maxima cs in
                    let cs = sacar_cartas [max] in
                    let m = poner_cartas m [max] in
                    jugador_juega {j with mazo = m} cs
        | "SMIN" -> let min = carta_minima m in
                    (* me quedé acá, el tema es cuando robar, donde y como
                      antes de la llamada recursiva parece lo logico pero
                      hay una carta nueva que el jugador no sabe que tiene
                      quiza no sea buena idea hacer esta funcion recursiva *)
        | "STOP" -> expr2
        | "SPAR" -> expr2;
    end


let jugador_carta_jugada (j : jugador) : carta = j.mano;;

let jugador_quedan_cartas (j : jugador) : bool = cartas_cantidad j.mazo != 0;;

let jugador_limpiar_carta (j : jugador) : jugador = {j with mano=None};;
