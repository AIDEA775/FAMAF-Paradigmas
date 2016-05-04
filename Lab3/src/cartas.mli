(* Una carta*)
type carta

(*Una lista de tipo carta*)
type cartas

val cartas_nueva : unit -> cartas

val cartas_agregar : cartas -> carta -> cartas

val cartas_sacar : cartas -> cartas

val cartas_top : cartas -> carta

(*lo demas*)
