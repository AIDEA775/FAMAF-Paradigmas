open Jugador
open Cartas

type juego = {mazo : cartas; jugadores : jugador list};;
type resultado = CONTINUAR | PIERDE of jugador | GANA of jugador;;

let limpiar () = print_string "\x1B[2J";;

let rec cargar_jugadores j =
  let read = read_line() in
  if String.length read = 0 then
    cargar_jugadores j
  else
    match read with
    | "EXIT" when (2 <= List.length j && List.length j <= 5) -> j
    | "EXIT" -> []
    | _ -> cargar_jugadores ((jugador_nuevo read) :: j);;

let set_pos (x,y) =
  print_string ("\x1b[" ^ string_of_int y ^ ";" ^ string_of_int x ^ "H");;

let rec ronda () =
  let s = read_line() in
  if String.length s = 0 then
    ronda()
  else
    match s.[0] with
    | 'w' -> CONTINUAR
    | 's' -> PIERDE (jugador_nuevo "hola")
    | 'a' -> GANA (jugador_nuevo "chau")
    | _ -> ronda();;

let rec correr_juego juego =
  limpiar();
  let resultado = ronda() in
  match resultado with
  | CONTINUAR -> correr_juego juego
  | PIERDE jugador -> print_endline ("pierde " ^ (jugador_nombre jugador))
  | GANA jugador -> print_endline ("gana " ^ (jugador_nombre jugador))
  | _ -> correr_juego juego;;

(*let iniciar_juego = {mazo=cartas_nuevo_mazo ; jugadores=cargar_jugadores []};;*)
let iniciar_juego = {mazo=cartas_nueva() ; jugadores=cargar_jugadores []};;

(* Main *)
let () =
  let juego = iniciar_juego in
  correr_juego juego;;
