open Jugador
open Cartas

type juego = {mazo : cartas; jugadores : jugador list};;
type resultado = CONTINUAR | PIERDE of jugador | GANA of jugador;;

let limpiar () = print_string "\x1B[2J";;

let set_pos (x,y) =
  print_string ("\x1b[" ^ string_of_int y ^ ";" ^ string_of_int x ^ "H");;

let imprimir_turno (j : jugador) (juego : juego) =
  let open printf in

  let rec imprimir_ronda (l : jugador list) = function
    | [] -> None
    | x::xs -> printf "%s\n" (jugador_nombre x); imprimir_ronda xs

  printf "Mazo: %d cartas\n" List.length juego.mazo
  printf "Ronda:\n"
  imprimir_ronda juego.jugadores
  printf "%s(%d):" (jugador_nombre j) (jugador_puntos j)
  jugador_imprimir_cartas j
  printf "Que carta vas a jugar %s?" (jugador_nombre j)


let rec at k = function
  | [] -> None
  | x::xs -> if k = 1 then Some h else at (k-1) xs;;

let rec cargar_jugadores j =
  let read = read_line() in
  if String.length read = 0 then
    cargar_jugadores j
  else
    match read with
    | "EXIT" when (2 <= List.length j && List.length j <= 5) -> j
    | "EXIT" -> []
    | _ -> cargar_jugadores ((jugador_nuevo read) :: j);;

let turno (juego : juego) (i : int) : juego =
  let jugador = at i juego.jugadores in
  let imprimir_turno jugador juego = in
  let s = read_line() in
  if String.length s = 0 then
    turno()
  else
    match s.[0] with
    | 'w' -> CONTINUAR
    | 's' -> PIERDE (jugador_nuevo "hola")
    | 'a' -> GANA (jugador_nuevo "chau")
    | _ -> ronda();;

(*for jugador in juego.jugadores do turno jugador*)
let rec rondas (juego : juego) (turno : int) : juego =
  match turno with
  | List.length juego.jugadores -> juego
  | _ -> let juego=turno juego turno in rondas juego turno+1;;

let rec correr_juego (juego : juego) =
  limpiar();
  let juego = rondas juego 0 in
(*  let resultado = ronda juego in
  match resultado with
  | CONTINUAR -> correr_juego juego
  | PIERDE jugador -> print_endline ("pierde " ^ (jugador_nombre jugador))
  | GANA jugador -> print_endline ("gana " ^ (jugador_nombre jugador))
  | _ -> correr_juego juego;;*)

let iniciar_juego = {mazo=cartas_mazo; ronda=[]; jugadores=cargar_jugadores []};;

(* Main *)
let () =
  let juego = iniciar_juego in
  correr_juego juego;;
