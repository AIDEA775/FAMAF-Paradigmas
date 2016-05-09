type carta
type cartas = carta list


(* crea un mazo de 7 cartas para un jugador
   se le pasa el mazo general para sacar cartas de ahí *)
val crear_mazo : cartas -> cartas

(* devuelve el mazo entero mezclado //*)
val mazo_completo : unit -> cartas


(* devuelve la carta segun un string
    si es invalida o no se encuentra en cartas devuelve None *)
val carta_of_string : cartas -> string -> carta option

(* devuelve el string de la carta *)
val string_of_carta : carta -> string

(* devuelve un string con las cartas separadas por un espacio *)
val string_of_cartas : cartas -> string


(* saca cartas de un mazo y devuelve el mazo restante
  mazo -> cartas a sacar -> resultado *)
val sacar_cartas : cartas -> cartas -> cartas

(* si pone las cartas al ultimo no seria necesario "poner_ultimo"
  mazo -> cartas a poner -> resultado //*)
val poner_cartas : cartas -> cartas -> cartas


(* devuelve la primera carta del mazo *)
val primera_carta : cartas -> carta option

(* devuelve la carta mas grande *)
val carta_maxima : cartas -> carta option

(* devuelve la carta mas chica *)
val carta_minima : cartas -> carta option

(* devuelve las cartas que son pares *)
val cartas_pares : cartas -> cartas

(* devuelve la cantidad de cartas *)
val cartas_cantidad : cartas -> int

val es_especial : carta -> bool
