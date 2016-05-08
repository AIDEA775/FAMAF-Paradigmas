open Mesa

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
let iniciar_batalla unit : unit =
  let mesa = crear_mesa() in
  let mesa = clavar_espadas mesa in
  imprimir_resultados mesa;;

let () =
  iniciar_batalla();;
