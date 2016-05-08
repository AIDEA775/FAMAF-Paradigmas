type cartas

type carta

(* (a) devuelve un mazo de cartas vacio
   (b) crea un mazo de 7 cartas para un jugador
  con (a) jugador deberia generar su mazo
  con (b) deberia pasarte el mazo general para que saques cartas de ahí
  decidí *)
val crear_mazo : cartas -> cartas

(*ja!*)
val mazo : carta -> cartas

val mazo_lista : carta list -> cartas

(* je *)
val mazo_vacio : unit -> cartas

(* devuelve el mazo entero mezclado //*)
val mazo_completo : unit -> cartas

(* devuelve la carta segun un string
    si es invalida o no se encuentra en cartas devuelve None o lo que sea *)
val string_a_carta : cartas -> string -> carta

(* saca cartas de un mazo y devuelve el mazo restante
  mazo -> cartas a sacar -> resultado *)
val sacar_cartas : cartas -> cartas -> cartas

(* si pone las cartas al ultimo no seria necesario "poner_ultimo"
  mazo -> cartas a poner -> resultado //*)
val poner_cartas : cartas -> cartas -> cartas

(* devuelve la primera carta del mazo //*)
val primer_carta : cartas -> carta

(* imprimir por std las cartas separadas por un espacio *)
val imprimir_mazo : cartas -> string

(* devuelve la carta mas grande *)
val carta_maxima : cartas -> carta

(* devuelve la carta mas chica *)
val carta_minima : cartas -> carta

(* devuelve las cartas que son pares *)
val cartas_pares : cartas -> cartas

val cartas_cantidad : cartas -> int
