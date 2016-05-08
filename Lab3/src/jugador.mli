type jugador

open Cartas

(* nuevo jugador a partir de string
    crear mazo a partir de cartas disponibles
    devolver jugador y las cartas que quedaron *)
val crear_jugador : string -> cartas -> jugador

(* devuelve puntos *)
val jugador_puntos : jugador -> int

(* devuelve el nombre *)
val jugador_nombre : jugador -> string

(* devuelve el mismo jugador pero con un punto más *)
val jugador_suma_punto : jugador -> jugador

(* imprime por stdout "<Nombre>: <Carta Jugada>" *)
val jugador_imprimir_ronda : jugador -> unit

(* en realidad, hace muchas cosas
    imprime su estado y la pregunta
    lee la stdin la opcion del usuario
    se fija si es una carta valida
    si no es así vuelve a empezar
    si es valida, se fija la clase de carta
    si es comun la pone en la mano, la quita de su mazo, y devuelve el jugador y el nuevo mazo general
    si es especial, se fija que hace, lo hace, y vuelve a empezar*)
val jugador_juega : jugador -> cartas -> jugador * cartas

(* llamar solo despues de haber jugado una ronda *)
val jugador_carta_jugada : jugador -> carta

(* false si ya no le quedan cartas *)
val jugador_quedan_cartas : jugador -> bool

(* quita la carta jugada para empezar nueva ronda *)
val jugador_limpiar_carta : jugador -> jugador
