type jugador

(* nuevo jugador a partir de string
    crear mazo a partir de cartas disponibles
    devolver jugador y las cartas que quedaron *)
val crear_jugador : string -> cartas -> jugador

(* devuelve puntos *)
val jugador_puntos : jugador -> int

(* devuelve el mismo jugador pero con un punto más *)
val jugador_suma_punto : jugador -> jugador

(* imprime por std "<Nombre>: <Carta Jugada>" *)
val jugador_imprimir_ronda : jugador -> unit

(* imprime por std "<Nombre>(<Puntos>): <Cartas disponibles>" *)
val jugador_imprimir_estado : jugador -> unit

(* en realidad, hace muchas cosas*)
val jugador_juega : jugador -> cartas -> jugador * cartas

(* llamar solo despues de haber jugado una ronda *)
val jugador_carta_jugada : jugador -> carta

(* false si ya no le quedan cartas *)
val jugador_quedan_cartas : jugador -> bool

(* quita la carta jugada para empezar nueva ronda *)
val jugador_limpiar_carta : jugador -> jugador
