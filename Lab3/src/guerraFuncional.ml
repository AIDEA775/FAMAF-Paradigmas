open Mesa
open Varios
open Interfaz

(* jugar una completa con interfaz y todo *)
let lanzar_lanza (m : mesa) : mesa =
  let m = jugar_ronda m in
  let m = ganador_ronda m in
  limpiar_mesa m;;

(* jugar rondas hasta que no queden jugadores *)
let rec clavar_espadas (m : mesa) : mesa =
  if cantidad_jugadores m < 2 then m
  else clavar_espadas(lanzar_lanza m);;

(* jugar una partida y proximamente reiniciar *)
let rec iniciar_batalla unit : unit =
  limpiar();
  set_pos 0 5;
  let mesa = crear_mesa() in
  let mesa = clavar_espadas mesa in
  imprimir_resultados mesa;
  limpiar();
  titulo();
  print_string "\n\n\t\tREINICIAR ¿? ";
  let r = leer_palabra() in
  if r = "S" || r = "s" then iniciar_batalla();;

let () =
  Random.self_init();
  try
    iniciar_batalla();
    set_pos 0 0;
    limpiar()
  with
  | Not_found -> limpiar_interfaz();
                set_pos 0 0;
                limpiar();;
