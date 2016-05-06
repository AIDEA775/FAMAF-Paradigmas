type cartas

type carta

val crear_mazo : unit -> cartas

val mazo_completo : unit -> cartas

val sacar_cartas : cartas -> cartas -> cartas

val poner_cartas : cartas -> cartas -> cartas

val imprimir_mazo : cartas -> unit

val string_a_carta : string -> carta

val carta_maxima : cartas -> carta

val carta_minima : cartas -> carta

val poner_ultimo : carta -> cartas -> cartas

val primer_carta : cartas -> carta  

val cartas_pares : cartas -> cartas


