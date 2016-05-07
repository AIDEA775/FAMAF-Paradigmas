type mesa

val crear_mesa : unit -> mesa

val jugar_ronda : mesa -> mesa

val ganador_ronda : mesa -> mesa * jugador

val limpiar_mesa : mesa -> mesa

val cantidad_jugadores : mesa -> int
