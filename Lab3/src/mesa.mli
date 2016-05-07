type mesa

(* crear una mesa pa' jugá *)
val crear_mesa : unit -> mesa

(* cada jugador va a jugar su turno *)
val jugar_ronda : mesa -> mesa

(* se busca, se actualizan y se imprimen los puntos del jugador ganador *)
val ganador_ronda : mesa -> mesa

(* quitar las cartas jugadas en la mesa *)
val limpiar_mesa : mesa -> mesa

(* devuelve la cantidad de jugadores que siguen jugando *)
val cantidad_jugadores : mesa -> int
