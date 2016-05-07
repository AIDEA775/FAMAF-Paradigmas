type jugador

val crear_jugador : string -> jugador

val jugador_puntos : jugador -> int

val jugador_suma_punto : jugador -> jugador

val jugador_imprimir_ronda : jugador -> unit

val jugador_imprimir_estado : jugador -> unit

val jugador_juega : cartas -> jugador -> cartas * jugador

val jugador_carta_jugada : jugador -> carta

val jugador_quedan_cartas : jugador -> bool

val jugador_limpiar_carta : jugador -> jugador
